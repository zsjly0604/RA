.data
L1:
	.word 1
	.asciiz "0"
.data
L2:
	.word 1
	.asciiz "9"
.data
L8:
	.word 1
	.asciiz " "
.data
L9:
	.word 2
	.asciiz "\n"
.data
L17:
	.word 1
	.asciiz "0"
.data
L32:
	.word 1
	.asciiz "0"
.data
L35:
	.word 1
	.asciiz "-"
.data
L36:
	.word 1
	.asciiz "0"
.data
L43:
	.word 2
	.asciiz "\n"
.data
L44:
	.word 1
	.asciiz " "

	.globl isdigit
	.ent isdigit
	.text
isdigit:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	move $s0, $a1
	sw $a0, 0($fp)
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s0, tig_ord
	lw $s4, 0($fp)
	lw $s4, 0($s4)
	lw $s4, -4($s4)
	move $a0, $s4
	jal $s0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	move $s2, $s0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s0, tig_ord
	la $s4, L1
	move $a0, $s4
	jal $s0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	bge $s2, $s0, L3
b L4
L4:
	move $s0, $0
L5:
	move $v0, $s0
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L3:
	li $s0, 1
	move $s1, $s0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s0, tig_ord
	lw $s4, 0($fp)
	lw $s4, 0($s4)
	lw $s4, -4($s4)
	move $a0, $s4
	jal $s0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	move $s3, $s0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s0, tig_ord
	la $s4, L2
	move $a0, $s4
	jal $s0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	ble $s3, $s0, L6
b L7
L7:
	move $s1, $0
L6:
	move $s0, $s1
	j L5
	.end isdigit
	j L57
L57:

	.globl skipto
	.ent skipto
	.text
skipto:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	sw $a0, 0($fp)
L15:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s0, tig_stringEqual
	lw $s2, 0($fp)
	lw $s2, 0($s2)
	lw $s2, -4($s2)
	move $a0, $s2
	la $s2, L8
	move $a1, $s2
	jal $s0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	bne $s0, $0, L10
b L11
L11:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s0, tig_stringEqual
	lw $s2, 0($fp)
	lw $s2, 0($s2)
	lw $s2, -4($s2)
	move $a0, $s2
	la $s2, L9
	move $a1, $s2
	jal $s0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
L12:
	bne $s0, $0, L14
b L13
L13:
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L10:
	li $s0, 1
	j L12
L14:
	lw $s0, 0($fp)
	lw $s0, 0($s0)
	addi $s0, $s0, -4
	move $s1, $s0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s0, tig_getchar
	jal $s0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	sw $s0, 0($s1)
	j L15
	.end skipto
	j L58
L58:

	.globl readint
	.ent readint
	.text
readint:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	move $s0, $a1
	sw $a0, 0($fp)
	move $s1, $0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s6, skipto
	move $a0, $fp
	jal $s6
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	addi $s2, $s0, 0
	move $s3, $s2
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s7, isdigit
	move $a0, $fp
	lw $s2, 0($fp)
	lw $s2, -4($s2)
	move $a1, $s2
	jal $s7
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	sw $s2, 0($s3)
L19:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $t0, isdigit
	move $a0, $fp
	lw $s2, 0($fp)
	lw $s2, -4($s2)
	move $a1, $s2
	jal $t0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	bne $s2, $0, L18
b L16
L16:
	move $v0, $s1
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L18:
	li $s2, 10
	mul $s2, $s1, $s2
	move $s4, $s2
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s2, tig_ord
	lw $t2, 0($fp)
	lw $t2, -4($t2)
	move $a0, $t2
	jal $s2
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	add $s2, $s4, $s2
	move $s5, $s2
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s2, tig_ord
	la $t2, L17
	move $a0, $t2
	jal $s2
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s1, $v0
	sub $s1, $s5, $s1
	lw $s2, 0($fp)
	addi $s2, $s2, -4
	move $t1, $s2
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s2, tig_getchar
	jal $s2
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	sw $s2, 0($t1)
	j L19
	.end readint
	j L59
L59:

	.globl readlist
	.ent readlist
	.text
readlist:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	sw $a0, 0($fp)
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, tig_allocRecord
	li $a0, 4
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	sw $0, 0($s0)
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, readint
	lw $s5 0($fp)
	move $a0, $s5
	move $a1, $s0
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s1, $v0
	lw $s4, 0($s0)
	bne $s4, $0, L20
b L21
L21:
	move $s0, $0
L22:
	move $v0, $s0
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L20:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, tig_allocRecord
	li $a0, 8
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	sw $s1, 0($s2)
	addi $s3, $s2, 4
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, readlist
	lw $s5 0($fp)
	move $a0, $s5
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	sw $s0, 0($s3)
	move $s0, $s2
	j L22
	.end readlist
	j L60
L60:

	.globl merge
	.ent merge
	.text
merge:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	move $s1, $a2
	move $s0, $a1
	sw $a0, 0($fp)
	beq $s0, $0, L29
b L30
L30:
	beq $s1, $0, L26
b L27
L27:
	lw $s6, 0($s0)
	lw $s7, 0($s1)
	blt $s6, $s7, L23
b L24
L24:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $t0, tig_allocRecord
	li $a0, 8
	jal $t0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s3, $v0
	lw $s4, 0($s1)
	sw $s4, 0($s3)
	addi $s4, $s3, 4
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s6, merge
	lw $s7 0($fp)
	move $a0, $s7
	move $a1, $s0
	lw $s7, 4($s1)
	move $a2, $s7
	jal $s6
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	sw $s0, 0($s4)
	move $s0, $s3
L25:
L28:
L31:
	move $v0, $s0
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L23:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $t1, tig_allocRecord
	li $a0, 8
	jal $t1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	lw $s5, 0($s0)
	sw $s5, 0($s2)
	addi $s5, $s2, 4
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s6, merge
	lw $s7 0($fp)
	move $a0, $s7
	lw $s7, 4($s0)
	move $a1, $s7
	move $a2, $s1
	jal $s6
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	sw $s0, 0($s5)
	move $s0, $s2
	j L25
L26:
	j L28
L29:
	move $s0, $s1
	j L31
	.end merge
	j L61
L61:

	.globl f
	.ent f
	.text
f:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	move $s0, $a1
	sw $a0, 0($fp)
	bgt $s0, $0, L33
b L34
L34:
	move $v0, $s1
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L33:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, f
	lw $s5 0($fp)
	move $a0, $s5
	li $s5, 10
	div $s5, $s0, $s5
	move $a1, $s5
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	li $s3, 10
	div $s3, $s0, $s3
	li $s4, 10
	mul $s3, $s3, $s4
	sub $s3, $s0, $s3
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, tig_ord
	la $s5, L32
	move $a0, $s5
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, tig_chr
	add $s5, $s3, $s2
	move $a0, $s5
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s1, $v0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, tig_print
	move $a0, $s1
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s1, $0
	j L34
	.end f
	j L62
L62:

	.globl printint
	.ent printint
	.text
printint:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	move $s0, $a1
	sw $a0, 0($fp)
	blt $s0, $0, L40
b L41
L41:
	bgt $s0, $0, L37
b L38
L38:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s1, tig_print
	la $s2, L36
	move $a0, $s2
	jal $s1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $0
L39:
L42:
	move $v0, $s0
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L37:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s3, f
	move $a0, $fp
	move $a1, $s0
	jal $s3
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $0
	j L39
L40:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s1, tig_print
	la $s2, L35
	move $a0, $s2
	jal $s1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s4, f
	move $a0, $fp
	addi $s1, $s0, 0
	move $a1, $s1
	jal $s4
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $0
	j L42
	.end printint
	j L63
L63:

	.globl printlist
	.ent printlist
	.text
printlist:
	sw $fp, -4($sp)
	move $fp, $sp
	sw $sp, -8($fp)
	addi $sp,$sp, -48
	sw $ra, -44($fp)
	sw $s0, -40($fp)
	sw $s1, -36($fp)
	sw $s2, -32($fp)
	sw $s3, -28($fp)
	sw $s4, -24($fp)
	sw $s5, -20($fp)
	sw $s6, -16($fp)
	sw $s7, -12($fp)
	move $s0, $a1
	sw $a0, 0($fp)
	beq $s0, $0, L45
b L46
L46:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s1, printint
	lw $s2 0($fp)
	move $a0, $s2
	lw $s2, 0($s0)
	move $a1, $s2
	jal $s1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s1, tig_print
	la $s2, L44
	move $a0, $s2
	jal $s1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s1, printlist
	lw $s2 0($fp)
	move $a0, $s2
	lw $s2, 4($s0)
	move $a1, $s2
	jal $s1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $0
L47:
	move $v0, $s0
	lw $ra, -44($fp)
	lw $s0, -40($fp)
	lw $s1, -36($fp)
	lw $s2, -32($fp)
	lw $s3, -28($fp)
	lw $s4, -24($fp)
	lw $s5, -20($fp)
	lw $s6, -16($fp)
	lw $s7, -12($fp)
	lw $sp, -8($fp)
	lw $fp, -4($fp)
	jr $ra
L45:
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s1, tig_print
	la $s2, L43
	move $a0, $s2
	jal $s1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $0
	j L47
	.end printlist
	j L64
L64:

	.globl tig_main
	.ent tig_main
	.text
tig_main:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp,$sp, -52
	sw $ra, -48($fp)
	sw $s0, -44($fp)
	sw $s1, -40($fp)
	sw $s2, -36($fp)
	sw $s3, -32($fp)
	sw $s4, -28($fp)
	sw $s5, -24($fp)
	sw $s6, -20($fp)
	sw $s7, -16($fp)
	sw $a0, 0($fp)
	addi $s2, $fp, -4
	move $s3, $s2
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s2, tig_getchar
	jal $s2
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	sw $s2, 0($s3)
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s7, readlist
	move $a0, $fp
	jal $s7
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s0, $v0
	addi $s2, $fp, -4
	move $s4, $s2
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s2, tig_getchar
	jal $s2
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s2, $v0
	sw $s2, 0($s4)
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $t0, readlist
	move $a0, $fp
	jal $t0
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s1, $v0
	move $s6, $fp
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $t1, merge
	move $a0, $fp
	move $a1, $s0
	move $a2, $s1
	jal $t1
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $s5, $v0
	addi $sp, $sp, -40
	sw $t9, 40($sp)
	sw $t8, 36($sp)
	sw $t7, 32($sp)
	sw $t6, 28($sp)
	sw $t5, 24($sp)
	sw $t4, 20($sp)
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $t0, 4($sp)
	la $s2, printlist
	move $a0, $s6
	move $a1, $s5
	jal $s2
	lw $t9, 40($sp)
	lw $t8, 36($sp)
	lw $t7, 32($sp)
	lw $t6, 28($sp)
	lw $t5, 24($sp)
	lw $t4, 20($sp)
	lw $t3, 16($sp)
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 40
	move $v0, $0
	lw $ra, -48($fp)
	lw $s0, -44($fp)
	lw $s1, -40($fp)
	lw $s2, -36($fp)
	lw $s3, -32($fp)
	lw $s4, -28($fp)
	lw $s5, -24($fp)
	lw $s6, -20($fp)
	lw $s7, -16($fp)
	lw $sp, -12($fp)
	lw $fp, -8($fp)
	jr $ra
	.end tig_main
	j L65
L65:
	#.file	1 "runtime.c"
	.option pic2
	.text
	.align 4
	.globl	tig_initArray
	.ent	tig_initArray
tig_initArray:
.LFB1:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI0:
	sd	$ra,48($sp)
.LCFI1:
	sd	$fp,40($sp)
.LCFI2:
.LCFI3:
	move	$fp,$sp
.LCFI4:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	move	$v1,$v0
	sll	$v0,$v1,2
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,16($fp)
	sw	$v1,0($v0)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
.L3:
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	lw	$v1,24($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,.L6
	b	.L4
.L6:
	lw	$v0,24($fp)
	move	$v1,$v0
	sll	$v0,$v1,2
	lw	$v1,28($fp)
	addu	$v0,$v0,$v1
	lw	$v1,20($fp)
	sw	$v1,0($v0)
.L5:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L3
.L4:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L2
.L2:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE1:
	.end	tig_initArray
	.align 4
	.globl	tig_allocRecord
	.ent	tig_allocRecord
tig_allocRecord:
.LFB2:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI5:
	sd	$ra,48($sp)
.LCFI6:
	sd	$fp,40($sp)
.LCFI7:
.LCFI8:
	move	$fp,$sp
.LCFI9:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$a0,16($fp)
	la	$t9,malloc
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	sw	$v0,28($fp)
	sw	$v0,24($fp)
	sw	$zero,20($fp)
.L8:
	lw	$v0,20($fp)
	lw	$v1,16($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L11
	b	.L9
.L11:
	addu	$v0,$fp,24
	lw	$v1,0($v0)
	sw	$zero,0($v1)
	addu	$v1,$v1,4
	sw	$v1,0($v0)
.L10:
	lw	$v0,20($fp)
	addu	$v1,$v0,4
	sw	$v1,20($fp)
	b	.L8
.L9:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L7
.L7:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE2:
	.end	tig_allocRecord
	.align 4
	.globl	tig_stringEqual
	.ent	tig_stringEqual
tig_stringEqual:
.LFB3:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI10:
	sd	$fp,40($sp)
.LCFI11:
.LCFI12:
	move	$fp,$sp
.LCFI13:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	bne	$v0,$v1,.L13
	li	$v0,1			# 0x1
	b	.L12
.L13:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	beq	$v0,$v1,.L14
	move	$v0,$zero
	b	.L12
.L14:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L15:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L18
	b	.L16
.L18:
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v0,0($v0)
	lbu	$v1,0($a0)
	beq	$v0,$v1,.L17
	move	$v0,$zero
	b	.L12
.L19:
.L17:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L15
.L16:
	li	$v0,1			# 0x1
	b	.L12
.L12:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE3:
	.end	tig_stringEqual
	.align 4
	.globl	tig_print
	.ent	tig_print
tig_print:
.LFB4:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI14:
	sd	$ra,48($sp)
.LCFI15:
	sd	$fp,40($sp)
.LCFI16:
.LCFI17:
	move	$fp,$sp
.LCFI18:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	sw	$v1,24($fp)
	sw	$zero,20($fp)
.L21:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L24
	b	.L22
.L24:
	lw	$v0,24($fp)
	lbu	$v1,0($v0)
	move	$a0,$v1
	la	$t9,putchar
	jal	$ra,$t9
.L23:
	lw	$v0,20($fp)
	addu	$v1,$v0,1
	sw	$v1,20($fp)
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L21
.L22:
.L20:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE4:
	.end	tig_print
	.globl	consts
	.data
	.align 4
consts:
	.word	0

	.byte	0x0
	.space	3
	.space	2040
	.globl	empty
	.align 4
empty:
	.word	0

	.byte	0x0
	.space	3
	.text
	.align 4
	.globl	main
	.ent	main
main:
.LFB5:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI19:
	sd	$ra,48($sp)
.LCFI20:
	sd	$fp,40($sp)
.LCFI21:
.LCFI22:
	move	$fp,$sp
.LCFI23:
	.set	noat
	.set	at
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,16($fp)
.L26:
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	bne	$v1,$zero,.L29
	b	.L27
.L29:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v1,$v0
	li	$v1,1			# 0x1
	sw	$v1,0($v0)
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v0,$v1
	lbu	$v1,16($fp)
	sb	$v1,4($v0)
.L28:
	lw	$v0,16($fp)
	addu	$v1,$v0,1
	sw	$v1,16($fp)
	b	.L26
.L27:
	move	$a0,$zero
	la	$t9,tig_main
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L25
.L25:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE5:
	.end	main
	.align 4
	.globl	tig_ord
	.ent	tig_ord
tig_ord:
.LFB6:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI24:
	sd	$fp,40($sp)
.LCFI25:
.LCFI26:
	move	$fp,$sp
.LCFI27:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L31
	li	$v0,-1			# 0xffffffff
	b	.L30
	b	.L32
.L31:
	lw	$v0,16($fp)
	lbu	$v1,4($v0)
	move	$v0,$v1
	b	.L30
.L32:
.L30:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE6:
	.end	tig_ord
	.align 4
	.globl	tig_chr
	.ent	tig_chr
tig_chr:
.LFB7:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI28:
	sd	$ra,48($sp)
.LCFI29:
	sd	$fp,40($sp)
.LCFI30:
.LCFI31:
	move	$fp,$sp
.LCFI32:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	bltz	$v0,.L35
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	beq	$v1,$zero,.L35
	b	.L34
.L35:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L34:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L33
.L33:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE7:
	.end	tig_chr
	.align 4
	.globl	tig_size
	.ent	tig_size
tig_size:
.LFB8:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI33:
	sd	$fp,40($sp)
.LCFI34:
.LCFI35:
	move	$fp,$sp
.LCFI36:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	move	$v0,$v1
	b	.L36
.L36:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE8:
	.end	tig_size
.data
	.align 4
.LC0:

	.byte	0x73,0x75,0x62,0x73,0x74,0x72,0x69,0x6e
	.byte	0x67,0x28,0x5b,0x25,0x64,0x5d,0x2c,0x25
	.byte	0x64,0x2c,0x25,0x64,0x29,0x20,0x6f,0x75
	.byte	0x74,0x20,0x6f,0x66,0x20,0x72,0x61,0x6e
	.byte	0x67,0x65,0xa,0x0
	.text
	.align 4
	.globl	tig_substring
	.ent	tig_substring
tig_substring:
.LFB9:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI37:
	sd	$ra,64($sp)
.LCFI38:
	sd	$fp,56($sp)
.LCFI39:
.LCFI40:
	move	$fp,$sp
.LCFI41:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	sw	$a2,24($fp)
	lw	$v0,20($fp)
	bltz	$v0,.L39
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	addu	$v0,$v0,$v1
	lw	$v1,16($fp)
	lw	$a0,0($v1)
	slt	$v0,$a0,$v0
	bne	$v0,$zero,.L39
	b	.L38
.L39:
	lw	$v0,16($fp)
	la	$a0,.LC0
	lw	$a1,0($v0)
	lw	$a2,20($fp)
	lw	$a3,24($fp)
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L38:
	lw	$v0,24($fp)
	li	$v1,1			# 0x1
	bne	$v0,$v1,.L40
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$v0,20($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,0($v1)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L37
.L40:
	lw	$v1,24($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	sw	$v1,0($v0)
	sw	$zero,32($fp)
.L41:
	lw	$v0,32($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L44
	b	.L42
.L44:
	lw	$v0,28($fp)
	addu	$v1,$v0,4
	lw	$a0,32($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	lw	$a0,20($fp)
	lw	$a1,32($fp)
	addu	$a0,$a0,$a1
	addu	$v1,$v1,4
	addu	$a0,$v1,$a0
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L43:
	lw	$v0,32($fp)
	addu	$v1,$v0,1
	sw	$v1,32($fp)
	b	.L41
.L42:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L37
.L37:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE9:
	.end	tig_substring
	.align 4
	.globl	tig_concat
	.ent	tig_concat
tig_concat:
.LFB10:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI42:
	sd	$ra,64($sp)
.LCFI43:
	sd	$fp,56($sp)
.LCFI44:
.LCFI45:
	move	$fp,$sp
.LCFI46:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L46
	lw	$v1,20($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L46:
	lw	$v0,20($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L48
	lw	$v1,16($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L48:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	addu	$v0,$v0,$v1
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	lw	$v1,28($fp)
	sw	$v1,0($v0)
	sw	$zero,24($fp)
.L50:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L53
	b	.L51
.L53:
	lw	$v0,32($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L52:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L50
.L51:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L54:
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L57
	b	.L55
.L57:
	lw	$v0,32($fp)
	lw	$v1,16($fp)
	lw	$a0,24($fp)
	lw	$a1,0($v1)
	addu	$v1,$a0,$a1
	addu	$a0,$v0,4
	addu	$v0,$a0,$v1
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L56:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L54
.L55:
	lw	$v1,32($fp)
	move	$v0,$v1
	b	.L45
.L49:
.L47:
.L45:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE10:
	.end	tig_concat
	.align 4
	.globl	tig_not
	.ent	tig_not
tig_not:
.LFB11:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI47:
	sd	$fp,40($sp)
.LCFI48:
.LCFI49:
	move	$fp,$sp
.LCFI50:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	xori	$a0,$v0,0x0
	sltu	$v1,$a0,1
	move	$v0,$v1
	b	.L58
.L58:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE11:
	.end	tig_not
	.align 4
	.globl	tig_getchar
	.ent	tig_getchar
tig_getchar:
.LFB12:
	.frame	$fp,48,$ra		# vars= 0, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI51:
	sd	$ra,32($sp)
.LCFI52:
	sd	$fp,24($sp)
.LCFI53:
.LCFI54:
	move	$fp,$sp
.LCFI55:
	.set	noat
	.set	at
	la	$t9,getchar
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,tig_chr
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L59
.L59:
	move	$sp,$fp
	ld	$ra,32($sp)
	ld	$fp,24($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE12:
	.end	tig_getchar
tig_flush:
  j $ra
  .end tig_flush
tig_exit:
  j exit
  .end tig_exit
# system calls for Tiger, when running on SPIM
#
# $Id: sysspim.s,v 1.1 2002/08/25 05:06:41 shivers Exp $

	.globl malloc
	.ent malloc
	.text
malloc:
	# round up the requested amount to a multiple of 4
	add $a0, $a0, 3
	srl $a0, $a0, 2
	sll $a0, $a0, 2

	# allocate the memory with sbrk()
	li $v0, 9
	syscall
	
	j $ra

	.end malloc

	

	.data
	.align 4
getchar_buf:	.byte 0,0

	.text
getchar:
	# read the character
	la $a0, getchar_buf
	li $a1, 2
	li $v0, 8
	syscall

	# return it
	lb $v0, ($a0)
	j $ra
	

	.data
	.align 4
putchar_buf:	.byte 0,0

	.text
putchar:
	# save the character so that it is NUL-terminated 
	la $t0, putchar_buf
	sb $a0, ($t0)

	# print it out
	la $a0, putchar_buf
	li $v0, 4
	syscall

	j $ra


	.text	
# just prints the format string, not the arguments
printf:
	li $v0, 4
	syscall
	j $ra


	.text
exit:
	li $v0, 10
	syscall
	