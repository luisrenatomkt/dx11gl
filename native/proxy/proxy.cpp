// opengl32.dll "passthrough" (Etapa 5a). NAO traduz nada para Direct3D 11.
// Objetivo: provar se o LWJGL 2 do Minecraft 1.8.9 usa esta DLL no lugar do opengl32 do Windows,
// e registrar quais funcoes o jogo chama. Tudo e repassado ao opengl32.dll real do sistema.
#define _CRT_SECURE_NO_WARNINGS
#define WIN32_LEAN_AND_MEAN
#define NOGDI  // evita as declaracoes dllimport de wglXxx; usamos tipos proprios abaixo
#include <windows.h>
#include <jni.h>

#include <atomic>
#include <cstdio>
#include <map>
#include <mutex>
#include <string>

#include "gl_names.h"

extern "C" {
void* g_real[kCount];             // enderecos reais (usados pelos stubs em gl_stubs.asm)
volatile unsigned g_counts[kCount];  // contador de chamadas por funcao
}

namespace {

typedef void* (WINAPI* GLPROC)();
typedef void* (WINAPI* PFN_wglCreateContext)(void*);
typedef BOOL (WINAPI* PFN_wglMakeCurrent)(void*, void*);
typedef BOOL (WINAPI* PFN_wglDeleteContext)(void*);
typedef GLPROC (WINAPI* PFN_wglGetProcAddress)(LPCSTR);
typedef const unsigned char* (WINAPI* PFN_glGetString)(unsigned);

HMODULE g_self = nullptr;
HMODULE g_realMod = nullptr;
std::once_flag g_once;
std::mutex g_logMu, g_procMu;
std::wstring g_dir;
std::map<std::string, bool> g_procReq;  // nome -> driver devolveu endereco?
std::string g_glVendor, g_glRenderer, g_glVersion;
std::atomic<bool> g_glInfoDone(false);
std::atomic<int> g_makeCurrentLogged(0), g_missingLogged(0);

PFN_wglCreateContext r_create = nullptr;
PFN_wglMakeCurrent r_makeCurrent = nullptr;
PFN_wglDeleteContext r_delete = nullptr;
PFN_wglGetProcAddress r_getProc = nullptr;

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

void WriteStats() {
    FILE* f = _wfopen((g_dir + L"dx11gl_proxy_stats.txt").c_str(), L"w");
    if (!f) return;
    std::fprintf(f, "GL_VENDOR=%s\nGL_RENDERER=%s\nGL_VERSION=%s\n\n", g_glVendor.c_str(),
                 g_glRenderer.c_str(), g_glVersion.c_str());
    std::fprintf(f, "== Funcoes GL 1.1 / WGL chamadas via opengl32 (nome=contagem) ==\n");
    unsigned long long total = 0;
    for (size_t i = 0; i < kCount; ++i) {
        unsigned c = g_counts[i];
        if (c) {
            std::fprintf(f, "%s=%u\n", kNames[i], c);
            total += c;
        }
    }
    std::fprintf(f, "TOTAL=%llu\n\n", total);
    {
        std::lock_guard<std::mutex> l(g_procMu);
        std::fprintf(f, "== wglGetProcAddress: funcoes pedidas pelo jogo (%zu) ==\n", g_procReq.size());
        for (const auto& kv : g_procReq)
            std::fprintf(f, "%s %s\n", kv.first.c_str(), kv.second ? "ok" : "NULL");
    }
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
    }
    r_create = reinterpret_cast<PFN_wglCreateContext>(GetProcAddress(g_realMod, "wglCreateContext"));
    r_makeCurrent = reinterpret_cast<PFN_wglMakeCurrent>(GetProcAddress(g_realMod, "wglMakeCurrent"));
    r_delete = reinterpret_cast<PFN_wglDeleteContext>(GetProcAddress(g_realMod, "wglDeleteContext"));
    r_getProc = reinterpret_cast<PFN_wglGetProcAddress>(GetProcAddress(g_realMod, "wglGetProcAddress"));

    Log("proxy inicializado. Modulo proxy=" + Ptr(g_self) + " | opengl32 real=" + Ptr(g_realMod) +
        " | funcoes resolvidas " + std::to_string(resolved) + "/" + std::to_string(kCount));
    CreateThread(nullptr, 0, StatsThread, nullptr, 0, nullptr);
}

void EnsureInit() { std::call_once(g_once, DoInit); }

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
    if (name) {
        std::lock_guard<std::mutex> l(g_procMu);
        g_procReq[name] = (p != nullptr);
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
extern "C" JNIEXPORT jboolean JNICALL Java_dev_dx11gl_core_Dx11Native_proxyInit(JNIEnv*, jclass) {
    EnsureInit();
    return g_realMod ? JNI_TRUE : JNI_FALSE;
}
