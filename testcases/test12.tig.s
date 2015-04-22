main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L82:
	sw $a0, -4($fp)
	move $t7, $ra
	move $t6, $s0
	move $t5, $s1
	move $t4, $s2
	move $t3, $s3
	move $t2, $s4
	move $t1, $s5
	move $a2, $s6
	li $a0, 0
	li $a1, 0
	li $a3, 100
	ble $a1, $a3, L80
b L79
L79:
	li $v0, 0
	move $s6, $a2
	move $s5, $t1
	move $s4, $t2
	move $s3, $t3
	move $s2, $t4
	move $s1, $t5
	move $s0, $t6
	move $ra, $t7
	b L81
L80:
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	li $t0, 100
	blt $a1, $t0, L80
b L83
L83:
	b L79
L81:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

