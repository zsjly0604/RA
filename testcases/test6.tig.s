main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L146:
	lw $a0, 6($fp)
	li $a1, 0
	la $a2, L144
	jal L142
	b L145
L145:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L141:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L148:
	lw $a3, 6($fp)
	lw $a0, 0($a3)
	lw $a1, -4($fp)
	la $a2, L143
	jal L142
	b L147
L147:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L142:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L150:
	lw $a3, 6($fp)
	lw $a0, 0($a3)
	addi $a1, $a2, 1
	jal L141
	b L149
L149:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

