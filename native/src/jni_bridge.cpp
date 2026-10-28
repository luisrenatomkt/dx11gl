#include <jni.h>

#include "probe.h"

extern "C" JNIEXPORT jstring JNICALL Java_dev_dx11gl_core_Dx11Native_probe(JNIEnv* env, jclass) {
    try {
        const std::string text = dx11gl::ProbeAllAdapters();
        return env->NewStringUTF(text.c_str());
    } catch (...) {
        return env->NewStringUTF("RESULT=FAIL\nExcecao C++ inesperada no diagnostico.\n");
    }
}
