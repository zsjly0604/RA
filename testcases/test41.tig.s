main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L134:
	li $v0, 0
	b L133
L133:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

