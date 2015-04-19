main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L61:
	li $a0, 10
	li $a1, 1
	jal initArray
	b L60
L60:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

