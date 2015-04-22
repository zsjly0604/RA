main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L154:
	sw $a0, -4($fp)
	move $a3, $ra
	move $a2, $s0
	move $a1, $s1
	li $a0, 0
	li $a0, 0
	li $v0, 0
	move $s1, $a1
	move $s0, $a2
	move $ra, $a3
	b L153
L153:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

