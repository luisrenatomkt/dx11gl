package dev.dx11gl.core;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/** Log simples em <gamedir>/dx11gl/dx11gl.log, espelhado no stdout. Nunca lanca excecao. */
public final class Dx11Log {
    private static File logFile;

    private Dx11Log() {}

    public static synchronized void init(File dir) {
        try {
            if (!dir.exists() && !dir.mkdirs()) return;
            logFile = new File(dir, "dx11gl.log");
        } catch (Throwable ignored) {
            logFile = null;
        }
    }

    public static synchronized void info(String msg) { write("INFO", msg); }
    public static synchronized void error(String msg) { write("ERROR", msg); }

    private static void write(String level, String msg) {
        String line = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())
                + " [" + level + "] " + msg;
        System.out.println("[dx11gl] " + line);
        if (logFile == null) return;
        PrintWriter w = null;
        try {
            w = new PrintWriter(new FileWriter(logFile, true));
            w.println(line);
        } catch (IOException ignored) {
        } finally {
            if (w != null) w.close();
        }
    }
}
