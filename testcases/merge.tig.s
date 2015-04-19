main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-20
L60:
	addi $t0, $fp, -8
	jal getchar
	sw $v0, 0($t0)
	lw $a0, 1($fp)
	jal L29
	move $a1, $v0
	addi $a3, $fp, -8
	jal getchar
	sw $v0, 0($a3)
	lw $a0, 1($fp)
	jal L29
	move $a2, $v0
	lw $a0, 1($fp)
	lw $a0, 1($fp)
	jal L28
	move $a1, $v0
	jal L26
	li $v0, 0
	b L59
L59:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L26:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L62:
	la $a0, L54
	jal print
	lw $a2, -4($fp)
	beqz $a2, L56
b L57
L57:
	lw $a3, 1($fp)
	lw $a0, 0($a3)
	lw $t0, -4($fp)
	lw $a1, 0($t0)
	jal L27
	la $a0, L55
	jal print
	move $a0, $fp
	lw $t1, -4($fp)
	lw $a1, 4($t1)
	jal L26
	li $v0, 0
L56:
	b L61
L61:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L27:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L64:
	la $a0, L46
	jal print
	lw $a2, 1($fp)
	lw $a0, 0($a2)
	li $a3, 0
	lw $t0, -4($fp)
	sub $a1, $a3, $t0
	jal L42
	li $v0, 0
	lw $t1, -4($fp)
	bltz $t1, L51
b L52
L52:
	lw $t2, 1($fp)
	lw $a0, 0($t2)
	lw $a1, -4($fp)
	jal L42
	lw $t3, -4($fp)
	bgtz $t3, L48
b L49
L49:
	la $a0, L47
	jal print
L48:
L51:
	b L63
L63:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L42:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L66:
	lw $a3, -4($fp)
	bgtz $a3, L44
b L45
L45:
	li $v0, 0
	b L65
L44:
	move $a0, $fp
	lw $t0, -4($fp)
	li $t1, 10
	div $a1, $t0, $t1
	jal L42
	lw $t2, -4($fp)
	lw $t5, -4($fp)
	li $t6, 10
	div $t4, $t5, $t6
	li $t7, 10
	mul $t3, $t4, $t7
	sub $a2, $t2, $t3
	la $a0, L43
	jal ord
	add $a0, $a2, $v0
	jal chr
	move $a0, $v0
	jal print
	b L45
L65:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L28:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L68:
	lw $v0, -4($fp)
	beqz $a1, L39
b L40
L40:
	lw $t1, -4($fp)
	beqz $t1, L36
b L37
L37:
	li $a0, 8
	jal allocRecord
	lw $t2, 0($a1)
	sw $t2, 0($v0)
	addi $t0, $v0, 4
	move $a0, $fp
	lw $a1, 4($a1)
	lw $a2, -4($fp)
	jal L28
	sw $v0, 0($t0)
	lw $t3, 0($a1)
	lw $t5, -4($fp)
	lw $t4, 0($t5)
	blt $t3, $t4, L33
b L34
L34:
	li $a0, 8
	jal allocRecord
	lw $t7, -4($fp)
	lw $t6, 0($t7)
	sw $t6, 0($v0)
	addi $a3, $v0, 4
	move $a0, $fp
	lw $t8, -4($fp)
	lw $a2, 4($t8)
	jal L28
	sw $v0, 0($a3)
L33:
	move $a1, $v0
L36:
	move $v0, $a1
L39:
	b L67
L67:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L29:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L70:
	li $a0, 4
	jal allocRecord
	li $a3, 0
	sw $a3, 0($v0)
	move $a1, $v0
	lw $t0, 1($fp)
	lw $a0, 0($t0)
	jal L2
	li $a0, 8
	jal allocRecord
	sw $v0, 0($v0)
	addi $a2, $v0, 4
	move $a0, $fp
	jal L29
	sw $v0, 0($a2)
	lw $t1, 0($a1)
	li $t2, 1
	beq $t1, $t2, L30
b L31
L31:
	li $v0, 0
L30:
	b L69
L69:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L2:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L72:
	li $v0, 0
	lw $t2, 1($fp)
	lw $a0, 0($t2)
	jal L3
	lw $t3, -4($fp)
	addi $t1, $t3, 0
	lw $t4, 1($fp)
	lw $a0, 0($t4)
	lw $t5, 0($fp)
	lw $a1, -8($t5)
	jal L4
	sw $v0, 0($t1)
L24:
	lw $t6, 1($fp)
	lw $a0, 0($t6)
	lw $t7, 0($fp)
	lw $a1, -8($t7)
	jal L4
	li $t8, 1
	beq $v0, $t8, L25
b L22
L22:
	b L71
L25:
	li $t9, 10
	mul $t0, $v0, $t9
	lw $a0, 0($fp)
	lw $a0, -8($a0)
	jal ord
	add $a3, $t0, $v0
	la $a0, L23
	jal ord
	sub $v0, $a3, $v0
	lw $a1, 0($fp)
	addi $a2, $a1, -8
	jal getchar
	sw $v0, 0($a2)
	b L24
L71:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L3:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L20:
	li $a1, 1
	lw $t0, 0($fp)
	lw $a3, 0($t0)
	lw $a2, -8($a3)
	la $t1, L12
	beq $a2, $t1, L14
b L15
L15:
	li $a1, 1
	lw $t4, 0($fp)
	lw $t3, 0($t4)
	lw $t2, -8($t3)
	la $t5, L13
	beq $t2, $t5, L17
b L18
L18:
	li $a1, 0
L17:
L14:
	li $t6, 1
	beq $a1, $t6, L21
b L19
L19:
	li $v0, 0
	b L73
L21:
	lw $t8, 0($fp)
	lw $t7, 0($t8)
	addi $a0, $t7, -8
	jal getchar
	sw $v0, 0($a0)
	b L20
L73:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L4:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L75:
	li $v0, 1
	lw $a2, 0($fp)
	lw $a1, 0($a2)
	lw $a0, -8($a1)
	jal ord
	la $a0, L6
	jal ord
	ble $v0, $v0, L10
b L11
L11:
	li $v0, 0
L10:
	lw $t0, 0($fp)
	lw $a3, 0($t0)
	lw $a0, -8($a3)
	jal ord
	la $a0, L5
	jal ord
	bge $v0, $v0, L7
b L8
L8:
	li $v0, 0
L7:
	b L74
L74:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

