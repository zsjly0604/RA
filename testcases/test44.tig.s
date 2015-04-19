main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L6:
	li $a0, 0
	li $a0, 0
	li $v0, 0
	b L5
L5:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

