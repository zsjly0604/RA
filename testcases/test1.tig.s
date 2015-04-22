main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L15:
	sw $a2, -4($fp)
	li $a2, 10
	li $a3, 1
	jal initArray
	b L14
L14:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

