main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L131:
	li $a1, 0
	la $a0, L129
	li $v0, 0
	b L130
L130:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

