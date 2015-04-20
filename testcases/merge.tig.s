main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-20
L87:
	addi $t3, $t5, -8
	jal getchar
	sw $t0, 0($t3)
	lw $t6, 1($t5)
	jal L56
	move $t1, $t0
	addi $t2, $t5, -8
	jal getchar
	sw $t0, 0($t2)
	lw $t6, 1($t5)
	jal L56
	move $a3, $t0
	lw $t4, 1($t5)
	lw $t6, 1($t5)
	jal L55
	move $t1, $t0
	move $t6, $t4
	jal L53
	li $t0, 0
	b L86
L86:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L53:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L89:
	la $a0, L81
	jal print
	move $t0, $v0
	lw $t1, -4($fp)
	beqz $t1, L83
b L84
L84:
	lw $t2, 1($fp)
	lw $a0, 0($t2)
	lw $a2, -4($fp)
	lw $a1, 0($a2)
	jal L54
	la $a0, L82
	jal print
	move $a0, $fp
	lw $a3, -4($fp)
	lw $a1, 4($a3)
	jal L53
	li $t0, 0
L83:
	move $v0, $t0
	b L88
L88:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L54:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L91:
	la $a0, L73
	jal print
	lw $t1, 1($fp)
	lw $a0, 0($t1)
	li $t2, 0
	lw $t3, -4($fp)
	sub $a1, $t2, $t3
	jal L69
	li $a2, 0
	lw $t0, -4($fp)
	bltz $t0, L78
b L79
L79:
	lw $t4, 1($fp)
	lw $a0, 0($t4)
	lw $a1, -4($fp)
	jal L69
	move $a2, $v0
	lw $a3, -4($fp)
	bgtz $a3, L75
b L76
L76:
	la $a0, L74
	jal print
	move $a2, $v0
L75:
L78:
	move $v0, $a2
	b L90
L90:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L69:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L93:
	lw $a3, -4($t0)
	bgtz $a3, L71
b L72
L72:
	li $a1, 0
	b L92
L71:
	move $t7, $t0
	lw $a2, -4($t0)
	li $s5, 10
	div $a1, $a2, $s5
	jal L69
	lw $s7, -4($t0)
	lw $a3, -4($t0)
	li $s2, 10
	div $s3, $a3, $s2
	li $s4, 10
	mul $a2, $s3, $s4
	sub $t7, $s7, $a2
	move $s6, $t7
	la $t7, L70
	jal ord
	add $t7, $s6, $a1
	jal chr
	move $t7, $a1
	jal print
	b L72
L92:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L55:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L95:
	lw $v0, -4($fp)
	beqz $a3, L66
b L67
L67:
	lw $t0, -4($fp)
	beqz $t0, L63
b L64
L64:
	li $a0, 8
	jal allocRecord
	move $t4, $v0
	lw $a1, 0($a3)
	sw $a1, 0($t4)
	addi $a0, $t4, 4
	move $a0, $fp
	lw $a1, 4($a3)
	lw $a2, -4($fp)
	jal L55
	sw $v0, 0($a0)
	lw $t5, 0($a3)
	lw $t2, -4($fp)
	lw $t1, 0($t2)
	blt $t5, $t1, L60
b L61
L61:
	li $a0, 8
	jal allocRecord
	move $t0, $v0
	lw $t7, -4($fp)
	lw $t6, 0($t7)
	sw $t6, 0($t0)
	addi $t8, $t0, 4
	move $t9, $t8
	move $a0, $fp
	move $a1, $a3
	lw $t3, -4($fp)
	lw $a2, 4($t3)
	jal L55
	sw $v0, 0($t9)
	move $t4, $t0
L60:
	move $a3, $t4
L63:
	move $v0, $a3
L66:
	b L94
L94:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L56:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L97:
	li $t8, 4
	jal allocRecord
	li $a2, 0
	sw $a2, 0($t0)
	move $s7, $t0
	lw $a3, 1($t1)
	lw $t8, 0($a3)
	move $a1, $s7
	jal L29
	move $a3, $t0
	li $t8, 8
	jal allocRecord
	move $s6, $t0
	sw $a3, 0($s6)
	addi $s5, $s6, 4
	move $s4, $s5
	move $t8, $t1
	jal L56
	sw $t0, 0($s4)
	move $s3, $s6
	lw $a1, 0($s7)
	li $a2, 1
	beq $a1, $a2, L57
b L58
L58:
	li $s3, 0
L57:
	move $t0, $s3
	b L96
L96:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L29:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L99:
	li $v0, 0
	lw $t1, 1($fp)
	lw $t4, 0($t1)
	jal L30
	lw $t2, -4($fp)
	addi $t0, $t2, 0
	lw $t3, 1($fp)
	lw $t4, 0($t3)
	lw $t5, 0($fp)
	lw $a0, -8($t5)
	jal L31
	sw $t7, 0($t0)
L51:
	lw $a2, 1($fp)
	lw $t4, 0($a2)
	lw $s2, 0($fp)
	lw $a0, -8($s2)
	jal L31
	move $s3, $t7
	li $s6, 1
	beq $s3, $s6, L52
b L49
L49:
	move $t7, $v0
	b L98
L52:
	li $t6, 10
	mul $a3, $v0, $t6
	lw $t8, 0($fp)
	lw $t4, -8($t8)
	jal ord
	add $t4, $a3, $t7
	move $s7, $t4
	la $t4, L50
	jal ord
	sub $t7, $s7, $t7
	move $v0, $t7
	lw $s0, 0($fp)
	addi $s5, $s0, -8
	move $s4, $s5
	jal getchar
	sw $t7, 0($s4)
	b L51
L98:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L30:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L47:
	li $s7, 1
	lw $s5, 0($a1)
	lw $s4, 0($s5)
	lw $t6, -8($s4)
	la $t7, L39
	beq $t6, $t7, L41
b L42
L42:
	li $s3, 1
	lw $s2, 0($a1)
	lw $a0, 0($s2)
	lw $t8, -8($a0)
	la $t9, L40
	beq $t8, $t9, L44
b L45
L45:
	li $s3, 0
L44:
	move $s7, $s3
L41:
	li $s6, 1
	beq $s7, $s6, L48
b L46
L46:
	li $a0, 0
	b L100
L48:
	lw $t7, 0($a1)
	lw $t6, 0($t7)
	addi $s0, $t6, -8
	jal getchar
	sw $a0, 0($s0)
	b L47
L100:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L31:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L102:
	li $a3, 1
	lw $t1, 0($fp)
	lw $t0, 0($t1)
	lw $a1, -8($t0)
	jal ord
	la $a1, L33
	jal ord
	ble $v0, $v0, L37
b L38
L38:
	li $a3, 0
L37:
	lw $t3, 0($fp)
	lw $t2, 0($t3)
	lw $a1, -8($t2)
	jal ord
	move $a2, $v0
	la $a1, L32
	jal ord
	bge $a2, $v0, L34
b L35
L35:
	li $a3, 0
L34:
	move $v0, $a3
	b L101
L101:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

