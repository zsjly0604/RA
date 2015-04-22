main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L77:
	sw $a0, -4($fp)
	move $t4, $ra
	move $t3, $s0
	move $t2, $s1
	move $t1, $s2
	move $t0, $s3
	move $a3, $s4
	move $a2, $s5
	li $v0, 30
	li $a0, 10
	li $a1, 20
	bgt $a0, $a1, L73
b L74
L74:
	li $v0, 40
L73:
	move $s5, $a2
	move $s4, $a3
	move $s3, $t0
	move $s2, $t1
	move $s1, $t2
	move $s0, $t3
	move $ra, $t4
	b L76
L76:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

