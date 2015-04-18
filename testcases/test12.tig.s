L10:
li t138, 0
li t139, 0
li t140, 100
ble t139, t140, L8
b L7
L7:
li t104, 0
b L9
L8:
addi t141, t138, 1
move t138, t141
addi t142, t139, 1
move t139, t142
li t143, 100
blt t139, t143, L8
b L11
L11:
b L7
L9:
