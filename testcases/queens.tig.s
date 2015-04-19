main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L111:
	li $t2, 8
	sw $t2, -12($fp)
	addi $t1, $fp, -16
	lw $a0, -12($fp)
	li $a1, 0
	jal initArray
	sw $v0, 0($t1)
	addi $t0, $fp, -20
	lw $a0, -12($fp)
	li $a1, 0
	jal initArray
	sw $v0, 0($t0)
	addi $a3, $fp, -24
	lw $t4, -12($fp)
	lw $t5, -12($fp)
	add $t3, $t4, $t5
	addi $a0, $t3, -1
	li $a1, 0
	jal initArray
	sw $v0, 0($a3)
	addi $a2, $fp, -28
	lw $t7, -12($fp)
	lw $t8, -12($fp)
	add $t6, $t7, $t8
	addi $a0, $t6, -1
	li $a1, 0
	jal initArray
	sw $v0, 0($a2)
	lw $a0, 6($fp)
	li $a1, 0
	jal L80
	li $v0, 0
	b L110
L110:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L80:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L113:
	lw $t1, 6($fp)
	lw $a0, 0($t1)
	jal L81
	lw $t2, -4($fp)
	lw $t4, 0($fp)
	lw $t3, -12($t4)
	beq $t2, $t3, L107
b L108
L108:
	li $t0, 0
	lw $t7, 0($fp)
	lw $t6, -12($t7)
	addi $t5, $t6, -1
	ble $t0, $t5, L106
b L93
L93:
	li $v0, 0
L107:
	b L112
L106:
	li $a2, 1
	lw $a1, 0($fp)
	lw $a0, -28($a1)
	li $a3, 4
	addi $s2, $t0, 7
	lw $s3, -4($fp)
	sub $s0, $s2, $s3
	mul $a2, $a3, $s0
	add $t9, $a0, $a2
	lw $t8, 0($t9)
	beqz $t8, L102
b L103
L103:
	li $a2, 0
L102:
	li $a3, 1
	lw $s7, 0($fp)
	lw $s6, -24($s7)
	li $t1, 4
	lw $t3, -4($fp)
	add $t2, $t0, $t3
	mul $t0, $t1, $t2
	add $s5, $s6, $t0
	lw $s4, 0($s5)
	beqz $s4, L97
b L98
L98:
	li $a3, 0
L97:
	lw $t7, 0($fp)
	lw $t6, -16($t7)
	li $t9, 4
	mul $t8, $t9, $t0
	add $t5, $t6, $t8
	lw $t4, 0($t5)
	beqz $t4, L94
b L95
L95:
	li $a3, 0
L94:
	li $v0, 1
	beq $a3, $v0, L99
b L100
L100:
	li $a2, 0
L99:
	li $ra, 1
	beq $a2, $ra, L104
b L105
L105:
	addi $t0, $t0, 1
	lw $v1, 0($fp)
	lw $0, -12($v1)
	addi $sp, $0, -1
	blt $t0, $sp, L106
b L114
L114:
	b L93
L104:
	li $fp, 1
	lw $a2, 0($fp)
	lw $a1, -16($a2)
	li $s0, 4
	mul $a3, $s0, $t0
	add $a0, $a1, $a3
	sw $fp, 0($a0)
	li $s2, 1
	lw $s5, 0($fp)
	lw $s4, -24($s5)
	li $s7, 4
	lw $t1, -4($fp)
	add $t0, $t0, $t1
	mul $s6, $s7, $t0
	add $s3, $s4, $s6
	sw $s2, 0($s3)
	li $t2, 1
	lw $t5, 0($fp)
	lw $t4, -28($t5)
	li $t7, 4
	addi $t9, $t0, 7
	lw $v0, -4($fp)
	sub $t8, $t9, $v0
	mul $t6, $t7, $t8
	add $t3, $t4, $t6
	sw $t2, 0($t3)
	lw $sp, 0($fp)
	lw $fp, -20($sp)
	li $v1, 4
	lw $a0, -4($fp)
	mul $0, $v1, $a0
	add $ra, $fp, $0
	sw $t0, 0($ra)
	move $a0, $fp
	lw $a1, -4($fp)
	addi $a1, $a1, 1
	jal L80
	li $a2, 0
	lw $s2, 0($fp)
	lw $s0, -16($s2)
	li $s4, 4
	mul $s3, $s4, $t0
	add $a3, $s0, $s3
	sw $a2, 0($a3)
	li $s5, 0
	lw $t0, 0($fp)
	lw $s7, -24($t0)
	li $t2, 4
	lw $t4, -4($fp)
	add $t3, $t0, $t4
	mul $t1, $t2, $t3
	add $s6, $s7, $t1
	sw $s5, 0($s6)
	li $t5, 0
	lw $t8, 0($fp)
	lw $t7, -28($t8)
	li $fp, 4
	addi $ra, $t0, 7
	lw $sp, -4($fp)
	sub $v0, $ra, $sp
	mul $t9, $fp, $v0
	add $t6, $t7, $t9
	sw $t5, 0($t6)
	b L105
L112:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L81:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L116:
	li $a2, 0
	lw $t1, 0($fp)
	lw $t0, -12($t1)
	addi $a3, $t0, -1
	ble $a2, $a3, L91
b L82
L82:
	la $a0, L92
	jal print
	li $v0, 0
	b L115
L91:
	li $a1, 0
	lw $t4, 0($fp)
	lw $t3, -12($t4)
	addi $t2, $t3, -1
	ble $a1, $t2, L89
b L83
L83:
	la $a0, L90
	jal print
	addi $a2, $a2, 1
	lw $t7, 0($fp)
	lw $t6, -12($t7)
	addi $t5, $t6, -1
	blt $a2, $t5, L91
b L117
L117:
	b L82
L89:
	la $a0, L84
	lw $a1, 0($fp)
	lw $a0, -20($a1)
	li $a3, 4
	mul $a2, $a3, $a2
	add $t9, $a0, $a2
	lw $t8, 0($t9)
	beq $t8, $a1, L86
b L87
L87:
	la $a0, L85
L86:
	jal print
	addi $a1, $a1, 1
	lw $s3, 0($fp)
	lw $s2, -12($s3)
	addi $s0, $s2, -1
	blt $a1, $s0, L89
b L118
L118:
	b L83
L115:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

