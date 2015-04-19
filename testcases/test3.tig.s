main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L70:
	li $a0, 8
	jal allocRecord
	la $a1, L67
	sw $a1, 0($v0)
	li $a2, 1000
	sw $a2, 4($v0)
	la $a3, L68
	sw $a3, 0($v0)
	b L69
L69:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

