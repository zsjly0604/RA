main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L18:
	li $a0, 8
	jal allocRecord
	move $a1, $v0
	la $a2, L15
	sw $a2, 0($a1)
	li $a3, 1000
	sw $a3, 4($a1)
	la $t0, L16
	sw $t0, 0($a1)
	move $v0, $a1
	b L17
L17:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

