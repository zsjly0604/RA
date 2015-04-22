main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L36:
	sw $t4, -4($fp)
	move $t7, $ra
	move $t6, $s0
	move $t5, $s1
	move $t3, $s2
	move $t2, $s3
	move $a2, $s4
	move $a1, $s5
	li $t4, 8
	jal allocRecord
	la $a3, L33
	sw $a3, 0($v0)
	li $t0, 1000
	sw $t0, 4($v0)
	la $t1, L34
	sw $t1, 0($v0)
	move $s5, $a1
	move $s4, $a2
	move $s3, $t2
	move $s2, $t3
	move $s1, $t5
	move $s0, $t6
	move $ra, $t7
	b L35
L35:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

