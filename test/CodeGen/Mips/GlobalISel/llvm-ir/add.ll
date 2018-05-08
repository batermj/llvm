; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32
define i32 @add_i32(i32 %x, i32 %y) {
; MIPS32-LABEL: add_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addu $2, $4, $5
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %z = add i32 %x, %y
  ret i32 %z
}
