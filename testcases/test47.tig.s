main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-52
L175:
	li $a0, 4
	li $v0, 0
	b L174
L174:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

