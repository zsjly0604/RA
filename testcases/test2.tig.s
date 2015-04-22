main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L6:
	sw $a2, -4($fp)
	li $a2, 10
	li $a3, 0
	jal initArray
	b L5
L5:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

