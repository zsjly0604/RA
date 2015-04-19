main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L82:
	li $a0, 8
	jal allocRecord
	li $a1, 0
	sw $a1, 0($v0)
	li $a2, 0
	sw $a2, 4($v0)
	b L81
L81:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

