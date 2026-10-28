#pragma once
#include <string>

namespace dx11gl {

// Etapa 5c: cria um dispositivo D3D11 + swap chain na janela JA usada pelo OpenGL e apresenta
// quadros coloridos por `seconds` segundos. Bloqueia a thread que chama. Devolve um relatorio de texto.
// Nao renderiza o Minecraft; so verifica se a janela aceita apresentacao via Direct3D 11.
std::string RunPresentTest(void* hwnd, int seconds);

}  // namespace dx11gl
