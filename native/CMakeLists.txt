cmake_minimum_required(VERSION 3.15)
project(dx11gl CXX)

if(NOT WIN32)
  message(FATAL_ERROR "dx11gl so pode ser compilado no Windows (MSVC, x64).")
endif()
if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
  message(FATAL_ERROR "Use uma toolchain x64 (o Java 8 do Minecraft 1.8.9 e de 64 bits).")
endif()

# CRT estatico: as DLLs sao carregadas dentro do javaw.exe e nao devem depender de redistribuivel VC++.
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(dx11gl_probe_core STATIC src/probe.cpp)
target_link_libraries(dx11gl_probe_core PUBLIC d3d11 dxgi)

# Executavel independente: roda sem Minecraft para validar a GPU.
add_executable(dx11gl_probe src/probe_main.cpp)
target_link_libraries(dx11gl_probe PRIVATE dx11gl_probe_core)

# DLL JNI (precisa de um JDK instalado para o jni.h).
find_package(JNI)
if(JNI_FOUND)
  add_library(dx11gl SHARED src/jni_bridge.cpp)
  target_include_directories(dx11gl PRIVATE ${JNI_INCLUDE_DIRS})
  target_link_libraries(dx11gl PRIVATE dx11gl_probe_core)
  # Proxy opengl32.dll (Etapa 5a): passthrough com log. Usa MASM (ml64) para os stubs.
  enable_language(ASM_MASM)
  add_library(dx11gl_glproxy SHARED proxy/proxy.cpp proxy/gl_stubs.asm proxy/opengl32.def)
  target_include_directories(dx11gl_glproxy PRIVATE ${JNI_INCLUDE_DIRS} proxy)
  set_target_properties(dx11gl_glproxy PROPERTIES OUTPUT_NAME opengl32 PREFIX "")
else()
  message(WARNING "JDK/JNI nao encontrado: apenas dx11gl_probe.exe sera gerado.")
endif()
