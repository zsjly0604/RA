main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L67:
	sw $a3, -4($fp)
	move $t6, $ra
	move $t5, $s0
	move $t4, $s1
	move $t3, $s2
	move $t2, $s3
	lw $a3, 0($fp)
	li $t0, 0
	la $t1, L65
	jal L62
	move $s3, $t2
	move $s2, $t3
	move $s1, $t4
	move $s0, $t5
	move $ra, $t6
	b L66
L66:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L61:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L69:
	sw $a3, -4($fp)
	move $t7, $ra
	move $t6, $s0
	move $t5, $s1
	move $t3, $s2
	move $t2, $s3
	lw $t4, 0($fp)
	lw $a3, 0($t4)
	lw $t0, -4($fp)
	la $t1, L63
	jal L62
	la $v0, L64
	move $s3, $t2
	move $s2, $t3
	move $s1, $t5
	move $s0, $t6
	move $ra, $t7
	b L68
L68:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L62:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L71:
	sw $t0, -4($fp)
	move $t6, $ra
	move $t5, $s0
	move $t4, $s1
	move $t3, $s2
	lw $t1, 0($fp)
	lw $t0, 0($t1)
	addi $a3, $t2, 1
	jal L61
	li $v0, 0
	move $s2, $t3
	move $s1, $t4
	move $s0, $t5
	move $ra, $t6
	b L70
L70:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

