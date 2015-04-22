main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L10:
	sw $a2, -4($fp)
	li $t0, 0
	lw $a2, 0($fp)
	li $a3, 2
	jal L8
	b L9
L9:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

