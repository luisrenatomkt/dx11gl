# Etapa 5a — o jogo usa o nosso opengl32.dll? (teste de passthrough)

**Isto NÃO ativa Direct3D 11.** O proxy repassa tudo ao OpenGL real e só anota o que o jogo chama.
Serve para responder: o LWJGL 2 do Minecraft 1.8.9 carrega a nossa DLL no lugar do `opengl32.dll` do Windows?

## 1. Atualizar o repositório no GitHub
1. Extraia o novo `dx11gl-projeto.zip`.
2. Envie para o repositório (por Git ou GitHub Desktop) tudo que mudou/é novo:
   `native/` (agora com a pasta `proxy`), `tools/`, `src/`, `docs/`, `README.md`.
3. No GitHub, abra `.github/workflows/build.yml` (lápis = editar) e faça **duas** mudanças:
   - troque `foreach ($f in 'dx11gl.dll','dx11gl_probe.exe') {`
     por `foreach ($f in 'dx11gl.dll','dx11gl_probe.exe','opengl32.dll') {`
   - logo abaixo de `Copy-Item native/build/Release/dx11gl.dll dist/dx11gl/` acrescente, com o mesmo recuo:
     `Copy-Item native/build/Release/opengl32.dll dist/dx11gl/`
   (o `build.yml` do ZIP já vem com isso.)
4. Aguarde o build (aba Actions) e baixe o artifact `dx11gl-windows`.

## 2. Instalar o teste
1. Substitua o JAR antigo em `%APPDATA%\.minecraft\mods` pelo novo.
2. Copie **`dx11gl.dll` e `opengl32.dll`** da pasta `dx11gl` do artifact para `%APPDATA%\.minecraft\dx11gl\`.
3. Abra `%APPDATA%\.minecraft\config\dx11gl.cfg` no Bloco de Notas e deixe assim:

       enabled=true
       proxy=true

   (se não houver a linha `proxy`, acrescente.)
4. Abra o jogo pelo perfil Forge, espere o menu, entre em um mundo por ~20 segundos e feche o jogo.

## 3. O que me enviar (pasta `%APPDATA%\.minecraft\dx11gl\`)
`dx11gl.log`, `dx11gl_proxy.log` e `dx11gl_proxy_stats.txt`.

## 4. Como interpretar
| O que aparece | Significado |
|---|---|
| `dx11gl_proxy.log` com linhas `wglCreateContext` e `GL_RENDERER=...` | **Hipótese confirmada**: o jogo usou a nossa DLL. Posso seguir para traduzir para D3D11. |
| `dx11gl_proxy.log` só com "proxy inicializado" e sem linhas `wgl...` | Carregou, mas o LWJGL usou o opengl32 do sistema. Testo a alternativa (DLL ao lado do `javaw.exe`). |
| Não existe `dx11gl_proxy.log` | O proxy não foi carregado; o `dx11gl.log` diz o motivo. |
| O jogo fecha/trava | Ponha `proxy=false` no cfg (ou apague `opengl32.dll` da pasta `dx11gl`) e me envie os logs e o `latest.log`. |

## Desfazer
`proxy=false` em `config\dx11gl.cfg`, ou `enabled=false`.
