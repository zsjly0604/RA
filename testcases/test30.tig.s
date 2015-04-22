main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L125:
	sw $t2, -4($fp)
	move $a0, $ra
	move $t9, $s0
	move $t8, $s1
	move $t6, $s2
	move $t5, $s3
	move $t1, $s4
	move $t0, $s5
	li $t2, 10
	li $t3, 0
	jal initArray
	li $a2, 4
	li $a3, 2
	mul $t4, $a2, $a3
	add $t7, $v0, $t4
	lw $v0, 0($t7)
	move $s5, $t0
	move $s4, $t1
	move $s3, $t5
	move $s2, $t6
	move $s1, $t8
	move $s0, $t9
	move $ra, $a0
	b L124
L124:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

