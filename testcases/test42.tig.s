main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L151:
	sw $t0, -4($fp)
	sw $ra, -12($fp)
	sw $s0, -16($fp)
	sw $s1, -20($fp)
	sw $s2, -24($fp)
	sw $s3, -28($fp)
	sw $s4, -32($fp)
	move $t1, $s5
	move $s0, $s6
	move $a1, $s7
	li $t0, 10
	li $t4, 0
	jal initArray
	move $a2, $v0
	li $t0, 16
	jal allocRecord
	move $t4, $v0
	la $t2, L137
	sw $t2, 0($t4)
	la $t3, L138
	sw $t3, 4($t4)
	li $t5, 0
	sw $t5, 8($t4)
	li $t6, 0
	sw $t6, 12($t4)
	li $t0, 5
	jal initArray
	move $t1, $v0
	li $t0, 100
	la $t4, L140
	jal initArray
	move $t2, $v0
	li $t0, 16
	jal allocRecord
	la $t4, L143
	sw $t4, 0($v0)
	la $t7, L144
	sw $t7, 4($v0)
	li $t8, 2432
	sw $t8, 8($v0)
	li $t9, 44
	sw $t9, 12($v0)
	sw $v0, -8($fp)
	li $t0, 8
	jal allocRecord
	move $t3, $v0
	la $v0, L146
	sw $v0, 0($t3)
	addi $t0, $t3, 4
	move $a3, $t0
	li $t0, 3
	li $t4, 1900
	jal initArray
	sw $v0, 0($a3)
	li $t5, 1
	li $t6, 4
	li $t7, 0
	mul $s2, $t6, $t7
	add $s1, $a2, $s2
	sw $t5, 0($s1)
	li $t8, 3
	li $t9, 4
	li $a0, 9
	mul $s3, $t9, $a0
	add $ra, $a2, $s3
	sw $t8, 0($ra)
	la $a2, L147
	li $s4, 4
	li $s5, 3
	mul $s1, $s4, $s5
	add $a3, $t1, $s1
	lw $a0, 0($a3)
	sw $a2, 0($a0)
	li $a3, 23
	li $s6, 4
	li $s7, 1
	mul $s3, $s6, $s7
	add $s2, $t1, $s3
	lw $a2, 0($s2)
	sw $a3, 12($a2)
	la $s5, L148
	li $s7, 4
	li $t0, 34
	mul $s6, $s7, $t0
	add $s4, $t2, $s6
	sw $s5, 0($s4)
	la $t2, L149
	lw $s1, -8($fp)
	sw $t2, 0($s1)
	li $t6, 2323
	lw $t8, 4($t3)
	li $t7, 4
	li $t9, 0
	mul $t5, $t7, $t9
	add $t4, $t8, $t5
	sw $t6, 0($t4)
	li $ra, 2323
	lw $v0, 4($t3)
	li $a2, 4
	li $a3, 2
	mul $a0, $a2, $a3
	add $t3, $v0, $a0
	sw $ra, 0($t3)
	li $v0, 0
	move $s7, $a1
	move $s6, $s0
	move $s5, $t1
	lw $s4, -32($fp)
	lw $s3, -28($fp)
	lw $s2, -24($fp)
	lw $s1, -20($fp)
	lw $s0, -16($fp)
	lw $ra, -12($fp)
	b L150
L150:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

