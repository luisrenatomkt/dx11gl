// Etapa 5c — a janela do LWJGL (formato de pixel OpenGL ja definido) aceita um swap chain DXGI?
#define NOMINMAX
#include "d3d_test.h"

#include <windows.h>
#include <d3d11.h>
#include <dxgi.h>
#include <wrl/client.h>

#include <cmath>
#include <cstdio>
#include <sstream>

using Microsoft::WRL::ComPtr;

namespace {
std::string Hr(HRESULT hr) {
    char b[32];
    std::snprintf(b, sizeof(b), "0x%08lX", static_cast<unsigned long>(hr));
    return b;
}
std::string Narrow(const wchar_t* w) {
    int n = WideCharToMultiByte(CP_UTF8, 0, w, -1, nullptr, 0, nullptr, nullptr);
    if (n <= 1) return "";
    std::string s(static_cast<size_t>(n - 1), '\0');
    WideCharToMultiByte(CP_UTF8, 0, w, -1, &s[0], n, nullptr, nullptr);
    return s;
}
}  // namespace

namespace dx11gl {

std::string RunPresentTest(void* hwndv, int seconds) {
    std::ostringstream o;
    HWND hwnd = static_cast<HWND>(hwndv);
    RECT rc = {};
    GetClientRect(hwnd, &rc);
    UINT w = rc.right > rc.left ? static_cast<UINT>(rc.right - rc.left) : 1;
    UINT h = rc.bottom > rc.top ? static_cast<UINT>(rc.bottom - rc.top) : 1;
    o << "janela " << w << "x" << h << "\n";

    ComPtr<ID3D11Device> dev;
    ComPtr<ID3D11DeviceContext> ctx;
    D3D_FEATURE_LEVEL fl = {};
    const D3D_FEATURE_LEVEL lv[] = {D3D_FEATURE_LEVEL_11_0, D3D_FEATURE_LEVEL_10_1, D3D_FEATURE_LEVEL_10_0};
    HRESULT hr = D3D11CreateDevice(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, 0, lv, 3, D3D11_SDK_VERSION, &dev,
                                   &fl, &ctx);
    if (FAILED(hr)) {
        o << "FALHOU em D3D11CreateDevice hr=" << Hr(hr) << "\n";
        return o.str();
    }
    ComPtr<IDXGIDevice> dxgiDev;
    ComPtr<IDXGIAdapter> adapter;
    ComPtr<IDXGIFactory> factory;
    if (FAILED(dev.As(&dxgiDev)) || FAILED(dxgiDev->GetAdapter(&adapter)) ||
        FAILED(adapter->GetParent(IID_PPV_ARGS(&factory)))) {
        o << "FALHOU ao obter adaptador/fabrica DXGI\n";
        return o.str();
    }
    DXGI_ADAPTER_DESC ad = {};
    adapter->GetDesc(&ad);
    o << "adaptador: " << Narrow(ad.Description) << " | feature level: "
      << (fl == D3D_FEATURE_LEVEL_11_0 ? "11_0" : fl == D3D_FEATURE_LEVEL_10_1 ? "10_1" : "10_0") << "\n";

    // Evita que o DXGI interfira no tratamento de mensagens da janela do LWJGL (Alt+Enter etc.).
    factory->MakeWindowAssociation(hwnd, DXGI_MWA_NO_ALT_ENTER | DXGI_MWA_NO_WINDOW_CHANGES);

    DXGI_SWAP_CHAIN_DESC sd = {};
    sd.BufferDesc.Width = w;
    sd.BufferDesc.Height = h;
    sd.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
    sd.SampleDesc.Count = 1;
    sd.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
    sd.BufferCount = 1;
    sd.OutputWindow = hwnd;
    sd.Windowed = TRUE;
    sd.SwapEffect = DXGI_SWAP_EFFECT_DISCARD;
    ComPtr<IDXGISwapChain> sc;
    hr = factory->CreateSwapChain(dev.Get(), &sd, &sc);
    o << "CreateSwapChain: " << (SUCCEEDED(hr) ? "OK" : "FALHOU") << " hr=" << Hr(hr) << "\n";
    if (FAILED(hr)) return o.str();

    ComPtr<ID3D11Texture2D> back;
    ComPtr<ID3D11RenderTargetView> rtv;
    hr = sc->GetBuffer(0, IID_PPV_ARGS(&back));
    if (SUCCEEDED(hr)) hr = dev->CreateRenderTargetView(back.Get(), nullptr, &rtv);
    if (FAILED(hr)) {
        o << "FALHOU ao criar a view do back buffer hr=" << Hr(hr) << "\n";
        return o.str();
    }

    const DWORD t0 = GetTickCount();
    DWORD last = t0;
    int ok = 0, fail = 0;
    HRESULT firstFail = S_OK;
    DWORD maxGap = 0;
    while (GetTickCount() - t0 < static_cast<DWORD>(seconds) * 1000) {
        const float t = static_cast<float>(GetTickCount() - t0) / 1000.0f;
        const float color[4] = {0.5f + 0.5f * std::sin(t * 2.0f), 0.5f + 0.5f * std::sin(t * 2.0f + 2.1f),
                                0.5f + 0.5f * std::sin(t * 2.0f + 4.2f), 1.0f};
        ctx->ClearRenderTargetView(rtv.Get(), color);
        hr = sc->Present(1, 0);
        if (SUCCEEDED(hr)) {
            ++ok;
        } else {
            if (!fail) firstFail = hr;
            ++fail;
            Sleep(16);
        }
        DWORD now = GetTickCount();
        if (now - last > maxGap) maxGap = now - last;
        last = now;
    }
    o << "Present: " << ok << " ok, " << fail << " falhas";
    if (fail) o << " (primeira falha hr=" << Hr(firstFail) << ")";
    o << " | maior intervalo entre quadros: " << maxGap << " ms\n";

    // Limpeza: devolve a janela ao OpenGL.
    ctx->ClearState();
    rtv.Reset();
    back.Reset();
    factory->MakeWindowAssociation(hwnd, 0);
    sc.Reset();
    ctx->Flush();
    o << "swap chain liberado\n";
    return o.str();
}

}  // namespace dx11gl
