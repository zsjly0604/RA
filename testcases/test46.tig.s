MOVE(
 TEMP t132,
 CONST 0)
CJUMP(EQ,
 TEMP t132,
 CONST 0,
 L1,L2)
CJUMP(NE,
 TEMP t132,
 CONST 0,
 L3,L4)
CJUMP(EQ,
 CONST 0,
 TEMP t132,
 L5,L6)
MOVE(
 TEMP t133,
 CONST 1)
CJUMP(NE,
 CONST 0,
 TEMP t132,
 L7,L8)
LABEL L8
MOVE(
 TEMP t133,
 CONST 0)
LABEL L7
MOVE(
 TEMP t104,
 TEMP t133)
L10:
li t132, 0
beqz t132, L1
b L14
L14:
b L2
L11:
bnez t132, L3
b L15
L15:
b L4
L12:
li t134, 0
beq t134, t132, L5
b L16
L16:
b L6
L13:
li t133, 1
li t135, 0
bne t135, t132, L7
b L8
L8:
li t133, 0
L7:
move t104, t133
b L9
L9: