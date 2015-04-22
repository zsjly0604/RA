main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L130:
	sw $a0, -4($fp)
	move $t4, $ra
	move $t3, $s0
	move $t2, $s1
	move $a3, $s2
	move $a2, $s3
	move $a1, $s4
	move $a0, $s5
	li $t1, 0
	la $t0, L128
	li $v0, 0
	move $s5, $a0
	move $s4, $a1
	move $s3, $a2
	move $s2, $a3
	move $s1, $t2
	move $s0, $t3
	move $ra, $t4
	b L129
L129:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

