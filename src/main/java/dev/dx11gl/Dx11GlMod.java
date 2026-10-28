package dev.dx11gl;

import dev.dx11gl.core.Dx11CorePlugin;
import dev.dx11gl.core.Dx11Log;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;

@Mod(modid = "dx11gl", name = "DX11 GL", version = "0.1.0-dev",
        acceptedMinecraftVersions = "[1.8.9]", clientSideOnly = true,
        acceptableRemoteVersions = "*")
public class Dx11GlMod {

    @Mod.EventHandler
    public void preInit(FMLPreInitializationEvent event) {
        Dx11Log.info("Mod reconhecido pelo Forge. Estado do D3D11: "
                + (Dx11CorePlugin.probeOk ? "diagnostico OK" : "nao validado")
                + " | proxy opengl32: " + Dx11CorePlugin.proxyState
                + " | renderizador ativo: OpenGL (backend D3D11 ainda nao implementado)");
    }
}
