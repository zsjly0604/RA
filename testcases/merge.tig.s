main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-20
L63:
	addi $t0, $fp, -8
	jal getchar
	sw $v0, 0($t0)
	lw $a0, 1($fp)
	jal L32
	move $a1, $v0
	addi $a3, $fp, -8
	jal getchar
	sw $v0, 0($a3)
	lw $a0, 1($fp)
	jal L32
	move $a2, $v0
	lw $a0, 1($fp)
	lw $a0, 1($fp)
	jal L31
	move $a1, $v0
	jal L29
	li $v0, 0
	b L62
L62:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L29:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L65:
	la $a0, L57
	jal print
	lw $a2, -4($fp)
	beqz $a2, L59
b L60
L60:
	lw $a3, 1($fp)
	lw $a0, 0($a3)
	lw $t0, -4($fp)
	lw $a1, 0($t0)
	jal L30
	la $a0, L58
	jal print
	move $a0, $fp
	lw $t1, -4($fp)
	lw $a1, 4($t1)
	jal L29
	li $v0, 0
L59:
	b L64
L64:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L30:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L67:
	la $a0, L49
	jal print
	lw $a2, 1($fp)
	lw $a0, 0($a2)
	li $a3, 0
	lw $t0, -4($fp)
	sub $a1, $a3, $t0
	jal L45
	li $v0, 0
	lw $t1, -4($fp)
	bltz $t1, L54
b L55
L55:
	lw $t2, 1($fp)
	lw $a0, 0($t2)
	lw $a1, -4($fp)
	jal L45
	lw $t3, -4($fp)
	bgtz $t3, L51
b L52
L52:
	la $a0, L50
	jal print
L51:
L54:
	b L66
L66:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L45:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L69:
	lw $a3, -4($fp)
	bgtz $a3, L47
b L48
L48:
	li $v0, 0
	b L68
L47:
	move $a0, $fp
	lw $t0, -4($fp)
	li $t1, 10
	div $a1, $t0, $t1
	jal L45
	lw $t2, -4($fp)
	lw $t5, -4($fp)
	li $t6, 10
	div $t4, $t5, $t6
	li $t7, 10
	mul $t3, $t4, $t7
	sub $a2, $t2, $t3
	la $a0, L46
	jal ord
	add $a0, $a2, $v0
	jal chr
	move $a0, $v0
	jal print
	b L48
L68:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L31:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L71:
	lw $v0, -4($fp)
	beqz $a1, L42
b L43
L43:
	lw $t1, -4($fp)
	beqz $t1, L39
b L40
L40:
	li $a0, 8
	jal allocRecord
	lw $t2, 0($a1)
	sw $t2, 0($v0)
	addi $t0, $v0, 4
	move $a0, $fp
	lw $a1, 4($a1)
	lw $a2, -4($fp)
	jal L31
	sw $v0, 0($t0)
	lw $t3, 0($a1)
	lw $t5, -4($fp)
	lw $t4, 0($t5)
	blt $t3, $t4, L36
b L37
L37:
	li $a0, 8
	jal allocRecord
	lw $t7, -4($fp)
	lw $t6, 0($t7)
	sw $t6, 0($v0)
	addi $a3, $v0, 4
	move $a0, $fp
	lw $t8, -4($fp)
	lw $a2, 4($t8)
	jal L31
	sw $v0, 0($a3)
L36:
	move $a1, $v0
L39:
	move $v0, $a1
L42:
	b L70
L70:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L32:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L73:
	li $a0, 4
	jal allocRecord
	li $a3, 0
	sw $a3, 0($v0)
	move $a1, $v0
	lw $t0, 1($fp)
	lw $a0, 0($t0)
	jal L5
	li $a0, 8
	jal allocRecord
	sw $v0, 0($v0)
	addi $a2, $v0, 4
	move $a0, $fp
	jal L32
	sw $v0, 0($a2)
	lw $t1, 0($a1)
	li $t2, 1
	beq $t1, $t2, L33
b L34
L34:
	li $v0, 0
L33:
	b L72
L72:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L5:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L75:
	li $v0, 0
	lw $t2, 1($fp)
	lw $a0, 0($t2)
	jal L6
	lw $t3, -4($fp)
	addi $t1, $t3, 0
	lw $t4, 1($fp)
	lw $a0, 0($t4)
	lw $t5, 0($fp)
	lw $a1, -8($t5)
	jal L7
	sw $v0, 0($t1)
L27:
	lw $t6, 1($fp)
	lw $a0, 0($t6)
	lw $t7, 0($fp)
	lw $a1, -8($t7)
	jal L7
	li $t8, 1
	beq $v0, $t8, L28
b L25
L25:
	b L74
L28:
	li $t9, 10
	mul $t0, $v0, $t9
	lw $a0, 0($fp)
	lw $a0, -8($a0)
	jal ord
	add $a3, $t0, $v0
	la $a0, L26
	jal ord
	sub $v0, $a3, $v0
	lw $a1, 0($fp)
	addi $a2, $a1, -8
	jal getchar
	sw $v0, 0($a2)
	b L27
L74:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L6:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L23:
	li $a1, 1
	lw $t0, 0($fp)
	lw $a3, 0($t0)
	lw $a2, -8($a3)
	la $t1, L15
	beq $a2, $t1, L17
b L18
L18:
	li $a1, 1
	lw $t4, 0($fp)
	lw $t3, 0($t4)
	lw $t2, -8($t3)
	la $t5, L16
	beq $t2, $t5, L20
b L21
L21:
	li $a1, 0
L20:
L17:
	li $t6, 1
	beq $a1, $t6, L24
b L22
L22:
	li $v0, 0
	b L76
L24:
	lw $t8, 0($fp)
	lw $t7, 0($t8)
	addi $a0, $t7, -8
	jal getchar
	sw $v0, 0($a0)
	b L23
L76:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L7:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L78:
	li $v0, 1
	lw $a2, 0($fp)
	lw $a1, 0($a2)
	lw $a0, -8($a1)
	jal ord
	la $a0, L9
	jal ord
	ble $v0, $v0, L13
b L14
L14:
	li $v0, 0
L13:
	lw $t0, 0($fp)
	lw $a3, 0($t0)
	lw $a0, -8($a3)
	jal ord
	la $a0, L8
	jal ord
	bge $v0, $v0, L10
b L11
L11:
	li $v0, 0
L10:
	b L77
L77:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

