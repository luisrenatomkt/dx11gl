#!/usr/bin/env python3
"""Gera native/proxy/{gl_names.h,gl_stubs.asm,opengl32.def} a partir de tools/gl_exports.txt.
Uso (na raiz do projeto): python tools/gen_proxy.py
Funcoes em CPP_IMPL sao implementadas em proxy.cpp; as demais viram stubs MASM 'contar e saltar'."""
import os
root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
names = [l.strip() for l in open(os.path.join(root, 'tools', 'gl_exports.txt')) if l.strip()]
CPP_IMPL = {'wglCreateContext', 'wglMakeCurrent', 'wglDeleteContext', 'wglGetProcAddress', 'wglSwapBuffers'}
assert CPP_IMPL <= set(names), 'lista de nomes incompleta'
out = os.path.join(root, 'native', 'proxy')
os.makedirs(out, exist_ok=True)

with open(os.path.join(out, 'gl_names.h'), 'w') as f:
    f.write('// GERADO por tools/gen_proxy.py - nao edite.\n#pragma once\n#include <cstddef>\n')
    f.write('static const char* const kNames[] = {\n')
    for n in names: f.write('    "%s",\n' % n)
    f.write('};\nstatic constexpr size_t kCount = sizeof(kNames) / sizeof(kNames[0]);\n')
    f.write('static const bool kIsCppImpl[] = {\n')
    for n in names: f.write('    %s,\n' % ('true' if n in CPP_IMPL else 'false'))
    f.write('};\n')

with open(os.path.join(out, 'gl_stubs.asm'), 'w') as f:
    f.write('; GERADO por tools/gen_proxy.py - nao edite.\n')
    f.write('; Cada stub incrementa um contador e salta para o endereco real (g_real[i]).\n')
    f.write('; Nao altera registradores nem a pilha: os argumentos seguem intactos para a funcao real.\n')
    f.write('EXTERN g_real:QWORD\nEXTERN g_counts:DWORD\n.CODE\n')
    for i, n in enumerate(names):
        if n in CPP_IMPL: continue
        f.write('PUBLIC %s\n%s PROC\n    inc DWORD PTR [g_counts+%d]\n    jmp QWORD PTR [g_real+%d]\n%s ENDP\n' % (n, n, 4 * i, 8 * i, n))
    f.write('END\n')

with open(os.path.join(out, 'opengl32.def'), 'w') as f:
    f.write('EXPORTS\n')
    for n in names: f.write('    %s\n' % n)
print('ok: %d nomes, %d stubs asm' % (len(names), len([n for n in names if n not in CPP_IMPL])))
