main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L43:
	sw $t0, -4($fp)
	move $t4, $ra
	move $t3, $s0
	move $t2, $s1
	move $a3, $s2
	move $a2, $s3
	lw $t0, 0($fp)
	li $t1, 10
	jal L38
	move $s3, $a2
	move $s2, $a3
	move $s1, $t2
	move $s0, $t3
	move $ra, $t4
	b L42
L42:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L38:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L45:
	sw $t2, -4($fp)
	move $a1, $ra
	move $a0, $s0
	move $t9, $s1
	move $t8, $s2
	move $t7, $s3
	move $t5, $s4
	move $t4, $s5
	move $t0, $s6
	move $a3, $s7
	li $v0, 1
	lw $t6, -4($fp)
	beqz $t6, L39
b L40
L40:
	lw $a2, -4($fp)
	move $t2, $fp
	lw $t3, -4($fp)
	addi $t1, $t3, -1
	jal L38
	mul $v0, $a2, $v0
L39:
	move $s7, $a3
	move $s6, $t0
	move $s5, $t4
	move $s4, $t5
	move $s3, $t7
	move $s2, $t8
	move $s1, $t9
	move $s0, $a0
	move $ra, $a1
	b L44
L44:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

