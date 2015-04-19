main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-52
L155:
	li $a0, 0
	li $a0, 0
	li $v0, 0
	b L154
L154:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

