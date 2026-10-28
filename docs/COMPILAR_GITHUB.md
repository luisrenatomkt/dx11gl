# Compilar pelo GitHub (Actions + build.yml)

Você não precisa instalar JDK, Gradle nem Visual Studio: o GitHub compila no servidor (Windows).

## 1. Criar o repositório
1. Em github.com: **New repository** > nome `dx11gl` > Create (pode ser privado).
2. Extraia o `dx11gl-projeto.zip`. Envie o **conteúdo da pasta `dx11gl`** (não a pasta em si) para a raiz do repositório.
   O arquivo `.github/workflows/build.yml` precisa ficar nesse caminho exato.

Pelo Git (recomendado, pois o upload pelo navegador pode ignorar a pasta oculta `.github`):

    cd dx11gl
    git init
    git add .
    git commit -m "DX11 GL: estrutura inicial"
    git branch -M main
    git remote add origin https://github.com/SEU_USUARIO/dx11gl.git
    git push -u origin main

## 2. Rodar a compilação
- O push na branch `main` já dispara o workflow. Para rodar manualmente: aba **Actions** > workflow
  **build** > **Run workflow**.
- Se for a primeira vez e a aba Actions pedir confirmação, clique em **I understand... enable them**.
- Acompanhe em **Actions** > execução > job **build** (leva alguns minutos; o primeiro build baixa o
  Minecraft/Forge e é o mais demorado).

## 3. Baixar o resultado
Na página da execução, em **Artifacts**, baixe `dx11gl-windows`. Estrutura:

    mods/dx11gl-0.1.0-dev.jar     -> copiar para %APPDATA%\.minecraft\mods
    dx11gl/dx11gl.dll             -> copiar para %APPDATA%\.minecraft\dx11gl\
    tools/dx11gl_probe.exe        -> rodar no PC com a GT 610 (duplo clique ou pelo CMD)

O `dx11gl_probe.exe` gera `dx11gl_probe.txt` ao lado dele. Envie esse texto.

## 4. Publicar uma Release (opcional)
    git tag v0.1.0
    git push origin v0.1.0
O workflow cria uma Release com um `.zip` do mesmo conteúdo.

## 5. Instalar no Minecraft (launcher vanilla)
1. Instale o Forge 1.8.9 (11.15.1.2318) e abra o perfil Forge uma vez.
2. Copie os arquivos conforme o passo 3.
3. Abra o jogo e leia `%APPDATA%\.minecraft\dx11gl\dx11gl.log`.
Nesta fase o jogo continua em OpenGL: o log só mostra o diagnóstico do Direct3D 11.

## Se o build falhar
O workflow ainda NÃO foi executado por mim; falhas na primeira rodada são possíveis. Abra o passo
vermelho no log e me envie o trecho do erro. Pontos de risco conhecidos:
- **Resolução do ForgeGradle 2.1-SNAPSHOT / dependências antigas do Forge 1.8.9**: servidores antigos
  (jcenter, mirrors) às vezes ficam indisponíveis ou mudaram de endereço. Costuma exigir ajustar os
  repositórios do `build.gradle`.
- **`setupCIWorkspace`**: se a tarefa não for reconhecida, trocar por `setupDecompWorkspace` (mais lento).
- **CMake não achar o JNI**: o passo da DLL JNI depende do JDK 8 instalado pelo `setup-java`.
- O passo **Run probe** deve mostrar `RESULT=FAIL` no GitHub (o servidor não tem GPU real). Isso é esperado
  e NÃO diz nada sobre a sua GT 610.
