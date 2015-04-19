main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L188:
	li $a1, 0
	la $a0, L186
	li $v0, 0
	b L187
L187:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

