main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L178:
	li $a2, 0
	lw $a0, 6($fp)
	li $a1, 2
	jal L176
	b L177
L177:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

