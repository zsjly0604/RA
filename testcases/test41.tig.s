main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L133:
	sw $a0, -4($fp)
	move $t0, $ra
	move $a3, $s0
	move $a2, $s1
	move $a1, $s2
	move $a0, $s3
	li $v0, 0
	move $s3, $a0
	move $s2, $a1
	move $s1, $a2
	move $s0, $a3
	move $ra, $t0
	b L132
L132:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

