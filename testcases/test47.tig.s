main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L174:
	sw $a0, -4($fp)
	move $t2, $ra
	move $t1, $s0
	move $t0, $s1
	move $a2, $s2
	move $a1, $s3
	move $a0, $s4
	li $a3, 4
	li $v0, 0
	move $s4, $a0
	move $s3, $a1
	move $s2, $a2
	move $s1, $t0
	move $s0, $t1
	move $ra, $t2
	b L173
L173:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

