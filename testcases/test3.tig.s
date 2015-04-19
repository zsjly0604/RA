main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L127:
	li $a0, 8
	jal allocRecord
	la $a1, L124
	sw $a1, 0($v0)
	li $a2, 1000
	sw $a2, 4($v0)
	la $a3, L125
	sw $a3, 0($v0)
	b L126
L126:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

