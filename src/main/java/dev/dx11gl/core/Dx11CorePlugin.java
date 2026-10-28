package dev.dx11gl.core;

import java.io.File;
import java.util.Map;

import net.minecraftforge.fml.relauncher.IFMLLoadingPlugin;

/**
 * Coremod: roda antes do Minecraft criar a janela/contexto OpenGL.
 * Etapa 4: apenas diagnostica o Direct3D 11. NAO substitui o OpenGL ainda.
 */
@IFMLLoadingPlugin.MCVersion("1.8.9")
@IFMLLoadingPlugin.Name("DX11GL")
public class Dx11CorePlugin implements IFMLLoadingPlugin {

    public static volatile String lastProbe = "(nao executado)";
    public static volatile boolean probeOk = false;

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
            Dx11Log.info("DX11 GL iniciado (etapa 4: somente diagnostico).");

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
            File dll = new File(dir, "dx11gl.dll");
            if (!dll.isFile()) {
                Dx11Log.error("dx11gl.dll nao encontrada em " + dll
                        + ". Compile a parte nativa (ver README) e copie para esta pasta. Seguindo com OpenGL.");
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
            // Nunca derrubar o jogo por causa do diagnostico.
            Dx11Log.error("Falha no diagnostico, seguindo com OpenGL: " + t);
            lastProbe = "erro: " + t;
        }
    }
}
