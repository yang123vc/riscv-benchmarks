## Hwacha v4 VVADD ASM code

.text

.globl dgemm_opt_v_4_4_vpset
.globl dgemm_opt_v_4_4
.globl dgemm_opt_v_4_4_pre
.globl dgemm_opt_v_4_4_post

.align 3
dgemm_opt_v_4_4_vpset:
    vpset vp0
    vstop

.align 3
dgemm_opt_v_4_4_pre:
    vld vv0, va0 # c0
    vld vv1, va1 # c1
    vld vv2, va2 # c2
    vld vv3, va3 # c3

    vstop

.align 3
dgemm_opt_v_4_4:
    vld vv4, va4                    # b0
    vfmadd.d vv0, vv4, vs1, vv0     # c0 += a00 * b0
    vfmadd.d vv1, vv4, vs5, vv1     # c1 += a10 * b0

    vld vv5, va5                    # b1
    vfmadd.d vv2, vv4, vs9, vv2     # c2 += a20 * b0
    vfmadd.d vv3, vv4, vs13, vv3    # c3 += a30 * b0

    vld vv6, va6                    # b2
    vfmadd.d vv0, vv5, vs2, vv0     # c0 += a01 * b1
    vfmadd.d vv1, vv5, vs6, vv1     # c1 += a11 * b1

    vld vv7, va7                    # b3
    vfmadd.d vv0, vv6, vs3, vv0     # c0 += a02 * b2
    vfmadd.d vv1, vv6, vs7, vv1     # c1 += a12 * b2
    vfmadd.d vv0, vv7, vs4, vv0     # c0 += a03 * b3
    vfmadd.d vv1, vv7, vs8, vv1     # c1 += a13 * b3
    vfmadd.d vv2, vv5, vs10, vv2    # c2 += a21 * b1
    vfmadd.d vv3, vv5, vs14, vv3    # c3 += a31 * b1
    vfmadd.d vv2, vv6, vs11, vv2    # c2 += a22 * b2
    vfmadd.d vv3, vv6, vs15, vv3    # c3 += a32 * b2
    vfmadd.d vv2, vv7, vs12, vv2    # c2 += a23 * b3
    vfmadd.d vv3, vv7, vs16, vv3    # c3 += a33 * b3

    vstop

.align 3
dgemm_opt_v_4_4_post:
    vsd vv0, va0 # c0
    vsd vv1, va1 # c1
    vsd vv2, va2 # c2
    vsd vv3, va3 # c3

    vstop
