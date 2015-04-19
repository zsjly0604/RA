main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L134:
	lw $a0, 6($fp)
	li $a1, 10
	jal L129
	b L133
L133:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L129:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L136:
	li $v0, 1
	lw $a3, -4($fp)
	beqz $a3, L130
b L131
L131:
	lw $a2, -4($fp)
	move $a0, $fp
	lw $t0, -4($fp)
	addi $a1, $t0, -1
	jal L129
	mul $v0, $a2, $v0
L130:
	b L135
L135:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

