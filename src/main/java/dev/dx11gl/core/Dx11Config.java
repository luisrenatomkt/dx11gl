package dev.dx11gl.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

/** Configuracao em <gamedir>/config/dx11gl.cfg. enabled=false desativa tudo (OpenGL original). */
public final class Dx11Config {
    public final boolean enabled;

    private Dx11Config(boolean enabled) { this.enabled = enabled; }

    public static Dx11Config load(File gameDir) {
        File cfg = new File(new File(gameDir, "config"), "dx11gl.cfg");
        Properties p = new Properties();
        if (cfg.isFile()) {
            FileInputStream in = null;
            try {
                in = new FileInputStream(cfg);
                p.load(in);
            } catch (IOException e) {
                Dx11Log.error("Falha ao ler " + cfg + ": " + e);
            } finally {
                if (in != null) try { in.close(); } catch (IOException ignored) {}
            }
        } else {
            p.setProperty("enabled", "true");
            cfg.getParentFile().mkdirs();
            FileOutputStream out = null;
            try {
                out = new FileOutputStream(cfg);
                p.store(out, "DX11 GL - enabled=false volta ao OpenGL original");
            } catch (IOException e) {
                Dx11Log.error("Nao foi possivel criar " + cfg + ": " + e);
            } finally {
                if (out != null) try { out.close(); } catch (IOException ignored) {}
            }
        }
        return new Dx11Config(Boolean.parseBoolean(p.getProperty("enabled", "true").trim()));
    }
}
