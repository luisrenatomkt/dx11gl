// dx11gl_probe.exe - roda sem o Minecraft. Mostra e salva o diagnostico em dx11gl_probe.txt.
#include "probe.h"

#include <cstdio>
#include <fstream>
#include <string>

int main() {
    const std::string text = dx11gl::ProbeAllAdapters();
    std::fputs(text.c_str(), stdout);
    std::ofstream f("dx11gl_probe.txt", std::ios::binary);
    if (f) f << text;
    std::puts("\nResultado salvo em dx11gl_probe.txt");
    return text.rfind("RESULT=OK", 0) == 0 ? 0 : 1;
}
