main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L55:
	sw $a3, -4($fp)
	move $t6, $ra
	move $t5, $s0
	move $t4, $s1
	move $t3, $s2
	move $t2, $s3
	lw $a3, 0($fp)
	li $t0, 0
	la $t1, L53
	jal L51
	move $s3, $t2
	move $s2, $t3
	move $s1, $t4
	move $s0, $t5
	move $ra, $t6
	b L54
L54:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L50:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L57:
	sw $a3, -4($fp)
	move $t7, $ra
	move $t6, $s0
	move $t5, $s1
	move $t3, $s2
	move $t2, $s3
	lw $t4, 0($fp)
	lw $a3, 0($t4)
	lw $t0, -4($fp)
	la $t1, L52
	jal L51
	move $s3, $t2
	move $s2, $t3
	move $s1, $t5
	move $s0, $t6
	move $ra, $t7
	b L56
L56:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L51:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L59:
	sw $t0, -4($fp)
	move $t6, $ra
	move $t5, $s0
	move $t4, $s1
	move $t3, $s2
	lw $t1, 0($fp)
	lw $t0, 0($t1)
	addi $a3, $t2, 1
	jal L50
	move $s2, $t3
	move $s1, $t4
	move $s0, $t5
	move $ra, $t6
	b L58
L58:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

