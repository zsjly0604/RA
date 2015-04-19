main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L121:
	li $a0, 10
	li $a1, 0
	jal initArray
	b L120
L120:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

