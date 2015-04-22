main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L48:
	sw $t3, -4($fp)
	move $t6, $ra
	move $t5, $s0
	move $t4, $s1
	move $t2, $s2
	move $t1, $s3
	move $a2, $s4
	move $a1, $s5
	li $t3, 8
	jal allocRecord
	li $a3, 0
	sw $a3, 0($v0)
	li $t0, 0
	sw $t0, 4($v0)
	move $s5, $a1
	move $s4, $a2
	move $s3, $t1
	move $s2, $t2
	move $s1, $t4
	move $s0, $t5
	move $ra, $t6
	b L47
L47:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

