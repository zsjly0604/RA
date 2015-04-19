main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L232:
	li $a0, 4
	li $v0, 0
	b L231
L231:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

