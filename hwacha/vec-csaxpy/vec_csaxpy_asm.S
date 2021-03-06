## Hwacha v4 CSAXPY ASM code

#include "vec-util.h"

.text
.align 2

.globl vec_csaxpy_asm
.type  vec_csaxpy_asm,@function

# assumes calling convention:
# a0 has int n
# fa1 has float a  <---
# a2 has float* x
# a3 has float* y
vec_csaxpy_asm:
    li t0, VCFG(3, 0, 0, 1)
    vsetcfg t0
    fmv.x.s a1, fa1
    vmcs vs1, a1
stripmine:
    vsetvl t0, a0 #a0 is requested vec len, actual is placed in t0
    vmca va0, a2
    vmca va1, a3
    vmca va2, a4
    la t5, csaxpy_v
    vf 0(t5)
    slli t1, t0, 2
    add a2, a2, t1
    add a3, a3, t1
    add a4, a4, t0
    sub a0, a0, t0
    bnez a0, stripmine
    fence
    ret

# vector thread asm
.align 3
csaxpy_v:
    vpset vp0
    vlb vv2, va2
    vcmpeq vp0, vv2, vs0
@!vp0    vlw vv0, va0
@!vp0    vlw vv1, va1
    # appears to be faster if we write into vv1 instead of using a new reg?
@!vp0    vfmadd.s vv1, vs1, vv0, vv1
@!vp0    vsw vv1, va1
    vstop
