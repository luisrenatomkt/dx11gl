# Análise do dx12gl-3.2.1.jar (Etapa 1)

Método: listagem do ZIP, leitura de manifesto/mods.toml/mixins, extração de strings das classes e
exports/imports da DLL (objdump). Não foi possível descompilar (sem decompilador/rede no ambiente).

- Mod Forge 1.20.1 (`javafml` 47+, Java 17, Mixin), licença declarada no mods.toml: LGPL-3.0-only.
- 13 classes Java + 2 mixins (`LevelRenderer`, `Minecraft`), toda a renderização na `natives/dx12gl.dll`
  (x64, só binário, sem fonte no JAR).
- A DLL exporta 337 funções `gl*` (núcleo GL 1.1) e todas as `wgl*`: funciona como substituta do
  `opengl32.dll`. Extensões chegam por `wglGetProcAddress`.
- O Java define `org.lwjgl.opengl.libname` (LWJGL 3) apontando para a DLL extraída e chama exports
  `dx12gl_*` via `org.lwjgl.system.JNI`.
- Shaders: glslang + SPIRV-Cross (estáticos na DLL). Imports: d3d12, dxgi, D3DCOMPILER_47.
- Extras irrelevantes para o DX11 GL: DXC, FSR, XeSS, DLSS, NVAPI, Anti-Lag 2 (>95% do tamanho).

## Decisão
Implementação independente. Nenhum código ou binário do JAR é reutilizado. Do JAR vem apenas a
ideia arquitetural (DLL que substitui o OpenGL, carregada antes do contexto GL).
