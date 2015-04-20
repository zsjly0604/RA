main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L9:
	li $a0, 10
	li $a1, 1
	jal initArray
	b L8
L8:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

