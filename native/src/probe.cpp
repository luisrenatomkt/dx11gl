// Diagnostico Direct3D 11 (Etapa 4). Nao renderiza nada.
#include "probe.h"

#include <windows.h>
#include <d3d11.h>
#include <dxgi.h>
#include <wrl/client.h>

#include <cstdio>
#include <sstream>

using Microsoft::WRL::ComPtr;

namespace {

// DECISAO DE PROJETO PROVISORIA: feature level minimo 10_0 (Shader Model 4.0 basta para o
// pipeline do 1.8.9). 11_0 e o nivel recomendado. Revisar apos a Etapa 6.
constexpr D3D_FEATURE_LEVEL kMinLevel = D3D_FEATURE_LEVEL_10_0;

std::string Narrow(const wchar_t* w) {
    if (!w) return "";
    int n = WideCharToMultiByte(CP_UTF8, 0, w, -1, nullptr, 0, nullptr, nullptr);
    if (n <= 1) return "";
    std::string s(static_cast<size_t>(n - 1), '\0');
    WideCharToMultiByte(CP_UTF8, 0, w, -1, &s[0], n, nullptr, nullptr);
    return s;
}

const char* LevelName(D3D_FEATURE_LEVEL l) {
    switch (l) {
        case D3D_FEATURE_LEVEL_11_1: return "11_1";
        case D3D_FEATURE_LEVEL_11_0: return "11_0";
        case D3D_FEATURE_LEVEL_10_1: return "10_1";
        case D3D_FEATURE_LEVEL_10_0: return "10_0";
        default: return "desconhecido";
    }
}

std::string Hex(unsigned v) {
    char b[16];
    std::snprintf(b, sizeof(b), "0x%04X", v);
    return b;
}

struct FormatReq {
    DXGI_FORMAT fmt;
    const char* name;
    UINT mustHave;
    const char* what;
};

}  // namespace

namespace dx11gl {

std::string ProbeAllAdapters() {
    std::ostringstream out;
    bool anyOk = false;

    ComPtr<IDXGIFactory1> factory;
    HRESULT hr = CreateDXGIFactory1(IID_PPV_ARGS(&factory));
    if (FAILED(hr)) {
        out << "RESULT=FAIL\n"
            << "CreateDXGIFactory1 falhou (HRESULT 0x" << std::hex << static_cast<unsigned long>(hr) << ").\n"
            << "O Windows nao conseguiu iniciar o DXGI; verifique o driver de video.\n";
        return out.str();
    }

    std::ostringstream body;
    const D3D_FEATURE_LEVEL levels[] = {D3D_FEATURE_LEVEL_11_1, D3D_FEATURE_LEVEL_11_0,
                                        D3D_FEATURE_LEVEL_10_1, D3D_FEATURE_LEVEL_10_0};

    const FormatReq formats[] = {
        {DXGI_FORMAT_R8G8B8A8_UNORM, "R8G8B8A8_UNORM",
         D3D11_FORMAT_SUPPORT_TEXTURE2D | D3D11_FORMAT_SUPPORT_RENDER_TARGET |
             D3D11_FORMAT_SUPPORT_BLENDABLE | D3D11_FORMAT_SUPPORT_SHADER_SAMPLE |
             D3D11_FORMAT_SUPPORT_DISPLAY,
         "textura/alvo de render/blend/apresentacao"},
        {DXGI_FORMAT_D24_UNORM_S8_UINT, "D24_UNORM_S8_UINT", D3D11_FORMAT_SUPPORT_DEPTH_STENCIL,
         "profundidade+stencil"},
    };

    int count = 0;
    for (UINT i = 0;; ++i) {
        ComPtr<IDXGIAdapter1> adapter;
        if (factory->EnumAdapters1(i, &adapter) == DXGI_ERROR_NOT_FOUND) break;
        ++count;

        DXGI_ADAPTER_DESC1 d = {};
        adapter->GetDesc1(&d);
        const bool software = (d.Flags & DXGI_ADAPTER_FLAG_SOFTWARE) != 0 || d.VendorId == 0x1414;

        body << "\n[Adaptador " << i << "] " << Narrow(d.Description) << "\n"
             << "  VendorId=" << Hex(d.VendorId) << " DeviceId=" << Hex(d.DeviceId)
             << " VRAM dedicada=" << (d.DedicatedVideoMemory / (1024 * 1024)) << " MB"
             << (software ? " (SOFTWARE/WARP - nao conta como GPU)" : "") << "\n";

        LARGE_INTEGER umd = {};
        if (SUCCEEDED(adapter->CheckInterfaceSupport(__uuidof(IDXGIDevice), &umd))) {
            body << "  Versao do driver (bruta): " << HIWORD(umd.HighPart) << "." << LOWORD(umd.HighPart)
                 << "." << HIWORD(umd.LowPart) << "." << LOWORD(umd.LowPart) << "\n";
        }

        ComPtr<ID3D11Device> dev;
        ComPtr<ID3D11DeviceContext> ctx;
        D3D_FEATURE_LEVEL got = {};
        hr = D3D11CreateDevice(adapter.Get(), D3D_DRIVER_TYPE_UNKNOWN, nullptr, 0, levels, 4,
                               D3D11_SDK_VERSION, &dev, &got, &ctx);
        if (hr == E_INVALIDARG) {  // Windows sem suporte a 11_1 rejeita a lista com 11_1
            hr = D3D11CreateDevice(adapter.Get(), D3D_DRIVER_TYPE_UNKNOWN, nullptr, 0, levels + 1, 3,
                                   D3D11_SDK_VERSION, &dev, &got, &ctx);
        }
        if (FAILED(hr)) {
            body << "  D3D11CreateDevice FALHOU (HRESULT 0x" << std::hex << static_cast<unsigned long>(hr)
                 << std::dec << "): GPU/driver nao oferece feature level >= 10_0.\n";
            continue;
        }

        body << "  Feature level obtido: " << LevelName(got)
             << (got >= D3D_FEATURE_LEVEL_11_0 ? " (recomendado)" : "") << "\n";

        bool formatsOk = true;
        for (const FormatReq& f : formats) {
            UINT sup = 0;
            if (FAILED(dev->CheckFormatSupport(f.fmt, &sup)) || (sup & f.mustHave) != f.mustHave) {
                body << "  FALTA suporte: " << f.name << " (" << f.what << ")\n";
                formatsOk = false;
            } else {
                body << "  Formato OK: " << f.name << "\n";
            }
        }

        UINT q4 = 0, q8 = 0;
        dev->CheckMultisampleQualityLevels(DXGI_FORMAT_R8G8B8A8_UNORM, 4, &q4);
        dev->CheckMultisampleQualityLevels(DXGI_FORMAT_R8G8B8A8_UNORM, 8, &q8);
        body << "  MSAA 4x: " << (q4 ? "sim" : "nao") << " | MSAA 8x: " << (q8 ? "sim" : "nao") << "\n";

        const bool meets = got >= kMinLevel && formatsOk;
        body << "  Atende aos requisitos minimos: " << (meets ? "SIM" : "NAO") << "\n";
        if (meets && !software) anyOk = true;
    }

    if (count == 0) body << "\nNenhum adaptador DXGI encontrado.\n";

    out << (anyOk ? "RESULT=OK" : "RESULT=FAIL") << "\n";
    out << "Requisito minimo (provisorio): Direct3D 11 com feature level >= "
        << LevelName(kMinLevel) << ", GPU real (nao WARP), formatos R8G8B8A8 e D24S8.\n";
    if (!anyOk) {
        out << "NENHUMA GPU atende. Atualize o driver de video; se o problema persistir, "
               "a placa nao suporta os requisitos e o DX11 GL nao pode ser usado (o jogo seguira em OpenGL).\n";
    }
    out << body.str();
    return out.str();
}

}  // namespace dx11gl
