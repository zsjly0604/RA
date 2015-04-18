L6:
lw t145, 0(t101)
move t106, 0(t145)
li t146, 10
move t107, 0(t146)
jal L1
move t104, 0(t104)
b L5
L5:
L8:
li t133, 1
lw t149, -4(t101)
beqz t149, L2
b L3
L3:
lw t150, -4(t101)
move t148, 0(t150)
move t106, 0(t101)
lw t163, -4(t101)
addi t162, t163, -1
move t107, 0(t162)
jal L1
move t147, 0(t104)
mul t164, t148, t147
move t133, 0(t164)
L2:
move t104, 0(t133)
b L7
L7:
