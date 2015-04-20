main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L135:
	li $s6, 8
	sw $s6, -12($a2)
	addi $t4, $a2, -16
	lw $t9, -12($a2)
	li $a1, 0
	jal initArray
	sw $t0, 0($t4)
	addi $t3, $a2, -20
	lw $t9, -12($a2)
	li $a1, 0
	jal initArray
	sw $t0, 0($t3)
	addi $t2, $a2, -24
	lw $t0, -12($a2)
	lw $t1, -12($a2)
	add $s7, $t0, $t1
	addi $t9, $s7, -1
	li $a1, 0
	jal initArray
	sw $t0, 0($t2)
	addi $t1, $a2, -28
	lw $a3, -12($a2)
	lw $s3, -12($a2)
	add $a3, $a3, $s3
	addi $t9, $a3, -1
	li $a1, 0
	jal initArray
	sw $t0, 0($t1)
	lw $t9, 6($a2)
	li $a1, 0
	jal L104
	li $t0, 0
	b L134
L134:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L104:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-20
L137:
	lw $t9, 6($fp)
	lw $a0, 0($t9)
	jal L105
	move $t8, $v0
	lw $t0, -4($fp)
	lw $t5, 0($fp)
	lw $t4, -12($t5)
	beq $t0, $t4, L131
b L132
L132:
	li $a2, 0
	sw $a2, -8($fp)
	lw $t7, 0($fp)
	lw $t6, -12($t7)
	addi $t2, $t6, -1
	lw $t3, -8($fp)
	ble $t3, $t2, L130
b L117
L117:
	li $t8, 0
L131:
	move $v0, $t8
	b L136
L130:
	li $a0, 1
	lw $t5, 0($fp)
	lw $t0, -28($t5)
	li $v0, 4
	lw $a2, -8($fp)
	addi $t1, $a2, 7
	lw $t9, -4($fp)
	sub $t6, $t1, $t9
	mul $t6, $v0, $t6
	add $t4, $t0, $t6
	lw $t3, 0($t4)
	beqz $t3, L126
b L127
L127:
	li $a0, 0
L126:
	move $t0, $a0
	li $t6, 1
	lw $t9, 0($fp)
	lw $a3, -24($t9)
	li $t5, 4
	lw $v0, -4($fp)
	lw $t2, -8($fp)
	add $t2, $t2, $v0
	mul $t7, $t5, $t2
	add $t8, $a3, $t7
	lw $t7, 0($t8)
	beqz $t7, L121
b L122
L122:
	li $t6, 0
L121:
	move $t5, $t6
	lw $a1, 0($fp)
	lw $t4, -16($a1)
	li $t3, 4
	lw $a2, -8($fp)
	mul $t8, $t3, $a2
	add $a0, $t4, $t8
	lw $v0, 0($a0)
	beqz $v0, L118
b L119
L119:
	li $t5, 0
L118:
	li $a2, 1
	beq $t5, $a2, L123
b L124
L124:
	li $t0, 0
L123:
	li $t6, 1
	beq $t0, $t6, L128
b L129
L129:
	lw $a3, -8($fp)
	addi $t8, $a3, 1
	move $t0, $t8
	sw $t0, -8($fp)
	lw $a0, 0($fp)
	lw $t9, -12($a0)
	addi $t7, $t9, -1
	lw $t4, -8($fp)
	blt $t4, $t7, L130
b L138
L138:
	b L117
L128:
	li $t9, 1
	lw $a3, 0($fp)
	lw $a0, -16($a3)
	li $t8, 4
	lw $t5, -8($fp)
	mul $ra, $t8, $t5
	add $a2, $a0, $ra
	sw $t9, 0($a2)
	li $t2, 1
	lw $t1, 0($fp)
	lw $t8, -24($t1)
	li $t1, 4
	lw $ra, -4($fp)
	lw $a3, -8($fp)
	add $t9, $a3, $ra
	mul $t7, $t1, $t9
	add $t0, $t8, $t7
	sw $t2, 0($t0)
	li $t4, 1
	lw $t3, 0($fp)
	lw $a1, -28($t3)
	li $ra, 4
	lw $t3, -8($fp)
	addi $a3, $t3, 7
	lw $t9, -4($fp)
	sub $v0, $a3, $t9
	mul $ra, $ra, $v0
	add $t2, $a1, $ra
	sw $t4, 0($t2)
	lw $v0, 0($fp)
	lw $t4, -20($v0)
	li $ra, 4
	lw $a0, -4($fp)
	mul $t5, $ra, $a0
	add $t4, $t4, $t5
	lw $t1, -8($fp)
	sw $t1, 0($t4)
	move $a0, $fp
	lw $a1, -4($fp)
	addi $a1, $a1, 1
	jal L104
	li $t1, 0
	lw $a2, 0($fp)
	lw $t3, -16($a2)
	li $v0, 4
	lw $t7, -8($fp)
	mul $t0, $v0, $t7
	add $a1, $t3, $t0
	sw $t1, 0($a1)
	li $t7, 0
	lw $t0, 0($fp)
	lw $a2, -24($t0)
	li $t6, 4
	lw $t5, -4($fp)
	lw $a3, -8($fp)
	add $a0, $a3, $t5
	mul $t1, $t6, $a0
	add $a3, $a2, $t1
	sw $t7, 0($a3)
	li $t8, 0
	lw $t2, 0($fp)
	lw $t3, -28($t2)
	li $a0, 4
	lw $t0, -8($fp)
	addi $t6, $t0, 7
	lw $a1, -4($fp)
	sub $a1, $t6, $a1
	mul $t2, $a0, $a1
	add $t1, $t3, $t2
	sw $t8, 0($t1)
	b L129
L136:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L105:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L140:
	li $a1, 0
	lw $t1, 0($fp)
	lw $t0, -12($t1)
	addi $a3, $t0, -1
	ble $a1, $a3, L115
b L106
L106:
	la $a0, L116
	jal print
	li $v0, 0
	b L139
L115:
	li $a2, 0
	lw $t4, 0($fp)
	lw $t3, -12($t4)
	addi $t2, $t3, -1
	ble $a2, $t2, L113
b L107
L107:
	la $a0, L114
	jal print
	addi $a1, $a1, 1
	lw $t7, 0($fp)
	lw $t6, -12($t7)
	addi $t5, $t6, -1
	blt $a1, $t5, L115
b L141
L141:
	b L106
L113:
	la $a0, L108
	lw $s0, 0($fp)
	lw $a3, -20($s0)
	li $s3, 4
	mul $s2, $s3, $a1
	add $t9, $a3, $s2
	lw $t8, 0($t9)
	beq $t8, $a2, L110
b L111
L111:
	la $a0, L109
L110:
	jal print
	addi $a2, $a2, 1
	lw $s5, 0($fp)
	lw $s4, -12($s5)
	addi $a0, $s4, -1
	blt $a2, $a0, L113
b L142
L142:
	b L107
L139:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

