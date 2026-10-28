package dev.dx11gl.core;

import java.io.File;

/** Ponte JNI para dx11gl.dll. Nesta etapa so expoe o diagnostico do Direct3D 11. */
public final class Dx11Native {
    private static boolean loaded;

    private Dx11Native() {}

    public static synchronized boolean load(File dll) {
        if (loaded) return true;
        try {
            System.load(dll.getAbsolutePath());
            loaded = true;
        } catch (UnsatisfiedLinkError e) {
            Dx11Log.error("Nao foi possivel carregar " + dll + ": " + e.getMessage());
        } catch (Throwable t) {
            Dx11Log.error("Erro inesperado ao carregar " + dll + ": " + t);
        }
        return loaded;
    }

    /** Primeira linha: "RESULT=OK" ou "RESULT=FAIL"; o resto e texto de diagnostico. */
    public static native String probe();
}
