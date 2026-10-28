package dev.dx11gl.core;

import java.io.File;
import java.util.Map;

import net.minecraftforge.fml.relauncher.IFMLLoadingPlugin;

/**
 * Coremod: roda antes do Minecraft criar a janela/contexto OpenGL.
 * Etapa 4: diagnostico do Direct3D 11.
 * Etapa 5a (opt-in, proxy=true): carrega um opengl32.dll "passthrough" que apenas registra as chamadas.
 * Nenhuma das duas etapas troca o renderizador por Direct3D 11.
 */
@IFMLLoadingPlugin.MCVersion("1.8.9")
@IFMLLoadingPlugin.Name("DX11GL")
public class Dx11CorePlugin implements IFMLLoadingPlugin {

    public static volatile String lastProbe = "(nao executado)";
    public static volatile boolean probeOk = false;
    public static volatile String proxyState = "desligado";

    @Override public String[] getASMTransformerClass() { return new String[0]; }
    @Override public String getModContainerClass() { return null; }
    @Override public String getSetupClass() { return null; }
    @Override public String getAccessTransformerClass() { return null; }

    @Override
    public void injectData(Map<String, Object> data) {
        try {
            File gameDir = (File) data.get("mcLocation");
            if (gameDir == null) gameDir = new File(System.getProperty("user.dir"));
            File dir = new File(gameDir, "dx11gl");
            Dx11Log.init(dir);
            Dx11Log.info("DX11 GL iniciado (etapas 4, 5a e 5b: diagnostico + proxy instrumentado; renderizador continua OpenGL).");

            Dx11Config cfg = Dx11Config.load(gameDir);
            if (!cfg.enabled) {
                Dx11Log.info("enabled=false em config/dx11gl.cfg -> OpenGL original, nada e carregado.");
                lastProbe = "desativado por configuracao";
                return;
            }
            if (!System.getProperty("os.name", "").toLowerCase().contains("windows")
                    || !System.getProperty("os.arch", "").contains("64")) {
                Dx11Log.error("Requer Windows 64 bits (os.name/os.arch = "
                        + System.getProperty("os.name") + "/" + System.getProperty("os.arch") + ").");
                lastProbe = "plataforma nao suportada";
                return;
            }
            runProbe(dir);
            if (cfg.proxy) {
                loadProxy(dir, cfg.trace);
            } else {
                Dx11Log.info("proxy=false: opengl32 proxy nao sera carregado.");
            }
        } catch (Throwable t) {
            // Nunca derrubar o jogo por causa dos testes.
            Dx11Log.error("Falha inesperada, seguindo com OpenGL: " + t);
        }
    }

    private static void runProbe(File dir) {
        try {
            File dll = new File(dir, "dx11gl.dll");
            if (!dll.isFile()) {
                Dx11Log.error("dx11gl.dll nao encontrada em " + dll + ". Seguindo com OpenGL.");
                lastProbe = "dx11gl.dll ausente";
                return;
            }
            if (!Dx11Native.load(dll)) {
                lastProbe = "falha ao carregar dx11gl.dll";
                return;
            }
            String text = Dx11Native.probe();
            lastProbe = text;
            probeOk = text.startsWith("RESULT=OK");
            Dx11Log.info("Diagnostico Direct3D 11:\n" + text);
        } catch (Throwable t) {
            Dx11Log.error("Falha no diagnostico: " + t);
            lastProbe = "erro: " + t;
        }
    }

    private static void loadProxy(File dir, boolean trace) {
        try {
            File gl = new File(dir, "opengl32.dll");
            if (!gl.isFile()) {
                Dx11Log.error("proxy=true mas " + gl + " nao existe. Seguindo com o OpenGL do Windows.");
                proxyState = "arquivo ausente";
                return;
            }
            if (!Dx11Native.loadProxy(gl)) {
                proxyState = "falha ao carregar";
                return;
            }
            boolean ok = Dx11Native.proxyInit(trace);
            proxyState = ok ? "carregado e inicializado" : "carregado, mas init falhou";
            Dx11Log.info("opengl32 proxy: " + proxyState
                    + ". Veja dx11gl_proxy.log / dx11gl_proxy_stats.txt na mesma pasta.");
        } catch (Throwable t) {
            proxyState = "erro: " + t;
            Dx11Log.error("Falha ao ativar o proxy: " + t);
        }
    }
}
