# DX11 GL (em desenvolvimento) — Minecraft 1.8.9 Forge

**Estado atual: Etapas 3–4. O jogo ainda renderiza com OpenGL.** Este pacote só valida a estrutura
do projeto e diagnostica o Direct3D 11 da sua GPU. Veja `docs/STATUS.md`.

> **Sem instalar nada:** veja `docs/COMPILAR_GITHUB.md` (compilação automática pelo GitHub Actions).

## 1. Passo imediato: testar a GT 610 (não precisa do Minecraft)
Requisitos: Windows 10 x64, Visual Studio 2022 Build Tools (C++), CMake.

    cd native
    cmake -S . -B build -A x64
    cmake --build build --config Release
    build\Release\dx11gl_probe.exe

Envie o conteúdo de `dx11gl_probe.txt`. Ele informa feature level, driver, formatos e MSAA.

## 2. Compilar o mod (JDK 8 x64 + Gradle 2.14)
    gradle setupDecompWorkspace   (primeira vez; precisa de internet)
    gradle build                  -> build/libs/dx11gl-0.1.0-dev.jar

Se tiver um JDK instalado, o CMake também gera `dx11gl.dll` (JNI).

## 3. Instalar (launcher vanilla)
1. Instale o Forge 1.8.9 (11.15.1.2318) e abra o perfil dele ao menos uma vez.
2. Copie `dx11gl-0.1.0-dev.jar` para `%APPDATA%\.minecraft\mods`.
3. (Opcional, diagnóstico JNI) copie `dx11gl.dll` para `%APPDATA%\.minecraft\dx11gl\`.
4. Veja `%APPDATA%\.minecraft\dx11gl\dx11gl.log`.

## Desativar / voltar ao OpenGL
Edite `config\dx11gl.cfg`: `enabled=false`, ou remova o JAR de `mods`.
(Recuperação após falha real de renderização ainda não existe nem foi testada.)

## Licenças
Código próprio. O `dx12gl-3.2.1.jar` foi usado só como referência de arquitetura; nada foi copiado.
Dependências futuras previstas: glslang (BSD-3/Apache-2.0), SPIRV-Cross (Apache-2.0) — ainda não incluídas.
