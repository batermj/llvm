; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=x86-64 -mattr=+bmi2 | FileCheck %s --check-prefix=CHECK --check-prefix=GENERIC
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=haswell | FileCheck %s --check-prefix=CHECK --check-prefix=HASWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=broadwell | FileCheck %s --check-prefix=CHECK --check-prefix=BROADWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skylake | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=knl     | FileCheck %s --check-prefix=CHECK --check-prefix=KNL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=znver1  | FileCheck %s --check-prefix=CHECK --check-prefix=ZNVER1

define i32 @test_bzhi_i32(i32 %a0, i32 %a1, i32 *%a2) {
; GENERIC-LABEL: test_bzhi_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    bzhil %edi, (%rdx), %ecx # sched: [6:1.00]
; GENERIC-NEXT:    bzhil %edi, %esi, %eax # sched: [1:1.00]
; GENERIC-NEXT:    addl %ecx, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_bzhi_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    bzhil %edi, (%rdx), %ecx # sched: [6:0.50]
; HASWELL-NEXT:    bzhil %edi, %esi, %eax # sched: [1:0.50]
; HASWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_bzhi_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    bzhil %edi, (%rdx), %ecx # sched: [6:0.50]
; BROADWELL-NEXT:    bzhil %edi, %esi, %eax # sched: [1:0.50]
; BROADWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_bzhi_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    bzhil %edi, (%rdx), %ecx # sched: [6:0.50]
; SKYLAKE-NEXT:    bzhil %edi, %esi, %eax # sched: [1:0.50]
; SKYLAKE-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_bzhi_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    bzhil %edi, (%rdx), %ecx # sched: [6:0.50]
; KNL-NEXT:    bzhil %edi, %esi, %eax # sched: [1:0.50]
; KNL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_bzhi_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    bzhil %edi, (%rdx), %ecx # sched: [5:0.50]
; ZNVER1-NEXT:    bzhil %edi, %esi, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i32, i32 *%a2
  %2 = tail call i32 @llvm.x86.bmi.bzhi.32(i32 %1, i32 %a0)
  %3 = tail call i32 @llvm.x86.bmi.bzhi.32(i32 %a1, i32 %a0)
  %4 = add i32 %2, %3
  ret i32 %4
}
declare i32 @llvm.x86.bmi.bzhi.32(i32, i32)

define i64 @test_bzhi_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_bzhi_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    bzhiq %rdi, (%rdx), %rcx # sched: [6:1.00]
; GENERIC-NEXT:    bzhiq %rdi, %rsi, %rax # sched: [1:1.00]
; GENERIC-NEXT:    addq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_bzhi_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    bzhiq %rdi, (%rdx), %rcx # sched: [6:0.50]
; HASWELL-NEXT:    bzhiq %rdi, %rsi, %rax # sched: [1:0.50]
; HASWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_bzhi_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    bzhiq %rdi, (%rdx), %rcx # sched: [6:0.50]
; BROADWELL-NEXT:    bzhiq %rdi, %rsi, %rax # sched: [1:0.50]
; BROADWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_bzhi_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    bzhiq %rdi, (%rdx), %rcx # sched: [6:0.50]
; SKYLAKE-NEXT:    bzhiq %rdi, %rsi, %rax # sched: [1:0.50]
; SKYLAKE-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_bzhi_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    bzhiq %rdi, (%rdx), %rcx # sched: [6:0.50]
; KNL-NEXT:    bzhiq %rdi, %rsi, %rax # sched: [1:0.50]
; KNL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_bzhi_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    bzhiq %rdi, (%rdx), %rcx # sched: [5:0.50]
; ZNVER1-NEXT:    bzhiq %rdi, %rsi, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i64, i64 *%a2
  %2 = tail call i64 @llvm.x86.bmi.bzhi.64(i64 %1, i64 %a0)
  %3 = tail call i64 @llvm.x86.bmi.bzhi.64(i64 %a1, i64 %a0)
  %4 = add i64 %2, %3
  ret i64 %4
}
declare i64 @llvm.x86.bmi.bzhi.64(i64, i64)

define void @test_mulx_i32(i32 %a0, i32 %a1, i32* %a2) optsize {
; GENERIC-LABEL: test_mulx_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    #APP
; GENERIC-NEXT:    mulxl %esi, %esi, %edi # sched: [3:1.00]
; GENERIC-NEXT:    mulxl (%rdx), %esi, %edi # sched: [8:1.00]
; GENERIC-NEXT:    #NO_APP
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_mulx_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    #APP
; HASWELL-NEXT:    mulxl %esi, %esi, %edi # sched: [4:1.00]
; HASWELL-NEXT:    mulxl (%rdx), %esi, %edi # sched: [9:1.00]
; HASWELL-NEXT:    #NO_APP
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_mulx_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    #APP
; BROADWELL-NEXT:    mulxl %esi, %esi, %edi # sched: [4:1.00]
; BROADWELL-NEXT:    mulxl (%rdx), %esi, %edi # sched: [9:1.00]
; BROADWELL-NEXT:    #NO_APP
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_mulx_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    #APP
; SKYLAKE-NEXT:    mulxl %esi, %esi, %edi # sched: [4:1.00]
; SKYLAKE-NEXT:    mulxl (%rdx), %esi, %edi # sched: [9:1.00]
; SKYLAKE-NEXT:    #NO_APP
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_mulx_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    #APP
; KNL-NEXT:    mulxl %esi, %esi, %edi # sched: [4:1.00]
; KNL-NEXT:    mulxl (%rdx), %esi, %edi # sched: [9:1.00]
; KNL-NEXT:    #NO_APP
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_mulx_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    #APP
; ZNVER1-NEXT:    mulxl %esi, %esi, %edi # sched: [3:2.00]
; ZNVER1-NEXT:    mulxl (%rdx), %esi, %edi # sched: [8:2.00]
; ZNVER1-NEXT:    #NO_APP
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  tail call void asm "mulx $1, $1, $0 \0A\09 mulx $2, $1, $0 ", "r,r,*m"(i32 %a0, i32 %a1, i32* %a2) nounwind
  ret void
}

define i64 @test_mulx_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_mulx_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    movq %rdx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    movq %rdi, %rdx # sched: [1:0.33]
; GENERIC-NEXT:    mulxq %rsi, %rsi, %rcx # sched: [3:1.00]
; GENERIC-NEXT:    mulxq (%rax), %rdx, %rax # sched: [8:1.00]
; GENERIC-NEXT:    orq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_mulx_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    movq %rdx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    movq %rdi, %rdx # sched: [1:0.25]
; HASWELL-NEXT:    mulxq %rsi, %rsi, %rcx # sched: [4:1.00]
; HASWELL-NEXT:    mulxq (%rax), %rdx, %rax # sched: [9:1.00]
; HASWELL-NEXT:    orq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_mulx_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    movq %rdx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    movq %rdi, %rdx # sched: [1:0.25]
; BROADWELL-NEXT:    mulxq %rsi, %rsi, %rcx # sched: [4:1.00]
; BROADWELL-NEXT:    mulxq (%rax), %rdx, %rax # sched: [9:1.00]
; BROADWELL-NEXT:    orq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_mulx_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    movq %rdx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    movq %rdi, %rdx # sched: [1:0.25]
; SKYLAKE-NEXT:    mulxq %rsi, %rsi, %rcx # sched: [4:1.00]
; SKYLAKE-NEXT:    mulxq (%rax), %rdx, %rax # sched: [9:1.00]
; SKYLAKE-NEXT:    orq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_mulx_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    movq %rdx, %rax # sched: [1:0.25]
; KNL-NEXT:    movq %rdi, %rdx # sched: [1:0.25]
; KNL-NEXT:    mulxq %rsi, %rsi, %rcx # sched: [4:1.00]
; KNL-NEXT:    mulxq (%rax), %rdx, %rax # sched: [9:1.00]
; KNL-NEXT:    orq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_mulx_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    movq %rdx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    movq %rdi, %rdx # sched: [1:0.25]
; ZNVER1-NEXT:    mulxq %rsi, %rsi, %rcx # sched: [3:1.00]
; ZNVER1-NEXT:    mulxq (%rax), %rdx, %rax # sched: [8:1.00]
; ZNVER1-NEXT:    orq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1  = load i64, i64 *%a2
  %2  = zext i64 %a0 to i128
  %3  = zext i64 %a1 to i128
  %4  = zext i64 %1 to i128
  %5  = mul i128 %2, %3
  %6  = mul i128 %2, %4
  %7  = lshr i128 %5, 64
  %8  = lshr i128 %6, 64
  %9  = trunc i128 %7 to i64
  %10 = trunc i128 %8 to i64
  %11 = or i64 %9, %10
  ret i64 %11
}

define i32 @test_pdep_i32(i32 %a0, i32 %a1, i32 *%a2) {
; GENERIC-LABEL: test_pdep_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    pdepl (%rdx), %edi, %ecx # sched: [6:0.50]
; GENERIC-NEXT:    pdepl %esi, %edi, %eax # sched: [1:0.33]
; GENERIC-NEXT:    addl %ecx, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_pdep_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    pdepl (%rdx), %edi, %ecx # sched: [8:1.00]
; HASWELL-NEXT:    pdepl %esi, %edi, %eax # sched: [3:1.00]
; HASWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_pdep_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    pdepl (%rdx), %edi, %ecx # sched: [8:1.00]
; BROADWELL-NEXT:    pdepl %esi, %edi, %eax # sched: [3:1.00]
; BROADWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_pdep_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    pdepl (%rdx), %edi, %ecx # sched: [8:1.00]
; SKYLAKE-NEXT:    pdepl %esi, %edi, %eax # sched: [3:1.00]
; SKYLAKE-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_pdep_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    pdepl (%rdx), %edi, %ecx # sched: [8:1.00]
; KNL-NEXT:    pdepl %esi, %edi, %eax # sched: [3:1.00]
; KNL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_pdep_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    pdepl (%rdx), %edi, %ecx # sched: [100:?]
; ZNVER1-NEXT:    pdepl %esi, %edi, %eax # sched: [100:?]
; ZNVER1-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i32, i32 *%a2
  %2 = tail call i32 @llvm.x86.bmi.pdep.32(i32 %a0, i32 %1)
  %3 = tail call i32 @llvm.x86.bmi.pdep.32(i32 %a0, i32 %a1)
  %4 = add i32 %2, %3
  ret i32 %4
}
declare i32 @llvm.x86.bmi.pdep.32(i32, i32)

define i64 @test_pdep_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_pdep_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    pdepq (%rdx), %rdi, %rcx # sched: [6:0.50]
; GENERIC-NEXT:    pdepq %rsi, %rdi, %rax # sched: [1:0.33]
; GENERIC-NEXT:    addq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_pdep_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    pdepq (%rdx), %rdi, %rcx # sched: [8:1.00]
; HASWELL-NEXT:    pdepq %rsi, %rdi, %rax # sched: [3:1.00]
; HASWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_pdep_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    pdepq (%rdx), %rdi, %rcx # sched: [8:1.00]
; BROADWELL-NEXT:    pdepq %rsi, %rdi, %rax # sched: [3:1.00]
; BROADWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_pdep_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    pdepq (%rdx), %rdi, %rcx # sched: [8:1.00]
; SKYLAKE-NEXT:    pdepq %rsi, %rdi, %rax # sched: [3:1.00]
; SKYLAKE-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_pdep_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    pdepq (%rdx), %rdi, %rcx # sched: [8:1.00]
; KNL-NEXT:    pdepq %rsi, %rdi, %rax # sched: [3:1.00]
; KNL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_pdep_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    pdepq (%rdx), %rdi, %rcx # sched: [100:?]
; ZNVER1-NEXT:    pdepq %rsi, %rdi, %rax # sched: [100:?]
; ZNVER1-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i64, i64 *%a2
  %2 = tail call i64 @llvm.x86.bmi.pdep.64(i64 %a0, i64 %1)
  %3 = tail call i64 @llvm.x86.bmi.pdep.64(i64 %a0, i64 %a1)
  %4 = add i64 %2, %3
  ret i64 %4
}
declare i64 @llvm.x86.bmi.pdep.64(i64, i64)

define i32 @test_pext_i32(i32 %a0, i32 %a1, i32 *%a2) {
; GENERIC-LABEL: test_pext_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    pextl (%rdx), %edi, %ecx # sched: [6:0.50]
; GENERIC-NEXT:    pextl %esi, %edi, %eax # sched: [1:0.33]
; GENERIC-NEXT:    addl %ecx, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_pext_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    pextl (%rdx), %edi, %ecx # sched: [8:1.00]
; HASWELL-NEXT:    pextl %esi, %edi, %eax # sched: [3:1.00]
; HASWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_pext_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    pextl (%rdx), %edi, %ecx # sched: [8:1.00]
; BROADWELL-NEXT:    pextl %esi, %edi, %eax # sched: [3:1.00]
; BROADWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_pext_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    pextl (%rdx), %edi, %ecx # sched: [8:1.00]
; SKYLAKE-NEXT:    pextl %esi, %edi, %eax # sched: [3:1.00]
; SKYLAKE-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_pext_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    pextl (%rdx), %edi, %ecx # sched: [8:1.00]
; KNL-NEXT:    pextl %esi, %edi, %eax # sched: [3:1.00]
; KNL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_pext_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    pextl (%rdx), %edi, %ecx # sched: [100:?]
; ZNVER1-NEXT:    pextl %esi, %edi, %eax # sched: [100:?]
; ZNVER1-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i32, i32 *%a2
  %2 = tail call i32 @llvm.x86.bmi.pext.32(i32 %a0, i32 %1)
  %3 = tail call i32 @llvm.x86.bmi.pext.32(i32 %a0, i32 %a1)
  %4 = add i32 %2, %3
  ret i32 %4
}
declare i32 @llvm.x86.bmi.pext.32(i32, i32)

define i64 @test_pext_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_pext_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    pextq (%rdx), %rdi, %rcx # sched: [6:0.50]
; GENERIC-NEXT:    pextq %rsi, %rdi, %rax # sched: [1:0.33]
; GENERIC-NEXT:    addq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_pext_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    pextq (%rdx), %rdi, %rcx # sched: [8:1.00]
; HASWELL-NEXT:    pextq %rsi, %rdi, %rax # sched: [3:1.00]
; HASWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_pext_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    pextq (%rdx), %rdi, %rcx # sched: [8:1.00]
; BROADWELL-NEXT:    pextq %rsi, %rdi, %rax # sched: [3:1.00]
; BROADWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_pext_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    pextq (%rdx), %rdi, %rcx # sched: [8:1.00]
; SKYLAKE-NEXT:    pextq %rsi, %rdi, %rax # sched: [3:1.00]
; SKYLAKE-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_pext_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    pextq (%rdx), %rdi, %rcx # sched: [8:1.00]
; KNL-NEXT:    pextq %rsi, %rdi, %rax # sched: [3:1.00]
; KNL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_pext_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    pextq (%rdx), %rdi, %rcx # sched: [100:?]
; ZNVER1-NEXT:    pextq %rsi, %rdi, %rax # sched: [100:?]
; ZNVER1-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i64, i64 *%a2
  %2 = tail call i64 @llvm.x86.bmi.pext.64(i64 %a0, i64 %1)
  %3 = tail call i64 @llvm.x86.bmi.pext.64(i64 %a0, i64 %a1)
  %4 = add i64 %2, %3
  ret i64 %4
}
declare i64 @llvm.x86.bmi.pext.64(i64, i64)

define i32 @test_rorx_i32(i32 %a0, i32 %a1, i32 *%a2) {
; GENERIC-LABEL: test_rorx_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    rorxl $5, %edi, %ecx # sched: [1:0.50]
; GENERIC-NEXT:    rorxl $5, (%rdx), %eax # sched: [6:0.50]
; GENERIC-NEXT:    addl %ecx, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_rorx_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    rorxl $5, %edi, %ecx # sched: [1:0.50]
; HASWELL-NEXT:    rorxl $5, (%rdx), %eax # sched: [6:0.50]
; HASWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_rorx_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    rorxl $5, %edi, %ecx # sched: [1:0.50]
; BROADWELL-NEXT:    rorxl $5, (%rdx), %eax # sched: [6:0.50]
; BROADWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_rorx_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    rorxl $5, %edi, %ecx # sched: [1:0.50]
; SKYLAKE-NEXT:    rorxl $5, (%rdx), %eax # sched: [6:0.50]
; SKYLAKE-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_rorx_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    rorxl $5, %edi, %ecx # sched: [1:0.50]
; KNL-NEXT:    rorxl $5, (%rdx), %eax # sched: [6:0.50]
; KNL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_rorx_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    rorxl $5, (%rdx), %eax # sched: [5:0.50]
; ZNVER1-NEXT:    rorxl $5, %edi, %ecx # sched: [1:0.25]
; ZNVER1-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i32, i32 *%a2
  %2 = lshr i32 %a0, 5
  %3 = shl i32 %a0, 27
  %4 = or i32 %2, %3
  %5 = lshr i32 %1, 5
  %6 = shl i32 %1, 27
  %7 = or i32 %5, %6
  %8 = add i32 %4, %7
  ret i32 %8
}

define i64 @test_rorx_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_rorx_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    rorxq $5, %rdi, %rcx # sched: [1:0.50]
; GENERIC-NEXT:    rorxq $5, (%rdx), %rax # sched: [6:0.50]
; GENERIC-NEXT:    addq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_rorx_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    rorxq $5, %rdi, %rcx # sched: [1:0.50]
; HASWELL-NEXT:    rorxq $5, (%rdx), %rax # sched: [6:0.50]
; HASWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_rorx_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    rorxq $5, %rdi, %rcx # sched: [1:0.50]
; BROADWELL-NEXT:    rorxq $5, (%rdx), %rax # sched: [6:0.50]
; BROADWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_rorx_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    rorxq $5, %rdi, %rcx # sched: [1:0.50]
; SKYLAKE-NEXT:    rorxq $5, (%rdx), %rax # sched: [6:0.50]
; SKYLAKE-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_rorx_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    rorxq $5, %rdi, %rcx # sched: [1:0.50]
; KNL-NEXT:    rorxq $5, (%rdx), %rax # sched: [6:0.50]
; KNL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_rorx_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    rorxq $5, (%rdx), %rax # sched: [5:0.50]
; ZNVER1-NEXT:    rorxq $5, %rdi, %rcx # sched: [1:0.25]
; ZNVER1-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i64, i64 *%a2
  %2 = lshr i64 %a0, 5
  %3 = shl i64 %a0, 59
  %4 = or i64 %2, %3
  %5 = lshr i64 %1, 5
  %6 = shl i64 %1, 59
  %7 = or i64 %5, %6
  %8 = add i64 %4, %7
  ret i64 %8
}

define i32 @test_sarx_i32(i32 %a0, i32 %a1, i32 *%a2) {
; GENERIC-LABEL: test_sarx_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    sarxl %esi, %edi, %ecx # sched: [1:0.50]
; GENERIC-NEXT:    sarxl %esi, (%rdx), %eax # sched: [6:0.50]
; GENERIC-NEXT:    addl %ecx, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_sarx_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    sarxl %esi, %edi, %ecx # sched: [1:0.50]
; HASWELL-NEXT:    sarxl %esi, (%rdx), %eax # sched: [6:0.50]
; HASWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_sarx_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    sarxl %esi, %edi, %ecx # sched: [1:0.50]
; BROADWELL-NEXT:    sarxl %esi, (%rdx), %eax # sched: [6:0.50]
; BROADWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_sarx_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    sarxl %esi, %edi, %ecx # sched: [1:0.50]
; SKYLAKE-NEXT:    sarxl %esi, (%rdx), %eax # sched: [6:0.50]
; SKYLAKE-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_sarx_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    sarxl %esi, %edi, %ecx # sched: [1:0.50]
; KNL-NEXT:    sarxl %esi, (%rdx), %eax # sched: [6:0.50]
; KNL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_sarx_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    sarxl %esi, (%rdx), %eax # sched: [5:0.50]
; ZNVER1-NEXT:    sarxl %esi, %edi, %ecx # sched: [1:0.25]
; ZNVER1-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i32, i32 *%a2
  %2 = ashr i32 %a0, %a1
  %3 = ashr i32 %1, %a1
  %4 = add i32 %2, %3
  ret i32 %4
}

define i64 @test_sarx_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_sarx_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    sarxq %rsi, %rdi, %rcx # sched: [1:0.50]
; GENERIC-NEXT:    sarxq %rsi, (%rdx), %rax # sched: [6:0.50]
; GENERIC-NEXT:    addq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_sarx_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    sarxq %rsi, %rdi, %rcx # sched: [1:0.50]
; HASWELL-NEXT:    sarxq %rsi, (%rdx), %rax # sched: [6:0.50]
; HASWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_sarx_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    sarxq %rsi, %rdi, %rcx # sched: [1:0.50]
; BROADWELL-NEXT:    sarxq %rsi, (%rdx), %rax # sched: [6:0.50]
; BROADWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_sarx_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    sarxq %rsi, %rdi, %rcx # sched: [1:0.50]
; SKYLAKE-NEXT:    sarxq %rsi, (%rdx), %rax # sched: [6:0.50]
; SKYLAKE-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_sarx_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    sarxq %rsi, %rdi, %rcx # sched: [1:0.50]
; KNL-NEXT:    sarxq %rsi, (%rdx), %rax # sched: [6:0.50]
; KNL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_sarx_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    sarxq %rsi, (%rdx), %rax # sched: [5:0.50]
; ZNVER1-NEXT:    sarxq %rsi, %rdi, %rcx # sched: [1:0.25]
; ZNVER1-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i64, i64 *%a2
  %2 = ashr i64 %a0, %a1
  %3 = ashr i64 %1, %a1
  %4 = add i64 %2, %3
  ret i64 %4
}

define i32 @test_shlx_i32(i32 %a0, i32 %a1, i32 *%a2) {
; GENERIC-LABEL: test_shlx_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    shlxl %esi, %edi, %ecx # sched: [1:0.50]
; GENERIC-NEXT:    shlxl %esi, (%rdx), %eax # sched: [6:0.50]
; GENERIC-NEXT:    addl %ecx, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_shlx_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    shlxl %esi, %edi, %ecx # sched: [1:0.50]
; HASWELL-NEXT:    shlxl %esi, (%rdx), %eax # sched: [6:0.50]
; HASWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_shlx_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    shlxl %esi, %edi, %ecx # sched: [1:0.50]
; BROADWELL-NEXT:    shlxl %esi, (%rdx), %eax # sched: [6:0.50]
; BROADWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_shlx_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    shlxl %esi, %edi, %ecx # sched: [1:0.50]
; SKYLAKE-NEXT:    shlxl %esi, (%rdx), %eax # sched: [6:0.50]
; SKYLAKE-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_shlx_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    shlxl %esi, %edi, %ecx # sched: [1:0.50]
; KNL-NEXT:    shlxl %esi, (%rdx), %eax # sched: [6:0.50]
; KNL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_shlx_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    shlxl %esi, (%rdx), %eax # sched: [5:0.50]
; ZNVER1-NEXT:    shlxl %esi, %edi, %ecx # sched: [1:0.25]
; ZNVER1-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i32, i32 *%a2
  %2 = shl i32 %a0, %a1
  %3 = shl i32 %1, %a1
  %4 = add i32 %2, %3
  ret i32 %4
}

define i64 @test_shlx_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_shlx_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    shlxq %rsi, %rdi, %rcx # sched: [1:0.50]
; GENERIC-NEXT:    shlxq %rsi, (%rdx), %rax # sched: [6:0.50]
; GENERIC-NEXT:    addq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_shlx_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    shlxq %rsi, %rdi, %rcx # sched: [1:0.50]
; HASWELL-NEXT:    shlxq %rsi, (%rdx), %rax # sched: [6:0.50]
; HASWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_shlx_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    shlxq %rsi, %rdi, %rcx # sched: [1:0.50]
; BROADWELL-NEXT:    shlxq %rsi, (%rdx), %rax # sched: [6:0.50]
; BROADWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_shlx_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    shlxq %rsi, %rdi, %rcx # sched: [1:0.50]
; SKYLAKE-NEXT:    shlxq %rsi, (%rdx), %rax # sched: [6:0.50]
; SKYLAKE-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_shlx_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    shlxq %rsi, %rdi, %rcx # sched: [1:0.50]
; KNL-NEXT:    shlxq %rsi, (%rdx), %rax # sched: [6:0.50]
; KNL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_shlx_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    shlxq %rsi, (%rdx), %rax # sched: [5:0.50]
; ZNVER1-NEXT:    shlxq %rsi, %rdi, %rcx # sched: [1:0.25]
; ZNVER1-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i64, i64 *%a2
  %2 = shl i64 %a0, %a1
  %3 = shl i64 %1, %a1
  %4 = add i64 %2, %3
  ret i64 %4
}

define i32 @test_shrx_i32(i32 %a0, i32 %a1, i32 *%a2) {
; GENERIC-LABEL: test_shrx_i32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    shrxl %esi, %edi, %ecx # sched: [1:0.50]
; GENERIC-NEXT:    shrxl %esi, (%rdx), %eax # sched: [6:0.50]
; GENERIC-NEXT:    addl %ecx, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_shrx_i32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    shrxl %esi, %edi, %ecx # sched: [1:0.50]
; HASWELL-NEXT:    shrxl %esi, (%rdx), %eax # sched: [6:0.50]
; HASWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_shrx_i32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    shrxl %esi, %edi, %ecx # sched: [1:0.50]
; BROADWELL-NEXT:    shrxl %esi, (%rdx), %eax # sched: [6:0.50]
; BROADWELL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_shrx_i32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    shrxl %esi, %edi, %ecx # sched: [1:0.50]
; SKYLAKE-NEXT:    shrxl %esi, (%rdx), %eax # sched: [6:0.50]
; SKYLAKE-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_shrx_i32:
; KNL:       # %bb.0:
; KNL-NEXT:    shrxl %esi, %edi, %ecx # sched: [1:0.50]
; KNL-NEXT:    shrxl %esi, (%rdx), %eax # sched: [6:0.50]
; KNL-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_shrx_i32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    shrxl %esi, (%rdx), %eax # sched: [5:0.50]
; ZNVER1-NEXT:    shrxl %esi, %edi, %ecx # sched: [1:0.25]
; ZNVER1-NEXT:    addl %ecx, %eax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i32, i32 *%a2
  %2 = lshr i32 %a0, %a1
  %3 = lshr i32 %1, %a1
  %4 = add i32 %2, %3
  ret i32 %4
}

define i64 @test_shrx_i64(i64 %a0, i64 %a1, i64 *%a2) {
; GENERIC-LABEL: test_shrx_i64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    shrxq %rsi, %rdi, %rcx # sched: [1:0.50]
; GENERIC-NEXT:    shrxq %rsi, (%rdx), %rax # sched: [6:0.50]
; GENERIC-NEXT:    addq %rcx, %rax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_shrx_i64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    shrxq %rsi, %rdi, %rcx # sched: [1:0.50]
; HASWELL-NEXT:    shrxq %rsi, (%rdx), %rax # sched: [6:0.50]
; HASWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_shrx_i64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    shrxq %rsi, %rdi, %rcx # sched: [1:0.50]
; BROADWELL-NEXT:    shrxq %rsi, (%rdx), %rax # sched: [6:0.50]
; BROADWELL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_shrx_i64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    shrxq %rsi, %rdi, %rcx # sched: [1:0.50]
; SKYLAKE-NEXT:    shrxq %rsi, (%rdx), %rax # sched: [6:0.50]
; SKYLAKE-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; KNL-LABEL: test_shrx_i64:
; KNL:       # %bb.0:
; KNL-NEXT:    shrxq %rsi, %rdi, %rcx # sched: [1:0.50]
; KNL-NEXT:    shrxq %rsi, (%rdx), %rax # sched: [6:0.50]
; KNL-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; KNL-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_shrx_i64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    shrxq %rsi, (%rdx), %rax # sched: [5:0.50]
; ZNVER1-NEXT:    shrxq %rsi, %rdi, %rcx # sched: [1:0.25]
; ZNVER1-NEXT:    addq %rcx, %rax # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load i64, i64 *%a2
  %2 = lshr i64 %a0, %a1
  %3 = lshr i64 %1, %a1
  %4 = add i64 %2, %3
  ret i64 %4
}
