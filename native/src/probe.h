#pragma once
#include <string>

namespace dx11gl {

// Enumera os adaptadores DXGI e tenta criar um dispositivo Direct3D 11 em cada um.
// A primeira linha do texto retornado e "RESULT=OK" (ha ao menos uma GPU real que atende
// aos requisitos minimos) ou "RESULT=FAIL". O restante e diagnostico legivel.
std::string ProbeAllAdapters();

}  // namespace dx11gl
