# Status (atualize somente com evidência real)

| # | Critério de aceitação | Estado |
|---|---|---|
| 1 | Projeto compila | ✅ confirmado pelo usuário (GitHub Actions, etapas 3–4). Etapa 5a ainda não compilada |
| 2 | Mod reconhecido pelo Forge 1.8.9 | ✅ confirmado pelo usuário (aparece em Mods) |
| 3 | D3D11 inicializa em GPU compatível | ✅ GT 610: feature level 11_0, driver 23.21.13.9135, RESULT=OK (probe e dentro do jogo) |
| 4 | Jogo apresenta imagens via D3D11 | ❌ não implementado |
| 5 | Mundo/entidades/texturas/HUD | ❌ não implementado |
| 6 | Erros de init identificados e registrados | 🟨 escrito, não testado |
| 7 | Limitações documentadas | 🟨 parcial |
| 8 | Benchmarks reais | ❌ nenhum realizado |

## Etapa 5a (em teste)
Proxy `opengl32.dll` passthrough com log (`native/proxy`, `docs/ETAPA_5A.md`). Escrito, checado só por sintaxe simulada; **não compilado nem testado**.

## Implementado (código escrito, NÃO compilado nem executado)
- Projeto ForgeGradle 1.8.9, coremod + mod, config `enabled`, log em `dx11gl/dx11gl.log`.
- Diagnóstico D3D11 nativo (feature level, formatos, MSAA, WARP) via exe e via JNI.

## Não implementado
- Interceptação do OpenGL (proxy `opengl32`), backend D3D11, shaders, texturas, UI de opções, benchmarks.

## Hipóteses a testar (não confirmadas)
1. LWJGL 2.9.x (Windows) carrega `opengl32.dll` por nome. Se um módulo com esse nome já estiver
   carregado no processo, `LoadLibrary("opengl32.dll")` o reutiliza; então carregar nossa DLL com
   `System.load` no coremod, antes de `Display.create`, poderia redirecionar o GL sem tocar na pasta do Java.
2. Alternativa: copiar `opengl32.dll` proxy para a pasta do `javaw.exe` (ordem de busca de DLLs).
3. GT 610 (Fermi) = D3D11 feature level 11_0 — a confirmar com o probe e o driver instalado.
