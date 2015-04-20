main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L12:
	li $a0, 10
	li $a1, 0
	jal initArray
	b L11
L11:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

