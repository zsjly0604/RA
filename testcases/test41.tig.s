main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L3:
	li $v0, 0
	b L2
L2:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

