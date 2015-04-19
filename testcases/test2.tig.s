main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L64:
	li $a0, 10
	li $a1, 0
	jal initArray
	b L63
L63:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

