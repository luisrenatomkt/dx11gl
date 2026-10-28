// opengl32.dll "passthrough" instrumentado (Etapas 5a/5b). NAO traduz nada para Direct3D 11.
// 5a: provar que o LWJGL 2 do Minecraft 1.8.9 usa esta DLL no lugar do opengl32 do Windows.
// 5b: contar TODAS as chamadas GL, inclusive as obtidas via wglGetProcAddress (stubs gerados em runtime),
//     e registrar janela/formato de pixel. Tudo e repassado ao opengl32.dll real do sistema.
#define _CRT_SECURE_NO_WARNINGS
#define WIN32_LEAN_AND_MEAN
#define NOGDI  // evita as declaracoes dllimport de wglXxx; usamos tipos proprios abaixo
#include <windows.h>
#include <jni.h>

#include <algorithm>
#include <atomic>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <map>
#include <mutex>
#include <string>
#include <utility>
#include <vector>

#include "gl_names.h"

extern "C" {
void* g_real[kCount];                // enderecos reais (usados pelos stubs em gl_stubs.asm)
volatile unsigned g_counts[kCount];  // contador de chamadas por funcao exportada
}

namespace {

typedef void* (WINAPI* GLPROC)();
typedef void* (WINAPI* PFN_wglCreateContext)(void*);
typedef BOOL (WINAPI* PFN_wglMakeCurrent)(void*, void*);
typedef BOOL (WINAPI* PFN_wglDeleteContext)(void*);
typedef GLPROC (WINAPI* PFN_wglGetProcAddress)(LPCSTR);
typedef const unsigned char* (WINAPI* PFN_glGetString)(unsigned);
typedef int (WINAPI* PFN_wglGetPixelFormat)(void*);
typedef int (WINAPI* PFN_wglDescribePixelFormat)(void*, int, unsigned, void*);

// Copia minima de PIXELFORMATDESCRIPTOR (wingdi.h esta excluido por NOGDI).
struct PfdLite {
    WORD nSize, nVersion;
    DWORD dwFlags;
    BYTE iPixelType, cColorBits, cRedBits, cRedShift, cGreenBits, cGreenShift, cBlueBits, cBlueShift;
    BYTE cAlphaBits, cAlphaShift, cAccumBits, cAccumRedBits, cAccumGreenBits, cAccumBlueBits, cAccumAlphaBits;
    BYTE cDepthBits, cStencilBits, cAuxBuffers, iLayerType, bReserved;
    DWORD dwLayerMask, dwVisibleMask, dwDamageMask;
};

constexpr size_t kMaxExt = 4096;  // maximo de funcoes distintas obtidas via wglGetProcAddress
constexpr size_t kChunk = 64 * 1024, kStubSize = 32;

HMODULE g_self = nullptr;
HMODULE g_realMod = nullptr;
std::once_flag g_once;
std::mutex g_logMu, g_procMu, g_trMu;
std::wstring g_dir;
std::map<std::string, bool> g_procReq;  // nome -> driver devolveu endereco?
std::string g_glVendor, g_glRenderer, g_glVersion;
std::atomic<bool> g_glInfoDone(false), g_trace(true);
std::atomic<int> g_makeCurrentLogged(0), g_missingLogged(0), g_limitLogged(0);
size_t g_swapIdx = static_cast<size_t>(-1);

PFN_wglCreateContext r_create = nullptr;
PFN_wglMakeCurrent r_makeCurrent = nullptr;
PFN_wglDeleteContext r_delete = nullptr;
PFN_wglGetProcAddress r_getProc = nullptr;

// ---- Trampolins (5b) ----
struct Tramp {
    void* real;
    void* stub;
    size_t idx;
};
volatile unsigned g_extCounts[kMaxExt];  // endereco fixo: referenciado pelo codigo gerado
std::map<std::string, Tramp> g_tramps;
std::vector<std::string> g_extNames;  // idx -> nome
unsigned char* g_chunk = nullptr;
size_t g_chunkUsed = 0;

std::string Ptr(const void* p) {
    char b[32];
    std::snprintf(b, sizeof(b), "%p", p);
    return b;
}

void Log(const std::string& s) {
    std::lock_guard<std::mutex> l(g_logMu);
    FILE* f = _wfopen((g_dir + L"dx11gl_proxy.log").c_str(), L"a");
    if (!f) return;
    SYSTEMTIME t;
    GetLocalTime(&t);
    std::fprintf(f, "%04d-%02d-%02d %02d:%02d:%02d.%03d %s\n", t.wYear, t.wMonth, t.wDay, t.wHour,
                 t.wMinute, t.wSecond, t.wMilliseconds, s.c_str());
    std::fclose(f);
}

void* AllocStub() {
    if (!g_chunk || g_chunkUsed + kStubSize > kChunk) {
        g_chunk = static_cast<unsigned char*>(
            VirtualAlloc(nullptr, kChunk, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE));
        g_chunkUsed = 0;
        if (!g_chunk) return nullptr;
    }
    void* r = g_chunk + g_chunkUsed;
    g_chunkUsed += kStubSize;
    return r;
}

// Gera: mov rax,&contador ; lock inc dword [rax] ; mov rax,real ; jmp rax
// RAX e volatil e nao carrega argumentos no ABI x64 do Windows: os argumentos seguem intactos.
void* MakeTrampoline(const char* name, void* real) {
    std::lock_guard<std::mutex> l(g_trMu);
    auto it = g_tramps.find(name);
    if (it != g_tramps.end() && it->second.real == real) return it->second.stub;
    size_t idx;
    if (it != g_tramps.end()) {
        idx = it->second.idx;  // driver devolveu outro endereco (outro contexto): reaproveita o contador
    } else {
        if (g_extNames.size() >= kMaxExt) {
            if (g_limitLogged.fetch_add(1) == 0) Log("ERRO: limite de trampolins atingido; funcoes novas sem contagem");
            return nullptr;
        }
        idx = g_extNames.size();
        g_extNames.push_back(name);
    }
    unsigned char* s = static_cast<unsigned char*>(AllocStub());
    if (!s) return nullptr;
    const uint64_t cnt = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&g_extCounts[idx]));
    const uint64_t tgt = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(real));
    size_t o = 0;
    s[o++] = 0x48; s[o++] = 0xB8; std::memcpy(s + o, &cnt, 8); o += 8;  // mov rax, imm64
    s[o++] = 0xF0; s[o++] = 0xFF; s[o++] = 0x00;                        // lock inc dword ptr [rax]
    s[o++] = 0x48; s[o++] = 0xB8; std::memcpy(s + o, &tgt, 8); o += 8;  // mov rax, imm64
    s[o++] = 0xFF; s[o++] = 0xE0;                                       // jmp rax
    while (o < kStubSize) s[o++] = 0xCC;
    FlushInstructionCache(GetCurrentProcess(), s, kStubSize);
    g_tramps[name] = Tramp{real, s, idx};
    return s;
}

struct Family {
    const char* title;
    std::vector<const char*> names;
};

void WriteStats() {
    // 1) Instantaneo das contagens (exportadas + obtidas por wglGetProcAddress)
    std::map<std::string, unsigned long long> all;
    for (size_t i = 0; i < kCount; ++i)
        if (g_counts[i]) all[kNames[i]] += g_counts[i];
    size_t extRequested = 0;
    std::vector<std::string> neverCalled;
    {
        std::lock_guard<std::mutex> l(g_trMu);
        extRequested = g_extNames.size();
        for (size_t i = 0; i < g_extNames.size(); ++i) {
            unsigned c = g_extCounts[i];
            if (c) all[g_extNames[i]] += c;
            else neverCalled.push_back(g_extNames[i]);
        }
    }
    unsigned long long total = 0;
    for (const auto& kv : all) total += kv.second;
    auto it = all.find("wglSwapBuffers");
    unsigned long long swaps = it == all.end() ? 0 : it->second;

    FILE* f = _wfopen((g_dir + L"dx11gl_proxy_stats.txt").c_str(), L"w");
    if (!f) return;
    std::fprintf(f, "GL_VENDOR=%s\nGL_RENDERER=%s\nGL_VERSION=%s\n", g_glVendor.c_str(),
                 g_glRenderer.c_str(), g_glVersion.c_str());
    std::fprintf(f, "TRACE=%s\n", g_trace ? "ligado (wglGetProcAddress devolve trampolins)" : "desligado");
    std::fprintf(f, "TOTAL_CHAMADAS=%llu\nQUADROS(wglSwapBuffers)=%llu\n", total, swaps);
    if (swaps) std::fprintf(f, "MEDIA_CHAMADAS_POR_QUADRO=%.1f\n", static_cast<double>(total) / swaps);

    static const Family fams[] = {
        {"Modo imediato", {"glBegin", "glEnd", "glVertex2f", "glVertex3f", "glVertex2d", "glVertex3d", "glColor3f", "glColor4f", "glColor3ub", "glColor4ub", "glTexCoord2f", "glNormal3f"}},
        {"Listas de exibicao", {"glNewList", "glEndList", "glCallList", "glCallLists", "glGenLists", "glDeleteLists"}},
        {"Arrays de cliente", {"glDrawArrays", "glDrawElements", "glMultiDrawArrays", "glMultiDrawArraysEXT", "glVertexPointer", "glColorPointer", "glTexCoordPointer", "glNormalPointer", "glEnableClientState", "glDisableClientState"}},
        {"VBO (buffers)", {"glGenBuffers", "glGenBuffersARB", "glBindBuffer", "glBindBufferARB", "glBufferData", "glBufferDataARB", "glBufferSubData", "glBufferSubDataARB", "glMapBuffer", "glMapBufferARB", "glMapBufferRange", "glUnmapBuffer", "glUnmapBufferARB", "glDeleteBuffers", "glDeleteBuffersARB"}},
        {"VAO", {"glGenVertexArrays", "glBindVertexArray", "glVertexAttribPointer", "glEnableVertexAttribArray"}},
        {"Shaders", {"glCreateShader", "glShaderSource", "glShaderSourceARB", "glCompileShader", "glCompileShaderARB", "glCreateProgram", "glLinkProgram", "glLinkProgramARB", "glUseProgram", "glUseProgramObjectARB", "glUniform1i", "glUniform1f", "glUniform4f", "glUniformMatrix4", "glUniformMatrix4fv"}},
        {"Framebuffers (FBO)", {"glGenFramebuffers", "glGenFramebuffersEXT", "glBindFramebuffer", "glBindFramebufferEXT", "glFramebufferTexture2D", "glFramebufferTexture2DEXT", "glBlitFramebuffer", "glBlitFramebufferEXT", "glGenRenderbuffers", "glGenRenderbuffersEXT", "glRenderbufferStorage", "glRenderbufferStorageEXT"}},
        {"Texturas", {"glGenTextures", "glBindTexture", "glDeleteTextures", "glTexImage2D", "glTexSubImage2D", "glTexParameteri", "glTexParameterf", "glTexEnvi", "glTexEnvf", "glTexEnvfv", "glActiveTexture", "glActiveTextureARB", "glClientActiveTexture", "glClientActiveTextureARB", "glMultiTexCoord2f", "glMultiTexCoord2fARB", "glGenerateMipmap", "glGenerateMipmapEXT", "glCopyTexSubImage2D", "glGetTexImage", "glTexGeni", "glTexGenfv"}},
        {"Estado fixo", {"glLightfv", "glLightModelfv", "glColorMaterial", "glMaterialfv", "glFogfv", "glFogf", "glFogi", "glAlphaFunc", "glBlendFunc", "glBlendFuncSeparate", "glBlendFuncSeparateEXT", "glDepthFunc", "glDepthMask", "glColorMask", "glStencilFunc", "glStencilOp", "glStencilMask", "glCullFace", "glPolygonOffset", "glShadeModel", "glLineWidth", "glScissor", "glViewport"}},
        {"Matrizes", {"glMatrixMode", "glLoadIdentity", "glPushMatrix", "glPopMatrix", "glTranslatef", "glRotatef", "glScalef", "glMultMatrixf", "glLoadMatrixf", "glOrtho", "glFrustum"}},
        {"Leitura/consulta", {"glGetIntegerv", "glGetFloatv", "glGetBooleanv", "glGetError", "glIsEnabled", "glGetString", "glReadPixels", "glGetTexLevelParameteriv", "glFinish", "glFlush"}},
        {"Contexto/apresentacao", {"wglSwapBuffers", "wglSwapIntervalEXT", "wglMakeCurrent", "wglCreateContext", "wglCreateContextAttribsARB"}},
    };
    std::fprintf(f, "\n== Resumo por familia (soma | detalhes com contagem > 0) ==\n");
    for (const Family& fam : fams) {
        unsigned long long sum = 0;
        std::string det;
        for (const char* n : fam.names) {
            auto k = all.find(n);
            if (k != all.end() && k->second) {
                sum += k->second;
                det += std::string(" ") + n + "=" + std::to_string(k->second);
            }
        }
        std::fprintf(f, "%s: %llu |%s\n", fam.title, sum, det.empty() ? " (nenhuma)" : det.c_str());
    }

    std::vector<std::pair<std::string, unsigned long long>> sorted(all.begin(), all.end());
    std::sort(sorted.begin(), sorted.end(),
              [](const std::pair<std::string, unsigned long long>& a, const std::pair<std::string, unsigned long long>& b) {
                  return a.second != b.second ? a.second > b.second : a.first < b.first;
              });
    std::fprintf(f, "\n== Todas as funcoes chamadas (%zu), da mais para a menos usada ==\n", sorted.size());
    for (const auto& kv : sorted) std::fprintf(f, "%s=%llu\n", kv.first.c_str(), kv.second);

    size_t reqAll;
    {
        std::lock_guard<std::mutex> l(g_procMu);
        reqAll = g_procReq.size();
    }
    std::fprintf(f, "\n== wglGetProcAddress: %zu nomes pedidos; %zu com endereco; %zu NUNCA chamados ==\n", reqAll,
                 extRequested, neverCalled.size());
    for (const std::string& n : neverCalled) std::fprintf(f, "nunca:%s\n", n.c_str());
    std::fclose(f);
}

DWORD WINAPI StatsThread(LPVOID) {
    for (;;) {
        Sleep(5000);
        WriteStats();
    }
}

extern "C" void* MissingStub() {
    if (g_missingLogged.fetch_add(1) < 10) Log("ERRO: chamada a funcao GL sem implementacao real");
    return nullptr;
}

struct StaticInit {  // so grava memoria: seguro dentro do DllMain
    StaticInit() {
        for (size_t i = 0; i < kCount; ++i) g_real[i] = reinterpret_cast<void*>(&MissingStub);
    }
} g_staticInit;

void DoInit() {
    wchar_t p[MAX_PATH] = {};
    GetModuleFileNameW(g_self, p, MAX_PATH);
    std::wstring self(p);
    size_t slash = self.find_last_of(L"\\/");
    g_dir = slash == std::wstring::npos ? L"" : self.substr(0, slash + 1);

    wchar_t sys[MAX_PATH] = {};
    GetSystemDirectoryW(sys, MAX_PATH);
    std::wstring real = std::wstring(sys) + L"\\opengl32.dll";
    g_realMod = LoadLibraryW(real.c_str());
    if (!g_realMod) {
        Log("ERRO: nao foi possivel carregar o opengl32.dll real (GetLastError=" +
            std::to_string(GetLastError()) + ")");
        return;
    }
    size_t resolved = 0;
    for (size_t i = 0; i < kCount; ++i) {
        FARPROC fp = GetProcAddress(g_realMod, kNames[i]);
        if (fp) {
            g_real[i] = reinterpret_cast<void*>(fp);
            ++resolved;
        }
        if (std::strcmp(kNames[i], "wglSwapBuffers") == 0) g_swapIdx = i;
    }
    r_create = reinterpret_cast<PFN_wglCreateContext>(GetProcAddress(g_realMod, "wglCreateContext"));
    r_makeCurrent = reinterpret_cast<PFN_wglMakeCurrent>(GetProcAddress(g_realMod, "wglMakeCurrent"));
    r_delete = reinterpret_cast<PFN_wglDeleteContext>(GetProcAddress(g_realMod, "wglDeleteContext"));
    r_getProc = reinterpret_cast<PFN_wglGetProcAddress>(GetProcAddress(g_realMod, "wglGetProcAddress"));

    Log("proxy inicializado (5b). Modulo proxy=" + Ptr(g_self) + " | opengl32 real=" + Ptr(g_realMod) +
        " | funcoes resolvidas " + std::to_string(resolved) + "/" + std::to_string(kCount) +
        " | trace=" + (g_trace ? "ligado" : "desligado"));
    CreateThread(nullptr, 0, StatsThread, nullptr, 0, nullptr);
}

void EnsureInit() { std::call_once(g_once, DoInit); }

// Janela e formato de pixel do contexto principal: necessarios para planejar a apresentacao via D3D11.
void LogWindowAndPixelFormat(void* hdc) {
    HWND w = WindowFromDC(reinterpret_cast<HDC>(hdc));
    if (w) {
        RECT r = {};
        GetClientRect(w, &r);
        char cls[128] = {};
        GetClassNameA(w, cls, 127);
        Log("janela: HWND=" + Ptr(w) + " classe=" + cls + " area_cliente=" + std::to_string(r.right - r.left) + "x" +
            std::to_string(r.bottom - r.top));
    } else {
        Log("janela: WindowFromDC devolveu NULL");
    }
    PFN_wglGetPixelFormat gpf = reinterpret_cast<PFN_wglGetPixelFormat>(GetProcAddress(g_realMod, "wglGetPixelFormat"));
    PFN_wglDescribePixelFormat dpf =
        reinterpret_cast<PFN_wglDescribePixelFormat>(GetProcAddress(g_realMod, "wglDescribePixelFormat"));
    if (!gpf || !dpf) return;
    int fmt = gpf(hdc);
    PfdLite d = {};
    if (fmt > 0 && dpf(hdc, fmt, sizeof(d), &d) > 0) {
        char b[256];
        std::snprintf(b, sizeof(b),
                      "formato de pixel #%d: flags=0x%08lX cor=%d alfa=%d profundidade=%d stencil=%d aux=%d "
                      "(flags: 0x1=duplo buffer, 0x4=janela, 0x20=OpenGL, 0x200=swap exchange, 0x400=swap copy)",
                      fmt, static_cast<unsigned long>(d.dwFlags), d.cColorBits, d.cAlphaBits, d.cDepthBits,
                      d.cStencilBits, d.cAuxBuffers);
        Log(b);
    } else {
        Log("formato de pixel: nao foi possivel descrever (fmt=" + std::to_string(fmt) + ")");
    }
}

}  // namespace

// ---- Exports implementados em C++ (os demais sao stubs MASM) ----
extern "C" {

void* WINAPI wglCreateContext(void* hdc) {
    EnsureInit();
    if (!r_create) return nullptr;
    void* rc = r_create(hdc);
    Log("wglCreateContext(dc=" + Ptr(hdc) + ") -> rc=" + Ptr(rc));
    return rc;
}

BOOL WINAPI wglMakeCurrent(void* hdc, void* rc) {
    EnsureInit();
    if (!r_makeCurrent) return FALSE;
    BOOL ok = r_makeCurrent(hdc, rc);
    if (g_makeCurrentLogged.fetch_add(1) < 20)
        Log("wglMakeCurrent(dc=" + Ptr(hdc) + ", rc=" + Ptr(rc) + ") -> " + (ok ? "ok" : "FALHOU"));
    if (ok && rc && !g_glInfoDone.exchange(true) && g_realMod) {
        PFN_glGetString gs = reinterpret_cast<PFN_glGetString>(GetProcAddress(g_realMod, "glGetString"));
        if (gs) {
            const unsigned char* v = gs(0x1F00);  // GL_VENDOR
            const unsigned char* r = gs(0x1F01);  // GL_RENDERER
            const unsigned char* n = gs(0x1F02);  // GL_VERSION
            g_glVendor = v ? reinterpret_cast<const char*>(v) : "?";
            g_glRenderer = r ? reinterpret_cast<const char*>(r) : "?";
            g_glVersion = n ? reinterpret_cast<const char*>(n) : "?";
            Log("GL_VENDOR=" + g_glVendor + " | GL_RENDERER=" + g_glRenderer + " | GL_VERSION=" + g_glVersion);
        }
        LogWindowAndPixelFormat(hdc);
    }
    return ok;
}

BOOL WINAPI wglDeleteContext(void* rc) {
    EnsureInit();
    if (!r_delete) return FALSE;
    BOOL ok = r_delete(rc);
    Log("wglDeleteContext(rc=" + Ptr(rc) + ") -> " + (ok ? "ok" : "FALHOU"));
    return ok;
}

GLPROC WINAPI wglGetProcAddress(LPCSTR name) {
    EnsureInit();
    GLPROC p = r_getProc ? r_getProc(name) : nullptr;
    if (!name) return p;
    const uintptr_t pv = reinterpret_cast<uintptr_t>(p);
    const bool valid = pv > 3 && pv != static_cast<uintptr_t>(-1);  // alguns drivers antigos devolvem 1,2,3,-1
    {
        std::lock_guard<std::mutex> l(g_procMu);
        g_procReq[name] = valid;
    }
    if (valid && g_trace) {
        void* w = MakeTrampoline(name, reinterpret_cast<void*>(p));
        if (w) return reinterpret_cast<GLPROC>(w);
    }
    return p;
}

BOOL WINAPI DllMain(HINSTANCE h, DWORD reason, LPVOID) {
    if (reason == DLL_PROCESS_ATTACH) {
        g_self = reinterpret_cast<HMODULE>(h);
        DisableThreadLibraryCalls(h);
    }
    return TRUE;
}

}  // extern "C"

// Chamado pelo Java (Dx11Native.proxyInit) logo apos System.load, antes de o LWJGL abrir o GL.
extern "C" JNIEXPORT jboolean JNICALL Java_dev_dx11gl_core_Dx11Native_proxyInit(JNIEnv*, jclass, jboolean trace) {
    g_trace = (trace == JNI_TRUE);
    EnsureInit();
    return g_realMod ? JNI_TRUE : JNI_FALSE;
}
