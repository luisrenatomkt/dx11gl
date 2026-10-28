; GERADO por tools/gen_proxy.py - nao edite.
; Cada stub incrementa um contador e salta para o endereco real (g_real[i]).
; Nao altera registradores nem a pilha: os argumentos seguem intactos para a funcao real.
EXTERN g_real:QWORD
EXTERN g_counts:DWORD
.CODE
PUBLIC glAccum
glAccum PROC
    inc DWORD PTR [g_counts+0]
    jmp QWORD PTR [g_real+0]
glAccum ENDP
PUBLIC glAlphaFunc
glAlphaFunc PROC
    inc DWORD PTR [g_counts+4]
    jmp QWORD PTR [g_real+8]
glAlphaFunc ENDP
PUBLIC glAreTexturesResident
glAreTexturesResident PROC
    inc DWORD PTR [g_counts+8]
    jmp QWORD PTR [g_real+16]
glAreTexturesResident ENDP
PUBLIC glArrayElement
glArrayElement PROC
    inc DWORD PTR [g_counts+12]
    jmp QWORD PTR [g_real+24]
glArrayElement ENDP
PUBLIC glBegin
glBegin PROC
    inc DWORD PTR [g_counts+16]
    jmp QWORD PTR [g_real+32]
glBegin ENDP
PUBLIC glBindTexture
glBindTexture PROC
    inc DWORD PTR [g_counts+20]
    jmp QWORD PTR [g_real+40]
glBindTexture ENDP
PUBLIC glBitmap
glBitmap PROC
    inc DWORD PTR [g_counts+24]
    jmp QWORD PTR [g_real+48]
glBitmap ENDP
PUBLIC glBlendFunc
glBlendFunc PROC
    inc DWORD PTR [g_counts+28]
    jmp QWORD PTR [g_real+56]
glBlendFunc ENDP
PUBLIC glCallList
glCallList PROC
    inc DWORD PTR [g_counts+32]
    jmp QWORD PTR [g_real+64]
glCallList ENDP
PUBLIC glCallLists
glCallLists PROC
    inc DWORD PTR [g_counts+36]
    jmp QWORD PTR [g_real+72]
glCallLists ENDP
PUBLIC glClear
glClear PROC
    inc DWORD PTR [g_counts+40]
    jmp QWORD PTR [g_real+80]
glClear ENDP
PUBLIC glClearAccum
glClearAccum PROC
    inc DWORD PTR [g_counts+44]
    jmp QWORD PTR [g_real+88]
glClearAccum ENDP
PUBLIC glClearColor
glClearColor PROC
    inc DWORD PTR [g_counts+48]
    jmp QWORD PTR [g_real+96]
glClearColor ENDP
PUBLIC glClearDepth
glClearDepth PROC
    inc DWORD PTR [g_counts+52]
    jmp QWORD PTR [g_real+104]
glClearDepth ENDP
PUBLIC glClearIndex
glClearIndex PROC
    inc DWORD PTR [g_counts+56]
    jmp QWORD PTR [g_real+112]
glClearIndex ENDP
PUBLIC glClearStencil
glClearStencil PROC
    inc DWORD PTR [g_counts+60]
    jmp QWORD PTR [g_real+120]
glClearStencil ENDP
PUBLIC glClipPlane
glClipPlane PROC
    inc DWORD PTR [g_counts+64]
    jmp QWORD PTR [g_real+128]
glClipPlane ENDP
PUBLIC glColor3b
glColor3b PROC
    inc DWORD PTR [g_counts+68]
    jmp QWORD PTR [g_real+136]
glColor3b ENDP
PUBLIC glColor3bv
glColor3bv PROC
    inc DWORD PTR [g_counts+72]
    jmp QWORD PTR [g_real+144]
glColor3bv ENDP
PUBLIC glColor3d
glColor3d PROC
    inc DWORD PTR [g_counts+76]
    jmp QWORD PTR [g_real+152]
glColor3d ENDP
PUBLIC glColor3dv
glColor3dv PROC
    inc DWORD PTR [g_counts+80]
    jmp QWORD PTR [g_real+160]
glColor3dv ENDP
PUBLIC glColor3f
glColor3f PROC
    inc DWORD PTR [g_counts+84]
    jmp QWORD PTR [g_real+168]
glColor3f ENDP
PUBLIC glColor3fv
glColor3fv PROC
    inc DWORD PTR [g_counts+88]
    jmp QWORD PTR [g_real+176]
glColor3fv ENDP
PUBLIC glColor3i
glColor3i PROC
    inc DWORD PTR [g_counts+92]
    jmp QWORD PTR [g_real+184]
glColor3i ENDP
PUBLIC glColor3iv
glColor3iv PROC
    inc DWORD PTR [g_counts+96]
    jmp QWORD PTR [g_real+192]
glColor3iv ENDP
PUBLIC glColor3s
glColor3s PROC
    inc DWORD PTR [g_counts+100]
    jmp QWORD PTR [g_real+200]
glColor3s ENDP
PUBLIC glColor3sv
glColor3sv PROC
    inc DWORD PTR [g_counts+104]
    jmp QWORD PTR [g_real+208]
glColor3sv ENDP
PUBLIC glColor3ub
glColor3ub PROC
    inc DWORD PTR [g_counts+108]
    jmp QWORD PTR [g_real+216]
glColor3ub ENDP
PUBLIC glColor3ubv
glColor3ubv PROC
    inc DWORD PTR [g_counts+112]
    jmp QWORD PTR [g_real+224]
glColor3ubv ENDP
PUBLIC glColor3ui
glColor3ui PROC
    inc DWORD PTR [g_counts+116]
    jmp QWORD PTR [g_real+232]
glColor3ui ENDP
PUBLIC glColor3uiv
glColor3uiv PROC
    inc DWORD PTR [g_counts+120]
    jmp QWORD PTR [g_real+240]
glColor3uiv ENDP
PUBLIC glColor3us
glColor3us PROC
    inc DWORD PTR [g_counts+124]
    jmp QWORD PTR [g_real+248]
glColor3us ENDP
PUBLIC glColor3usv
glColor3usv PROC
    inc DWORD PTR [g_counts+128]
    jmp QWORD PTR [g_real+256]
glColor3usv ENDP
PUBLIC glColor4b
glColor4b PROC
    inc DWORD PTR [g_counts+132]
    jmp QWORD PTR [g_real+264]
glColor4b ENDP
PUBLIC glColor4bv
glColor4bv PROC
    inc DWORD PTR [g_counts+136]
    jmp QWORD PTR [g_real+272]
glColor4bv ENDP
PUBLIC glColor4d
glColor4d PROC
    inc DWORD PTR [g_counts+140]
    jmp QWORD PTR [g_real+280]
glColor4d ENDP
PUBLIC glColor4dv
glColor4dv PROC
    inc DWORD PTR [g_counts+144]
    jmp QWORD PTR [g_real+288]
glColor4dv ENDP
PUBLIC glColor4f
glColor4f PROC
    inc DWORD PTR [g_counts+148]
    jmp QWORD PTR [g_real+296]
glColor4f ENDP
PUBLIC glColor4fv
glColor4fv PROC
    inc DWORD PTR [g_counts+152]
    jmp QWORD PTR [g_real+304]
glColor4fv ENDP
PUBLIC glColor4i
glColor4i PROC
    inc DWORD PTR [g_counts+156]
    jmp QWORD PTR [g_real+312]
glColor4i ENDP
PUBLIC glColor4iv
glColor4iv PROC
    inc DWORD PTR [g_counts+160]
    jmp QWORD PTR [g_real+320]
glColor4iv ENDP
PUBLIC glColor4s
glColor4s PROC
    inc DWORD PTR [g_counts+164]
    jmp QWORD PTR [g_real+328]
glColor4s ENDP
PUBLIC glColor4sv
glColor4sv PROC
    inc DWORD PTR [g_counts+168]
    jmp QWORD PTR [g_real+336]
glColor4sv ENDP
PUBLIC glColor4ub
glColor4ub PROC
    inc DWORD PTR [g_counts+172]
    jmp QWORD PTR [g_real+344]
glColor4ub ENDP
PUBLIC glColor4ubv
glColor4ubv PROC
    inc DWORD PTR [g_counts+176]
    jmp QWORD PTR [g_real+352]
glColor4ubv ENDP
PUBLIC glColor4ui
glColor4ui PROC
    inc DWORD PTR [g_counts+180]
    jmp QWORD PTR [g_real+360]
glColor4ui ENDP
PUBLIC glColor4uiv
glColor4uiv PROC
    inc DWORD PTR [g_counts+184]
    jmp QWORD PTR [g_real+368]
glColor4uiv ENDP
PUBLIC glColor4us
glColor4us PROC
    inc DWORD PTR [g_counts+188]
    jmp QWORD PTR [g_real+376]
glColor4us ENDP
PUBLIC glColor4usv
glColor4usv PROC
    inc DWORD PTR [g_counts+192]
    jmp QWORD PTR [g_real+384]
glColor4usv ENDP
PUBLIC glColorMask
glColorMask PROC
    inc DWORD PTR [g_counts+196]
    jmp QWORD PTR [g_real+392]
glColorMask ENDP
PUBLIC glColorMaterial
glColorMaterial PROC
    inc DWORD PTR [g_counts+200]
    jmp QWORD PTR [g_real+400]
glColorMaterial ENDP
PUBLIC glColorPointer
glColorPointer PROC
    inc DWORD PTR [g_counts+204]
    jmp QWORD PTR [g_real+408]
glColorPointer ENDP
PUBLIC glCopyPixels
glCopyPixels PROC
    inc DWORD PTR [g_counts+208]
    jmp QWORD PTR [g_real+416]
glCopyPixels ENDP
PUBLIC glCopyTexImage1D
glCopyTexImage1D PROC
    inc DWORD PTR [g_counts+212]
    jmp QWORD PTR [g_real+424]
glCopyTexImage1D ENDP
PUBLIC glCopyTexImage2D
glCopyTexImage2D PROC
    inc DWORD PTR [g_counts+216]
    jmp QWORD PTR [g_real+432]
glCopyTexImage2D ENDP
PUBLIC glCopyTexSubImage1D
glCopyTexSubImage1D PROC
    inc DWORD PTR [g_counts+220]
    jmp QWORD PTR [g_real+440]
glCopyTexSubImage1D ENDP
PUBLIC glCopyTexSubImage2D
glCopyTexSubImage2D PROC
    inc DWORD PTR [g_counts+224]
    jmp QWORD PTR [g_real+448]
glCopyTexSubImage2D ENDP
PUBLIC glCullFace
glCullFace PROC
    inc DWORD PTR [g_counts+228]
    jmp QWORD PTR [g_real+456]
glCullFace ENDP
PUBLIC glDebugEntry
glDebugEntry PROC
    inc DWORD PTR [g_counts+232]
    jmp QWORD PTR [g_real+464]
glDebugEntry ENDP
PUBLIC glDeleteLists
glDeleteLists PROC
    inc DWORD PTR [g_counts+236]
    jmp QWORD PTR [g_real+472]
glDeleteLists ENDP
PUBLIC glDeleteTextures
glDeleteTextures PROC
    inc DWORD PTR [g_counts+240]
    jmp QWORD PTR [g_real+480]
glDeleteTextures ENDP
PUBLIC glDepthFunc
glDepthFunc PROC
    inc DWORD PTR [g_counts+244]
    jmp QWORD PTR [g_real+488]
glDepthFunc ENDP
PUBLIC glDepthMask
glDepthMask PROC
    inc DWORD PTR [g_counts+248]
    jmp QWORD PTR [g_real+496]
glDepthMask ENDP
PUBLIC glDepthRange
glDepthRange PROC
    inc DWORD PTR [g_counts+252]
    jmp QWORD PTR [g_real+504]
glDepthRange ENDP
PUBLIC glDisable
glDisable PROC
    inc DWORD PTR [g_counts+256]
    jmp QWORD PTR [g_real+512]
glDisable ENDP
PUBLIC glDisableClientState
glDisableClientState PROC
    inc DWORD PTR [g_counts+260]
    jmp QWORD PTR [g_real+520]
glDisableClientState ENDP
PUBLIC glDrawArrays
glDrawArrays PROC
    inc DWORD PTR [g_counts+264]
    jmp QWORD PTR [g_real+528]
glDrawArrays ENDP
PUBLIC glDrawBuffer
glDrawBuffer PROC
    inc DWORD PTR [g_counts+268]
    jmp QWORD PTR [g_real+536]
glDrawBuffer ENDP
PUBLIC glDrawElements
glDrawElements PROC
    inc DWORD PTR [g_counts+272]
    jmp QWORD PTR [g_real+544]
glDrawElements ENDP
PUBLIC glDrawPixels
glDrawPixels PROC
    inc DWORD PTR [g_counts+276]
    jmp QWORD PTR [g_real+552]
glDrawPixels ENDP
PUBLIC glEdgeFlag
glEdgeFlag PROC
    inc DWORD PTR [g_counts+280]
    jmp QWORD PTR [g_real+560]
glEdgeFlag ENDP
PUBLIC glEdgeFlagPointer
glEdgeFlagPointer PROC
    inc DWORD PTR [g_counts+284]
    jmp QWORD PTR [g_real+568]
glEdgeFlagPointer ENDP
PUBLIC glEdgeFlagv
glEdgeFlagv PROC
    inc DWORD PTR [g_counts+288]
    jmp QWORD PTR [g_real+576]
glEdgeFlagv ENDP
PUBLIC glEnable
glEnable PROC
    inc DWORD PTR [g_counts+292]
    jmp QWORD PTR [g_real+584]
glEnable ENDP
PUBLIC glEnableClientState
glEnableClientState PROC
    inc DWORD PTR [g_counts+296]
    jmp QWORD PTR [g_real+592]
glEnableClientState ENDP
PUBLIC glEnd
glEnd PROC
    inc DWORD PTR [g_counts+300]
    jmp QWORD PTR [g_real+600]
glEnd ENDP
PUBLIC glEndList
glEndList PROC
    inc DWORD PTR [g_counts+304]
    jmp QWORD PTR [g_real+608]
glEndList ENDP
PUBLIC glEvalCoord1d
glEvalCoord1d PROC
    inc DWORD PTR [g_counts+308]
    jmp QWORD PTR [g_real+616]
glEvalCoord1d ENDP
PUBLIC glEvalCoord1dv
glEvalCoord1dv PROC
    inc DWORD PTR [g_counts+312]
    jmp QWORD PTR [g_real+624]
glEvalCoord1dv ENDP
PUBLIC glEvalCoord1f
glEvalCoord1f PROC
    inc DWORD PTR [g_counts+316]
    jmp QWORD PTR [g_real+632]
glEvalCoord1f ENDP
PUBLIC glEvalCoord1fv
glEvalCoord1fv PROC
    inc DWORD PTR [g_counts+320]
    jmp QWORD PTR [g_real+640]
glEvalCoord1fv ENDP
PUBLIC glEvalCoord2d
glEvalCoord2d PROC
    inc DWORD PTR [g_counts+324]
    jmp QWORD PTR [g_real+648]
glEvalCoord2d ENDP
PUBLIC glEvalCoord2dv
glEvalCoord2dv PROC
    inc DWORD PTR [g_counts+328]
    jmp QWORD PTR [g_real+656]
glEvalCoord2dv ENDP
PUBLIC glEvalCoord2f
glEvalCoord2f PROC
    inc DWORD PTR [g_counts+332]
    jmp QWORD PTR [g_real+664]
glEvalCoord2f ENDP
PUBLIC glEvalCoord2fv
glEvalCoord2fv PROC
    inc DWORD PTR [g_counts+336]
    jmp QWORD PTR [g_real+672]
glEvalCoord2fv ENDP
PUBLIC glEvalMesh1
glEvalMesh1 PROC
    inc DWORD PTR [g_counts+340]
    jmp QWORD PTR [g_real+680]
glEvalMesh1 ENDP
PUBLIC glEvalMesh2
glEvalMesh2 PROC
    inc DWORD PTR [g_counts+344]
    jmp QWORD PTR [g_real+688]
glEvalMesh2 ENDP
PUBLIC glEvalPoint1
glEvalPoint1 PROC
    inc DWORD PTR [g_counts+348]
    jmp QWORD PTR [g_real+696]
glEvalPoint1 ENDP
PUBLIC glEvalPoint2
glEvalPoint2 PROC
    inc DWORD PTR [g_counts+352]
    jmp QWORD PTR [g_real+704]
glEvalPoint2 ENDP
PUBLIC glFeedbackBuffer
glFeedbackBuffer PROC
    inc DWORD PTR [g_counts+356]
    jmp QWORD PTR [g_real+712]
glFeedbackBuffer ENDP
PUBLIC glFinish
glFinish PROC
    inc DWORD PTR [g_counts+360]
    jmp QWORD PTR [g_real+720]
glFinish ENDP
PUBLIC glFlush
glFlush PROC
    inc DWORD PTR [g_counts+364]
    jmp QWORD PTR [g_real+728]
glFlush ENDP
PUBLIC glFogf
glFogf PROC
    inc DWORD PTR [g_counts+368]
    jmp QWORD PTR [g_real+736]
glFogf ENDP
PUBLIC glFogfv
glFogfv PROC
    inc DWORD PTR [g_counts+372]
    jmp QWORD PTR [g_real+744]
glFogfv ENDP
PUBLIC glFogi
glFogi PROC
    inc DWORD PTR [g_counts+376]
    jmp QWORD PTR [g_real+752]
glFogi ENDP
PUBLIC glFogiv
glFogiv PROC
    inc DWORD PTR [g_counts+380]
    jmp QWORD PTR [g_real+760]
glFogiv ENDP
PUBLIC glFrontFace
glFrontFace PROC
    inc DWORD PTR [g_counts+384]
    jmp QWORD PTR [g_real+768]
glFrontFace ENDP
PUBLIC glFrustum
glFrustum PROC
    inc DWORD PTR [g_counts+388]
    jmp QWORD PTR [g_real+776]
glFrustum ENDP
PUBLIC glGenLists
glGenLists PROC
    inc DWORD PTR [g_counts+392]
    jmp QWORD PTR [g_real+784]
glGenLists ENDP
PUBLIC glGenTextures
glGenTextures PROC
    inc DWORD PTR [g_counts+396]
    jmp QWORD PTR [g_real+792]
glGenTextures ENDP
PUBLIC glGetBooleanv
glGetBooleanv PROC
    inc DWORD PTR [g_counts+400]
    jmp QWORD PTR [g_real+800]
glGetBooleanv ENDP
PUBLIC glGetClipPlane
glGetClipPlane PROC
    inc DWORD PTR [g_counts+404]
    jmp QWORD PTR [g_real+808]
glGetClipPlane ENDP
PUBLIC glGetDoublev
glGetDoublev PROC
    inc DWORD PTR [g_counts+408]
    jmp QWORD PTR [g_real+816]
glGetDoublev ENDP
PUBLIC glGetError
glGetError PROC
    inc DWORD PTR [g_counts+412]
    jmp QWORD PTR [g_real+824]
glGetError ENDP
PUBLIC glGetFloatv
glGetFloatv PROC
    inc DWORD PTR [g_counts+416]
    jmp QWORD PTR [g_real+832]
glGetFloatv ENDP
PUBLIC glGetIntegerv
glGetIntegerv PROC
    inc DWORD PTR [g_counts+420]
    jmp QWORD PTR [g_real+840]
glGetIntegerv ENDP
PUBLIC glGetLightfv
glGetLightfv PROC
    inc DWORD PTR [g_counts+424]
    jmp QWORD PTR [g_real+848]
glGetLightfv ENDP
PUBLIC glGetLightiv
glGetLightiv PROC
    inc DWORD PTR [g_counts+428]
    jmp QWORD PTR [g_real+856]
glGetLightiv ENDP
PUBLIC glGetMapdv
glGetMapdv PROC
    inc DWORD PTR [g_counts+432]
    jmp QWORD PTR [g_real+864]
glGetMapdv ENDP
PUBLIC glGetMapfv
glGetMapfv PROC
    inc DWORD PTR [g_counts+436]
    jmp QWORD PTR [g_real+872]
glGetMapfv ENDP
PUBLIC glGetMapiv
glGetMapiv PROC
    inc DWORD PTR [g_counts+440]
    jmp QWORD PTR [g_real+880]
glGetMapiv ENDP
PUBLIC glGetMaterialfv
glGetMaterialfv PROC
    inc DWORD PTR [g_counts+444]
    jmp QWORD PTR [g_real+888]
glGetMaterialfv ENDP
PUBLIC glGetMaterialiv
glGetMaterialiv PROC
    inc DWORD PTR [g_counts+448]
    jmp QWORD PTR [g_real+896]
glGetMaterialiv ENDP
PUBLIC glGetPixelMapfv
glGetPixelMapfv PROC
    inc DWORD PTR [g_counts+452]
    jmp QWORD PTR [g_real+904]
glGetPixelMapfv ENDP
PUBLIC glGetPixelMapuiv
glGetPixelMapuiv PROC
    inc DWORD PTR [g_counts+456]
    jmp QWORD PTR [g_real+912]
glGetPixelMapuiv ENDP
PUBLIC glGetPixelMapusv
glGetPixelMapusv PROC
    inc DWORD PTR [g_counts+460]
    jmp QWORD PTR [g_real+920]
glGetPixelMapusv ENDP
PUBLIC glGetPointerv
glGetPointerv PROC
    inc DWORD PTR [g_counts+464]
    jmp QWORD PTR [g_real+928]
glGetPointerv ENDP
PUBLIC glGetPolygonStipple
glGetPolygonStipple PROC
    inc DWORD PTR [g_counts+468]
    jmp QWORD PTR [g_real+936]
glGetPolygonStipple ENDP
PUBLIC glGetString
glGetString PROC
    inc DWORD PTR [g_counts+472]
    jmp QWORD PTR [g_real+944]
glGetString ENDP
PUBLIC glGetTexEnvfv
glGetTexEnvfv PROC
    inc DWORD PTR [g_counts+476]
    jmp QWORD PTR [g_real+952]
glGetTexEnvfv ENDP
PUBLIC glGetTexEnviv
glGetTexEnviv PROC
    inc DWORD PTR [g_counts+480]
    jmp QWORD PTR [g_real+960]
glGetTexEnviv ENDP
PUBLIC glGetTexGendv
glGetTexGendv PROC
    inc DWORD PTR [g_counts+484]
    jmp QWORD PTR [g_real+968]
glGetTexGendv ENDP
PUBLIC glGetTexGenfv
glGetTexGenfv PROC
    inc DWORD PTR [g_counts+488]
    jmp QWORD PTR [g_real+976]
glGetTexGenfv ENDP
PUBLIC glGetTexGeniv
glGetTexGeniv PROC
    inc DWORD PTR [g_counts+492]
    jmp QWORD PTR [g_real+984]
glGetTexGeniv ENDP
PUBLIC glGetTexImage
glGetTexImage PROC
    inc DWORD PTR [g_counts+496]
    jmp QWORD PTR [g_real+992]
glGetTexImage ENDP
PUBLIC glGetTexLevelParameterfv
glGetTexLevelParameterfv PROC
    inc DWORD PTR [g_counts+500]
    jmp QWORD PTR [g_real+1000]
glGetTexLevelParameterfv ENDP
PUBLIC glGetTexLevelParameteriv
glGetTexLevelParameteriv PROC
    inc DWORD PTR [g_counts+504]
    jmp QWORD PTR [g_real+1008]
glGetTexLevelParameteriv ENDP
PUBLIC glGetTexParameterfv
glGetTexParameterfv PROC
    inc DWORD PTR [g_counts+508]
    jmp QWORD PTR [g_real+1016]
glGetTexParameterfv ENDP
PUBLIC glGetTexParameteriv
glGetTexParameteriv PROC
    inc DWORD PTR [g_counts+512]
    jmp QWORD PTR [g_real+1024]
glGetTexParameteriv ENDP
PUBLIC glHint
glHint PROC
    inc DWORD PTR [g_counts+516]
    jmp QWORD PTR [g_real+1032]
glHint ENDP
PUBLIC glIndexMask
glIndexMask PROC
    inc DWORD PTR [g_counts+520]
    jmp QWORD PTR [g_real+1040]
glIndexMask ENDP
PUBLIC glIndexPointer
glIndexPointer PROC
    inc DWORD PTR [g_counts+524]
    jmp QWORD PTR [g_real+1048]
glIndexPointer ENDP
PUBLIC glIndexd
glIndexd PROC
    inc DWORD PTR [g_counts+528]
    jmp QWORD PTR [g_real+1056]
glIndexd ENDP
PUBLIC glIndexdv
glIndexdv PROC
    inc DWORD PTR [g_counts+532]
    jmp QWORD PTR [g_real+1064]
glIndexdv ENDP
PUBLIC glIndexf
glIndexf PROC
    inc DWORD PTR [g_counts+536]
    jmp QWORD PTR [g_real+1072]
glIndexf ENDP
PUBLIC glIndexfv
glIndexfv PROC
    inc DWORD PTR [g_counts+540]
    jmp QWORD PTR [g_real+1080]
glIndexfv ENDP
PUBLIC glIndexi
glIndexi PROC
    inc DWORD PTR [g_counts+544]
    jmp QWORD PTR [g_real+1088]
glIndexi ENDP
PUBLIC glIndexiv
glIndexiv PROC
    inc DWORD PTR [g_counts+548]
    jmp QWORD PTR [g_real+1096]
glIndexiv ENDP
PUBLIC glIndexs
glIndexs PROC
    inc DWORD PTR [g_counts+552]
    jmp QWORD PTR [g_real+1104]
glIndexs ENDP
PUBLIC glIndexsv
glIndexsv PROC
    inc DWORD PTR [g_counts+556]
    jmp QWORD PTR [g_real+1112]
glIndexsv ENDP
PUBLIC glIndexub
glIndexub PROC
    inc DWORD PTR [g_counts+560]
    jmp QWORD PTR [g_real+1120]
glIndexub ENDP
PUBLIC glIndexubv
glIndexubv PROC
    inc DWORD PTR [g_counts+564]
    jmp QWORD PTR [g_real+1128]
glIndexubv ENDP
PUBLIC glInitNames
glInitNames PROC
    inc DWORD PTR [g_counts+568]
    jmp QWORD PTR [g_real+1136]
glInitNames ENDP
PUBLIC glInterleavedArrays
glInterleavedArrays PROC
    inc DWORD PTR [g_counts+572]
    jmp QWORD PTR [g_real+1144]
glInterleavedArrays ENDP
PUBLIC glIsEnabled
glIsEnabled PROC
    inc DWORD PTR [g_counts+576]
    jmp QWORD PTR [g_real+1152]
glIsEnabled ENDP
PUBLIC glIsList
glIsList PROC
    inc DWORD PTR [g_counts+580]
    jmp QWORD PTR [g_real+1160]
glIsList ENDP
PUBLIC glIsTexture
glIsTexture PROC
    inc DWORD PTR [g_counts+584]
    jmp QWORD PTR [g_real+1168]
glIsTexture ENDP
PUBLIC glLightModelf
glLightModelf PROC
    inc DWORD PTR [g_counts+588]
    jmp QWORD PTR [g_real+1176]
glLightModelf ENDP
PUBLIC glLightModelfv
glLightModelfv PROC
    inc DWORD PTR [g_counts+592]
    jmp QWORD PTR [g_real+1184]
glLightModelfv ENDP
PUBLIC glLightModeli
glLightModeli PROC
    inc DWORD PTR [g_counts+596]
    jmp QWORD PTR [g_real+1192]
glLightModeli ENDP
PUBLIC glLightModeliv
glLightModeliv PROC
    inc DWORD PTR [g_counts+600]
    jmp QWORD PTR [g_real+1200]
glLightModeliv ENDP
PUBLIC glLightf
glLightf PROC
    inc DWORD PTR [g_counts+604]
    jmp QWORD PTR [g_real+1208]
glLightf ENDP
PUBLIC glLightfv
glLightfv PROC
    inc DWORD PTR [g_counts+608]
    jmp QWORD PTR [g_real+1216]
glLightfv ENDP
PUBLIC glLighti
glLighti PROC
    inc DWORD PTR [g_counts+612]
    jmp QWORD PTR [g_real+1224]
glLighti ENDP
PUBLIC glLightiv
glLightiv PROC
    inc DWORD PTR [g_counts+616]
    jmp QWORD PTR [g_real+1232]
glLightiv ENDP
PUBLIC glLineStipple
glLineStipple PROC
    inc DWORD PTR [g_counts+620]
    jmp QWORD PTR [g_real+1240]
glLineStipple ENDP
PUBLIC glLineWidth
glLineWidth PROC
    inc DWORD PTR [g_counts+624]
    jmp QWORD PTR [g_real+1248]
glLineWidth ENDP
PUBLIC glListBase
glListBase PROC
    inc DWORD PTR [g_counts+628]
    jmp QWORD PTR [g_real+1256]
glListBase ENDP
PUBLIC glLoadIdentity
glLoadIdentity PROC
    inc DWORD PTR [g_counts+632]
    jmp QWORD PTR [g_real+1264]
glLoadIdentity ENDP
PUBLIC glLoadMatrixd
glLoadMatrixd PROC
    inc DWORD PTR [g_counts+636]
    jmp QWORD PTR [g_real+1272]
glLoadMatrixd ENDP
PUBLIC glLoadMatrixf
glLoadMatrixf PROC
    inc DWORD PTR [g_counts+640]
    jmp QWORD PTR [g_real+1280]
glLoadMatrixf ENDP
PUBLIC glLoadName
glLoadName PROC
    inc DWORD PTR [g_counts+644]
    jmp QWORD PTR [g_real+1288]
glLoadName ENDP
PUBLIC glLogicOp
glLogicOp PROC
    inc DWORD PTR [g_counts+648]
    jmp QWORD PTR [g_real+1296]
glLogicOp ENDP
PUBLIC glMap1d
glMap1d PROC
    inc DWORD PTR [g_counts+652]
    jmp QWORD PTR [g_real+1304]
glMap1d ENDP
PUBLIC glMap1f
glMap1f PROC
    inc DWORD PTR [g_counts+656]
    jmp QWORD PTR [g_real+1312]
glMap1f ENDP
PUBLIC glMap2d
glMap2d PROC
    inc DWORD PTR [g_counts+660]
    jmp QWORD PTR [g_real+1320]
glMap2d ENDP
PUBLIC glMap2f
glMap2f PROC
    inc DWORD PTR [g_counts+664]
    jmp QWORD PTR [g_real+1328]
glMap2f ENDP
PUBLIC glMapGrid1d
glMapGrid1d PROC
    inc DWORD PTR [g_counts+668]
    jmp QWORD PTR [g_real+1336]
glMapGrid1d ENDP
PUBLIC glMapGrid1f
glMapGrid1f PROC
    inc DWORD PTR [g_counts+672]
    jmp QWORD PTR [g_real+1344]
glMapGrid1f ENDP
PUBLIC glMapGrid2d
glMapGrid2d PROC
    inc DWORD PTR [g_counts+676]
    jmp QWORD PTR [g_real+1352]
glMapGrid2d ENDP
PUBLIC glMapGrid2f
glMapGrid2f PROC
    inc DWORD PTR [g_counts+680]
    jmp QWORD PTR [g_real+1360]
glMapGrid2f ENDP
PUBLIC glMaterialf
glMaterialf PROC
    inc DWORD PTR [g_counts+684]
    jmp QWORD PTR [g_real+1368]
glMaterialf ENDP
PUBLIC glMaterialfv
glMaterialfv PROC
    inc DWORD PTR [g_counts+688]
    jmp QWORD PTR [g_real+1376]
glMaterialfv ENDP
PUBLIC glMateriali
glMateriali PROC
    inc DWORD PTR [g_counts+692]
    jmp QWORD PTR [g_real+1384]
glMateriali ENDP
PUBLIC glMaterialiv
glMaterialiv PROC
    inc DWORD PTR [g_counts+696]
    jmp QWORD PTR [g_real+1392]
glMaterialiv ENDP
PUBLIC glMatrixMode
glMatrixMode PROC
    inc DWORD PTR [g_counts+700]
    jmp QWORD PTR [g_real+1400]
glMatrixMode ENDP
PUBLIC glMultMatrixd
glMultMatrixd PROC
    inc DWORD PTR [g_counts+704]
    jmp QWORD PTR [g_real+1408]
glMultMatrixd ENDP
PUBLIC glMultMatrixf
glMultMatrixf PROC
    inc DWORD PTR [g_counts+708]
    jmp QWORD PTR [g_real+1416]
glMultMatrixf ENDP
PUBLIC glNewList
glNewList PROC
    inc DWORD PTR [g_counts+712]
    jmp QWORD PTR [g_real+1424]
glNewList ENDP
PUBLIC glNormal3b
glNormal3b PROC
    inc DWORD PTR [g_counts+716]
    jmp QWORD PTR [g_real+1432]
glNormal3b ENDP
PUBLIC glNormal3bv
glNormal3bv PROC
    inc DWORD PTR [g_counts+720]
    jmp QWORD PTR [g_real+1440]
glNormal3bv ENDP
PUBLIC glNormal3d
glNormal3d PROC
    inc DWORD PTR [g_counts+724]
    jmp QWORD PTR [g_real+1448]
glNormal3d ENDP
PUBLIC glNormal3dv
glNormal3dv PROC
    inc DWORD PTR [g_counts+728]
    jmp QWORD PTR [g_real+1456]
glNormal3dv ENDP
PUBLIC glNormal3f
glNormal3f PROC
    inc DWORD PTR [g_counts+732]
    jmp QWORD PTR [g_real+1464]
glNormal3f ENDP
PUBLIC glNormal3fv
glNormal3fv PROC
    inc DWORD PTR [g_counts+736]
    jmp QWORD PTR [g_real+1472]
glNormal3fv ENDP
PUBLIC glNormal3i
glNormal3i PROC
    inc DWORD PTR [g_counts+740]
    jmp QWORD PTR [g_real+1480]
glNormal3i ENDP
PUBLIC glNormal3iv
glNormal3iv PROC
    inc DWORD PTR [g_counts+744]
    jmp QWORD PTR [g_real+1488]
glNormal3iv ENDP
PUBLIC glNormal3s
glNormal3s PROC
    inc DWORD PTR [g_counts+748]
    jmp QWORD PTR [g_real+1496]
glNormal3s ENDP
PUBLIC glNormal3sv
glNormal3sv PROC
    inc DWORD PTR [g_counts+752]
    jmp QWORD PTR [g_real+1504]
glNormal3sv ENDP
PUBLIC glNormalPointer
glNormalPointer PROC
    inc DWORD PTR [g_counts+756]
    jmp QWORD PTR [g_real+1512]
glNormalPointer ENDP
PUBLIC glOrtho
glOrtho PROC
    inc DWORD PTR [g_counts+760]
    jmp QWORD PTR [g_real+1520]
glOrtho ENDP
PUBLIC glPassThrough
glPassThrough PROC
    inc DWORD PTR [g_counts+764]
    jmp QWORD PTR [g_real+1528]
glPassThrough ENDP
PUBLIC glPixelMapfv
glPixelMapfv PROC
    inc DWORD PTR [g_counts+768]
    jmp QWORD PTR [g_real+1536]
glPixelMapfv ENDP
PUBLIC glPixelMapuiv
glPixelMapuiv PROC
    inc DWORD PTR [g_counts+772]
    jmp QWORD PTR [g_real+1544]
glPixelMapuiv ENDP
PUBLIC glPixelMapusv
glPixelMapusv PROC
    inc DWORD PTR [g_counts+776]
    jmp QWORD PTR [g_real+1552]
glPixelMapusv ENDP
PUBLIC glPixelStoref
glPixelStoref PROC
    inc DWORD PTR [g_counts+780]
    jmp QWORD PTR [g_real+1560]
glPixelStoref ENDP
PUBLIC glPixelStorei
glPixelStorei PROC
    inc DWORD PTR [g_counts+784]
    jmp QWORD PTR [g_real+1568]
glPixelStorei ENDP
PUBLIC glPixelTransferf
glPixelTransferf PROC
    inc DWORD PTR [g_counts+788]
    jmp QWORD PTR [g_real+1576]
glPixelTransferf ENDP
PUBLIC glPixelTransferi
glPixelTransferi PROC
    inc DWORD PTR [g_counts+792]
    jmp QWORD PTR [g_real+1584]
glPixelTransferi ENDP
PUBLIC glPixelZoom
glPixelZoom PROC
    inc DWORD PTR [g_counts+796]
    jmp QWORD PTR [g_real+1592]
glPixelZoom ENDP
PUBLIC glPointSize
glPointSize PROC
    inc DWORD PTR [g_counts+800]
    jmp QWORD PTR [g_real+1600]
glPointSize ENDP
PUBLIC glPolygonMode
glPolygonMode PROC
    inc DWORD PTR [g_counts+804]
    jmp QWORD PTR [g_real+1608]
glPolygonMode ENDP
PUBLIC glPolygonOffset
glPolygonOffset PROC
    inc DWORD PTR [g_counts+808]
    jmp QWORD PTR [g_real+1616]
glPolygonOffset ENDP
PUBLIC glPolygonStipple
glPolygonStipple PROC
    inc DWORD PTR [g_counts+812]
    jmp QWORD PTR [g_real+1624]
glPolygonStipple ENDP
PUBLIC glPopAttrib
glPopAttrib PROC
    inc DWORD PTR [g_counts+816]
    jmp QWORD PTR [g_real+1632]
glPopAttrib ENDP
PUBLIC glPopClientAttrib
glPopClientAttrib PROC
    inc DWORD PTR [g_counts+820]
    jmp QWORD PTR [g_real+1640]
glPopClientAttrib ENDP
PUBLIC glPopMatrix
glPopMatrix PROC
    inc DWORD PTR [g_counts+824]
    jmp QWORD PTR [g_real+1648]
glPopMatrix ENDP
PUBLIC glPopName
glPopName PROC
    inc DWORD PTR [g_counts+828]
    jmp QWORD PTR [g_real+1656]
glPopName ENDP
PUBLIC glPrioritizeTextures
glPrioritizeTextures PROC
    inc DWORD PTR [g_counts+832]
    jmp QWORD PTR [g_real+1664]
glPrioritizeTextures ENDP
PUBLIC glPushAttrib
glPushAttrib PROC
    inc DWORD PTR [g_counts+836]
    jmp QWORD PTR [g_real+1672]
glPushAttrib ENDP
PUBLIC glPushClientAttrib
glPushClientAttrib PROC
    inc DWORD PTR [g_counts+840]
    jmp QWORD PTR [g_real+1680]
glPushClientAttrib ENDP
PUBLIC glPushMatrix
glPushMatrix PROC
    inc DWORD PTR [g_counts+844]
    jmp QWORD PTR [g_real+1688]
glPushMatrix ENDP
PUBLIC glPushName
glPushName PROC
    inc DWORD PTR [g_counts+848]
    jmp QWORD PTR [g_real+1696]
glPushName ENDP
PUBLIC glRasterPos2d
glRasterPos2d PROC
    inc DWORD PTR [g_counts+852]
    jmp QWORD PTR [g_real+1704]
glRasterPos2d ENDP
PUBLIC glRasterPos2dv
glRasterPos2dv PROC
    inc DWORD PTR [g_counts+856]
    jmp QWORD PTR [g_real+1712]
glRasterPos2dv ENDP
PUBLIC glRasterPos2f
glRasterPos2f PROC
    inc DWORD PTR [g_counts+860]
    jmp QWORD PTR [g_real+1720]
glRasterPos2f ENDP
PUBLIC glRasterPos2fv
glRasterPos2fv PROC
    inc DWORD PTR [g_counts+864]
    jmp QWORD PTR [g_real+1728]
glRasterPos2fv ENDP
PUBLIC glRasterPos2i
glRasterPos2i PROC
    inc DWORD PTR [g_counts+868]
    jmp QWORD PTR [g_real+1736]
glRasterPos2i ENDP
PUBLIC glRasterPos2iv
glRasterPos2iv PROC
    inc DWORD PTR [g_counts+872]
    jmp QWORD PTR [g_real+1744]
glRasterPos2iv ENDP
PUBLIC glRasterPos2s
glRasterPos2s PROC
    inc DWORD PTR [g_counts+876]
    jmp QWORD PTR [g_real+1752]
glRasterPos2s ENDP
PUBLIC glRasterPos2sv
glRasterPos2sv PROC
    inc DWORD PTR [g_counts+880]
    jmp QWORD PTR [g_real+1760]
glRasterPos2sv ENDP
PUBLIC glRasterPos3d
glRasterPos3d PROC
    inc DWORD PTR [g_counts+884]
    jmp QWORD PTR [g_real+1768]
glRasterPos3d ENDP
PUBLIC glRasterPos3dv
glRasterPos3dv PROC
    inc DWORD PTR [g_counts+888]
    jmp QWORD PTR [g_real+1776]
glRasterPos3dv ENDP
PUBLIC glRasterPos3f
glRasterPos3f PROC
    inc DWORD PTR [g_counts+892]
    jmp QWORD PTR [g_real+1784]
glRasterPos3f ENDP
PUBLIC glRasterPos3fv
glRasterPos3fv PROC
    inc DWORD PTR [g_counts+896]
    jmp QWORD PTR [g_real+1792]
glRasterPos3fv ENDP
PUBLIC glRasterPos3i
glRasterPos3i PROC
    inc DWORD PTR [g_counts+900]
    jmp QWORD PTR [g_real+1800]
glRasterPos3i ENDP
PUBLIC glRasterPos3iv
glRasterPos3iv PROC
    inc DWORD PTR [g_counts+904]
    jmp QWORD PTR [g_real+1808]
glRasterPos3iv ENDP
PUBLIC glRasterPos3s
glRasterPos3s PROC
    inc DWORD PTR [g_counts+908]
    jmp QWORD PTR [g_real+1816]
glRasterPos3s ENDP
PUBLIC glRasterPos3sv
glRasterPos3sv PROC
    inc DWORD PTR [g_counts+912]
    jmp QWORD PTR [g_real+1824]
glRasterPos3sv ENDP
PUBLIC glRasterPos4d
glRasterPos4d PROC
    inc DWORD PTR [g_counts+916]
    jmp QWORD PTR [g_real+1832]
glRasterPos4d ENDP
PUBLIC glRasterPos4dv
glRasterPos4dv PROC
    inc DWORD PTR [g_counts+920]
    jmp QWORD PTR [g_real+1840]
glRasterPos4dv ENDP
PUBLIC glRasterPos4f
glRasterPos4f PROC
    inc DWORD PTR [g_counts+924]
    jmp QWORD PTR [g_real+1848]
glRasterPos4f ENDP
PUBLIC glRasterPos4fv
glRasterPos4fv PROC
    inc DWORD PTR [g_counts+928]
    jmp QWORD PTR [g_real+1856]
glRasterPos4fv ENDP
PUBLIC glRasterPos4i
glRasterPos4i PROC
    inc DWORD PTR [g_counts+932]
    jmp QWORD PTR [g_real+1864]
glRasterPos4i ENDP
PUBLIC glRasterPos4iv
glRasterPos4iv PROC
    inc DWORD PTR [g_counts+936]
    jmp QWORD PTR [g_real+1872]
glRasterPos4iv ENDP
PUBLIC glRasterPos4s
glRasterPos4s PROC
    inc DWORD PTR [g_counts+940]
    jmp QWORD PTR [g_real+1880]
glRasterPos4s ENDP
PUBLIC glRasterPos4sv
glRasterPos4sv PROC
    inc DWORD PTR [g_counts+944]
    jmp QWORD PTR [g_real+1888]
glRasterPos4sv ENDP
PUBLIC glReadBuffer
glReadBuffer PROC
    inc DWORD PTR [g_counts+948]
    jmp QWORD PTR [g_real+1896]
glReadBuffer ENDP
PUBLIC glReadPixels
glReadPixels PROC
    inc DWORD PTR [g_counts+952]
    jmp QWORD PTR [g_real+1904]
glReadPixels ENDP
PUBLIC glRectd
glRectd PROC
    inc DWORD PTR [g_counts+956]
    jmp QWORD PTR [g_real+1912]
glRectd ENDP
PUBLIC glRectdv
glRectdv PROC
    inc DWORD PTR [g_counts+960]
    jmp QWORD PTR [g_real+1920]
glRectdv ENDP
PUBLIC glRectf
glRectf PROC
    inc DWORD PTR [g_counts+964]
    jmp QWORD PTR [g_real+1928]
glRectf ENDP
PUBLIC glRectfv
glRectfv PROC
    inc DWORD PTR [g_counts+968]
    jmp QWORD PTR [g_real+1936]
glRectfv ENDP
PUBLIC glRecti
glRecti PROC
    inc DWORD PTR [g_counts+972]
    jmp QWORD PTR [g_real+1944]
glRecti ENDP
PUBLIC glRectiv
glRectiv PROC
    inc DWORD PTR [g_counts+976]
    jmp QWORD PTR [g_real+1952]
glRectiv ENDP
PUBLIC glRects
glRects PROC
    inc DWORD PTR [g_counts+980]
    jmp QWORD PTR [g_real+1960]
glRects ENDP
PUBLIC glRectsv
glRectsv PROC
    inc DWORD PTR [g_counts+984]
    jmp QWORD PTR [g_real+1968]
glRectsv ENDP
PUBLIC glRenderMode
glRenderMode PROC
    inc DWORD PTR [g_counts+988]
    jmp QWORD PTR [g_real+1976]
glRenderMode ENDP
PUBLIC glRotated
glRotated PROC
    inc DWORD PTR [g_counts+992]
    jmp QWORD PTR [g_real+1984]
glRotated ENDP
PUBLIC glRotatef
glRotatef PROC
    inc DWORD PTR [g_counts+996]
    jmp QWORD PTR [g_real+1992]
glRotatef ENDP
PUBLIC glScaled
glScaled PROC
    inc DWORD PTR [g_counts+1000]
    jmp QWORD PTR [g_real+2000]
glScaled ENDP
PUBLIC glScalef
glScalef PROC
    inc DWORD PTR [g_counts+1004]
    jmp QWORD PTR [g_real+2008]
glScalef ENDP
PUBLIC glScissor
glScissor PROC
    inc DWORD PTR [g_counts+1008]
    jmp QWORD PTR [g_real+2016]
glScissor ENDP
PUBLIC glSelectBuffer
glSelectBuffer PROC
    inc DWORD PTR [g_counts+1012]
    jmp QWORD PTR [g_real+2024]
glSelectBuffer ENDP
PUBLIC glShadeModel
glShadeModel PROC
    inc DWORD PTR [g_counts+1016]
    jmp QWORD PTR [g_real+2032]
glShadeModel ENDP
PUBLIC glStencilFunc
glStencilFunc PROC
    inc DWORD PTR [g_counts+1020]
    jmp QWORD PTR [g_real+2040]
glStencilFunc ENDP
PUBLIC glStencilMask
glStencilMask PROC
    inc DWORD PTR [g_counts+1024]
    jmp QWORD PTR [g_real+2048]
glStencilMask ENDP
PUBLIC glStencilOp
glStencilOp PROC
    inc DWORD PTR [g_counts+1028]
    jmp QWORD PTR [g_real+2056]
glStencilOp ENDP
PUBLIC glTexCoord1d
glTexCoord1d PROC
    inc DWORD PTR [g_counts+1032]
    jmp QWORD PTR [g_real+2064]
glTexCoord1d ENDP
PUBLIC glTexCoord1dv
glTexCoord1dv PROC
    inc DWORD PTR [g_counts+1036]
    jmp QWORD PTR [g_real+2072]
glTexCoord1dv ENDP
PUBLIC glTexCoord1f
glTexCoord1f PROC
    inc DWORD PTR [g_counts+1040]
    jmp QWORD PTR [g_real+2080]
glTexCoord1f ENDP
PUBLIC glTexCoord1fv
glTexCoord1fv PROC
    inc DWORD PTR [g_counts+1044]
    jmp QWORD PTR [g_real+2088]
glTexCoord1fv ENDP
PUBLIC glTexCoord1i
glTexCoord1i PROC
    inc DWORD PTR [g_counts+1048]
    jmp QWORD PTR [g_real+2096]
glTexCoord1i ENDP
PUBLIC glTexCoord1iv
glTexCoord1iv PROC
    inc DWORD PTR [g_counts+1052]
    jmp QWORD PTR [g_real+2104]
glTexCoord1iv ENDP
PUBLIC glTexCoord1s
glTexCoord1s PROC
    inc DWORD PTR [g_counts+1056]
    jmp QWORD PTR [g_real+2112]
glTexCoord1s ENDP
PUBLIC glTexCoord1sv
glTexCoord1sv PROC
    inc DWORD PTR [g_counts+1060]
    jmp QWORD PTR [g_real+2120]
glTexCoord1sv ENDP
PUBLIC glTexCoord2d
glTexCoord2d PROC
    inc DWORD PTR [g_counts+1064]
    jmp QWORD PTR [g_real+2128]
glTexCoord2d ENDP
PUBLIC glTexCoord2dv
glTexCoord2dv PROC
    inc DWORD PTR [g_counts+1068]
    jmp QWORD PTR [g_real+2136]
glTexCoord2dv ENDP
PUBLIC glTexCoord2f
glTexCoord2f PROC
    inc DWORD PTR [g_counts+1072]
    jmp QWORD PTR [g_real+2144]
glTexCoord2f ENDP
PUBLIC glTexCoord2fv
glTexCoord2fv PROC
    inc DWORD PTR [g_counts+1076]
    jmp QWORD PTR [g_real+2152]
glTexCoord2fv ENDP
PUBLIC glTexCoord2i
glTexCoord2i PROC
    inc DWORD PTR [g_counts+1080]
    jmp QWORD PTR [g_real+2160]
glTexCoord2i ENDP
PUBLIC glTexCoord2iv
glTexCoord2iv PROC
    inc DWORD PTR [g_counts+1084]
    jmp QWORD PTR [g_real+2168]
glTexCoord2iv ENDP
PUBLIC glTexCoord2s
glTexCoord2s PROC
    inc DWORD PTR [g_counts+1088]
    jmp QWORD PTR [g_real+2176]
glTexCoord2s ENDP
PUBLIC glTexCoord2sv
glTexCoord2sv PROC
    inc DWORD PTR [g_counts+1092]
    jmp QWORD PTR [g_real+2184]
glTexCoord2sv ENDP
PUBLIC glTexCoord3d
glTexCoord3d PROC
    inc DWORD PTR [g_counts+1096]
    jmp QWORD PTR [g_real+2192]
glTexCoord3d ENDP
PUBLIC glTexCoord3dv
glTexCoord3dv PROC
    inc DWORD PTR [g_counts+1100]
    jmp QWORD PTR [g_real+2200]
glTexCoord3dv ENDP
PUBLIC glTexCoord3f
glTexCoord3f PROC
    inc DWORD PTR [g_counts+1104]
    jmp QWORD PTR [g_real+2208]
glTexCoord3f ENDP
PUBLIC glTexCoord3fv
glTexCoord3fv PROC
    inc DWORD PTR [g_counts+1108]
    jmp QWORD PTR [g_real+2216]
glTexCoord3fv ENDP
PUBLIC glTexCoord3i
glTexCoord3i PROC
    inc DWORD PTR [g_counts+1112]
    jmp QWORD PTR [g_real+2224]
glTexCoord3i ENDP
PUBLIC glTexCoord3iv
glTexCoord3iv PROC
    inc DWORD PTR [g_counts+1116]
    jmp QWORD PTR [g_real+2232]
glTexCoord3iv ENDP
PUBLIC glTexCoord3s
glTexCoord3s PROC
    inc DWORD PTR [g_counts+1120]
    jmp QWORD PTR [g_real+2240]
glTexCoord3s ENDP
PUBLIC glTexCoord3sv
glTexCoord3sv PROC
    inc DWORD PTR [g_counts+1124]
    jmp QWORD PTR [g_real+2248]
glTexCoord3sv ENDP
PUBLIC glTexCoord4d
glTexCoord4d PROC
    inc DWORD PTR [g_counts+1128]
    jmp QWORD PTR [g_real+2256]
glTexCoord4d ENDP
PUBLIC glTexCoord4dv
glTexCoord4dv PROC
    inc DWORD PTR [g_counts+1132]
    jmp QWORD PTR [g_real+2264]
glTexCoord4dv ENDP
PUBLIC glTexCoord4f
glTexCoord4f PROC
    inc DWORD PTR [g_counts+1136]
    jmp QWORD PTR [g_real+2272]
glTexCoord4f ENDP
PUBLIC glTexCoord4fv
glTexCoord4fv PROC
    inc DWORD PTR [g_counts+1140]
    jmp QWORD PTR [g_real+2280]
glTexCoord4fv ENDP
PUBLIC glTexCoord4i
glTexCoord4i PROC
    inc DWORD PTR [g_counts+1144]
    jmp QWORD PTR [g_real+2288]
glTexCoord4i ENDP
PUBLIC glTexCoord4iv
glTexCoord4iv PROC
    inc DWORD PTR [g_counts+1148]
    jmp QWORD PTR [g_real+2296]
glTexCoord4iv ENDP
PUBLIC glTexCoord4s
glTexCoord4s PROC
    inc DWORD PTR [g_counts+1152]
    jmp QWORD PTR [g_real+2304]
glTexCoord4s ENDP
PUBLIC glTexCoord4sv
glTexCoord4sv PROC
    inc DWORD PTR [g_counts+1156]
    jmp QWORD PTR [g_real+2312]
glTexCoord4sv ENDP
PUBLIC glTexCoordPointer
glTexCoordPointer PROC
    inc DWORD PTR [g_counts+1160]
    jmp QWORD PTR [g_real+2320]
glTexCoordPointer ENDP
PUBLIC glTexEnvf
glTexEnvf PROC
    inc DWORD PTR [g_counts+1164]
    jmp QWORD PTR [g_real+2328]
glTexEnvf ENDP
PUBLIC glTexEnvfv
glTexEnvfv PROC
    inc DWORD PTR [g_counts+1168]
    jmp QWORD PTR [g_real+2336]
glTexEnvfv ENDP
PUBLIC glTexEnvi
glTexEnvi PROC
    inc DWORD PTR [g_counts+1172]
    jmp QWORD PTR [g_real+2344]
glTexEnvi ENDP
PUBLIC glTexEnviv
glTexEnviv PROC
    inc DWORD PTR [g_counts+1176]
    jmp QWORD PTR [g_real+2352]
glTexEnviv ENDP
PUBLIC glTexGend
glTexGend PROC
    inc DWORD PTR [g_counts+1180]
    jmp QWORD PTR [g_real+2360]
glTexGend ENDP
PUBLIC glTexGendv
glTexGendv PROC
    inc DWORD PTR [g_counts+1184]
    jmp QWORD PTR [g_real+2368]
glTexGendv ENDP
PUBLIC glTexGenf
glTexGenf PROC
    inc DWORD PTR [g_counts+1188]
    jmp QWORD PTR [g_real+2376]
glTexGenf ENDP
PUBLIC glTexGenfv
glTexGenfv PROC
    inc DWORD PTR [g_counts+1192]
    jmp QWORD PTR [g_real+2384]
glTexGenfv ENDP
PUBLIC glTexGeni
glTexGeni PROC
    inc DWORD PTR [g_counts+1196]
    jmp QWORD PTR [g_real+2392]
glTexGeni ENDP
PUBLIC glTexGeniv
glTexGeniv PROC
    inc DWORD PTR [g_counts+1200]
    jmp QWORD PTR [g_real+2400]
glTexGeniv ENDP
PUBLIC glTexImage1D
glTexImage1D PROC
    inc DWORD PTR [g_counts+1204]
    jmp QWORD PTR [g_real+2408]
glTexImage1D ENDP
PUBLIC glTexImage2D
glTexImage2D PROC
    inc DWORD PTR [g_counts+1208]
    jmp QWORD PTR [g_real+2416]
glTexImage2D ENDP
PUBLIC glTexParameterf
glTexParameterf PROC
    inc DWORD PTR [g_counts+1212]
    jmp QWORD PTR [g_real+2424]
glTexParameterf ENDP
PUBLIC glTexParameterfv
glTexParameterfv PROC
    inc DWORD PTR [g_counts+1216]
    jmp QWORD PTR [g_real+2432]
glTexParameterfv ENDP
PUBLIC glTexParameteri
glTexParameteri PROC
    inc DWORD PTR [g_counts+1220]
    jmp QWORD PTR [g_real+2440]
glTexParameteri ENDP
PUBLIC glTexParameteriv
glTexParameteriv PROC
    inc DWORD PTR [g_counts+1224]
    jmp QWORD PTR [g_real+2448]
glTexParameteriv ENDP
PUBLIC glTexSubImage1D
glTexSubImage1D PROC
    inc DWORD PTR [g_counts+1228]
    jmp QWORD PTR [g_real+2456]
glTexSubImage1D ENDP
PUBLIC glTexSubImage2D
glTexSubImage2D PROC
    inc DWORD PTR [g_counts+1232]
    jmp QWORD PTR [g_real+2464]
glTexSubImage2D ENDP
PUBLIC glTranslated
glTranslated PROC
    inc DWORD PTR [g_counts+1236]
    jmp QWORD PTR [g_real+2472]
glTranslated ENDP
PUBLIC glTranslatef
glTranslatef PROC
    inc DWORD PTR [g_counts+1240]
    jmp QWORD PTR [g_real+2480]
glTranslatef ENDP
PUBLIC glVertex2d
glVertex2d PROC
    inc DWORD PTR [g_counts+1244]
    jmp QWORD PTR [g_real+2488]
glVertex2d ENDP
PUBLIC glVertex2dv
glVertex2dv PROC
    inc DWORD PTR [g_counts+1248]
    jmp QWORD PTR [g_real+2496]
glVertex2dv ENDP
PUBLIC glVertex2f
glVertex2f PROC
    inc DWORD PTR [g_counts+1252]
    jmp QWORD PTR [g_real+2504]
glVertex2f ENDP
PUBLIC glVertex2fv
glVertex2fv PROC
    inc DWORD PTR [g_counts+1256]
    jmp QWORD PTR [g_real+2512]
glVertex2fv ENDP
PUBLIC glVertex2i
glVertex2i PROC
    inc DWORD PTR [g_counts+1260]
    jmp QWORD PTR [g_real+2520]
glVertex2i ENDP
PUBLIC glVertex2iv
glVertex2iv PROC
    inc DWORD PTR [g_counts+1264]
    jmp QWORD PTR [g_real+2528]
glVertex2iv ENDP
PUBLIC glVertex2s
glVertex2s PROC
    inc DWORD PTR [g_counts+1268]
    jmp QWORD PTR [g_real+2536]
glVertex2s ENDP
PUBLIC glVertex2sv
glVertex2sv PROC
    inc DWORD PTR [g_counts+1272]
    jmp QWORD PTR [g_real+2544]
glVertex2sv ENDP
PUBLIC glVertex3d
glVertex3d PROC
    inc DWORD PTR [g_counts+1276]
    jmp QWORD PTR [g_real+2552]
glVertex3d ENDP
PUBLIC glVertex3dv
glVertex3dv PROC
    inc DWORD PTR [g_counts+1280]
    jmp QWORD PTR [g_real+2560]
glVertex3dv ENDP
PUBLIC glVertex3f
glVertex3f PROC
    inc DWORD PTR [g_counts+1284]
    jmp QWORD PTR [g_real+2568]
glVertex3f ENDP
PUBLIC glVertex3fv
glVertex3fv PROC
    inc DWORD PTR [g_counts+1288]
    jmp QWORD PTR [g_real+2576]
glVertex3fv ENDP
PUBLIC glVertex3i
glVertex3i PROC
    inc DWORD PTR [g_counts+1292]
    jmp QWORD PTR [g_real+2584]
glVertex3i ENDP
PUBLIC glVertex3iv
glVertex3iv PROC
    inc DWORD PTR [g_counts+1296]
    jmp QWORD PTR [g_real+2592]
glVertex3iv ENDP
PUBLIC glVertex3s
glVertex3s PROC
    inc DWORD PTR [g_counts+1300]
    jmp QWORD PTR [g_real+2600]
glVertex3s ENDP
PUBLIC glVertex3sv
glVertex3sv PROC
    inc DWORD PTR [g_counts+1304]
    jmp QWORD PTR [g_real+2608]
glVertex3sv ENDP
PUBLIC glVertex4d
glVertex4d PROC
    inc DWORD PTR [g_counts+1308]
    jmp QWORD PTR [g_real+2616]
glVertex4d ENDP
PUBLIC glVertex4dv
glVertex4dv PROC
    inc DWORD PTR [g_counts+1312]
    jmp QWORD PTR [g_real+2624]
glVertex4dv ENDP
PUBLIC glVertex4f
glVertex4f PROC
    inc DWORD PTR [g_counts+1316]
    jmp QWORD PTR [g_real+2632]
glVertex4f ENDP
PUBLIC glVertex4fv
glVertex4fv PROC
    inc DWORD PTR [g_counts+1320]
    jmp QWORD PTR [g_real+2640]
glVertex4fv ENDP
PUBLIC glVertex4i
glVertex4i PROC
    inc DWORD PTR [g_counts+1324]
    jmp QWORD PTR [g_real+2648]
glVertex4i ENDP
PUBLIC glVertex4iv
glVertex4iv PROC
    inc DWORD PTR [g_counts+1328]
    jmp QWORD PTR [g_real+2656]
glVertex4iv ENDP
PUBLIC glVertex4s
glVertex4s PROC
    inc DWORD PTR [g_counts+1332]
    jmp QWORD PTR [g_real+2664]
glVertex4s ENDP
PUBLIC glVertex4sv
glVertex4sv PROC
    inc DWORD PTR [g_counts+1336]
    jmp QWORD PTR [g_real+2672]
glVertex4sv ENDP
PUBLIC glVertexPointer
glVertexPointer PROC
    inc DWORD PTR [g_counts+1340]
    jmp QWORD PTR [g_real+2680]
glVertexPointer ENDP
PUBLIC glViewport
glViewport PROC
    inc DWORD PTR [g_counts+1344]
    jmp QWORD PTR [g_real+2688]
glViewport ENDP
PUBLIC wglChoosePixelFormat
wglChoosePixelFormat PROC
    inc DWORD PTR [g_counts+1348]
    jmp QWORD PTR [g_real+2696]
wglChoosePixelFormat ENDP
PUBLIC wglCopyContext
wglCopyContext PROC
    inc DWORD PTR [g_counts+1352]
    jmp QWORD PTR [g_real+2704]
wglCopyContext ENDP
PUBLIC wglCreateLayerContext
wglCreateLayerContext PROC
    inc DWORD PTR [g_counts+1360]
    jmp QWORD PTR [g_real+2720]
wglCreateLayerContext ENDP
PUBLIC wglDescribeLayerPlane
wglDescribeLayerPlane PROC
    inc DWORD PTR [g_counts+1368]
    jmp QWORD PTR [g_real+2736]
wglDescribeLayerPlane ENDP
PUBLIC wglDescribePixelFormat
wglDescribePixelFormat PROC
    inc DWORD PTR [g_counts+1372]
    jmp QWORD PTR [g_real+2744]
wglDescribePixelFormat ENDP
PUBLIC wglGetCurrentContext
wglGetCurrentContext PROC
    inc DWORD PTR [g_counts+1376]
    jmp QWORD PTR [g_real+2752]
wglGetCurrentContext ENDP
PUBLIC wglGetCurrentDC
wglGetCurrentDC PROC
    inc DWORD PTR [g_counts+1380]
    jmp QWORD PTR [g_real+2760]
wglGetCurrentDC ENDP
PUBLIC wglGetDefaultProcAddress
wglGetDefaultProcAddress PROC
    inc DWORD PTR [g_counts+1384]
    jmp QWORD PTR [g_real+2768]
wglGetDefaultProcAddress ENDP
PUBLIC wglGetLayerPaletteEntries
wglGetLayerPaletteEntries PROC
    inc DWORD PTR [g_counts+1388]
    jmp QWORD PTR [g_real+2776]
wglGetLayerPaletteEntries ENDP
PUBLIC wglGetPixelFormat
wglGetPixelFormat PROC
    inc DWORD PTR [g_counts+1392]
    jmp QWORD PTR [g_real+2784]
wglGetPixelFormat ENDP
PUBLIC wglRealizeLayerPalette
wglRealizeLayerPalette PROC
    inc DWORD PTR [g_counts+1404]
    jmp QWORD PTR [g_real+2808]
wglRealizeLayerPalette ENDP
PUBLIC wglSetLayerPaletteEntries
wglSetLayerPaletteEntries PROC
    inc DWORD PTR [g_counts+1408]
    jmp QWORD PTR [g_real+2816]
wglSetLayerPaletteEntries ENDP
PUBLIC wglSetPixelFormat
wglSetPixelFormat PROC
    inc DWORD PTR [g_counts+1412]
    jmp QWORD PTR [g_real+2824]
wglSetPixelFormat ENDP
PUBLIC wglShareLists
wglShareLists PROC
    inc DWORD PTR [g_counts+1416]
    jmp QWORD PTR [g_real+2832]
wglShareLists ENDP
PUBLIC wglSwapBuffers
wglSwapBuffers PROC
    inc DWORD PTR [g_counts+1420]
    jmp QWORD PTR [g_real+2840]
wglSwapBuffers ENDP
PUBLIC wglSwapLayerBuffers
wglSwapLayerBuffers PROC
    inc DWORD PTR [g_counts+1424]
    jmp QWORD PTR [g_real+2848]
wglSwapLayerBuffers ENDP
PUBLIC wglSwapMultipleBuffers
wglSwapMultipleBuffers PROC
    inc DWORD PTR [g_counts+1428]
    jmp QWORD PTR [g_real+2856]
wglSwapMultipleBuffers ENDP
PUBLIC wglUseFontBitmapsA
wglUseFontBitmapsA PROC
    inc DWORD PTR [g_counts+1432]
    jmp QWORD PTR [g_real+2864]
wglUseFontBitmapsA ENDP
PUBLIC wglUseFontBitmapsW
wglUseFontBitmapsW PROC
    inc DWORD PTR [g_counts+1436]
    jmp QWORD PTR [g_real+2872]
wglUseFontBitmapsW ENDP
PUBLIC wglUseFontOutlinesA
wglUseFontOutlinesA PROC
    inc DWORD PTR [g_counts+1440]
    jmp QWORD PTR [g_real+2880]
wglUseFontOutlinesA ENDP
PUBLIC wglUseFontOutlinesW
wglUseFontOutlinesW PROC
    inc DWORD PTR [g_counts+1444]
    jmp QWORD PTR [g_real+2888]
wglUseFontOutlinesW ENDP
END
