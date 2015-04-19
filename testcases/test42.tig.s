main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-52
L152:
	li $a0, 10
	li $a1, 0
	jal initArray
	move $s0, $v0
	li $a0, 16
	jal allocRecord
	move $a1, $v0
	la $s4, L138
	sw $s4, 0($a1)
	la $s5, L139
	sw $s5, 4($a1)
	li $s6, 0
	sw $s6, 8($a1)
	li $s7, 0
	sw $s7, 12($a1)
	li $a0, 5
	jal initArray
	move $s2, $v0
	li $a0, 100
	la $a1, L141
	jal initArray
	move $s3, $v0
	li $a0, 16
	jal allocRecord
	la $t3, L144
	sw $t3, 0($v0)
	la $t4, L145
	sw $t4, 4($v0)
	li $t5, 2432
	sw $t5, 8($v0)
	li $t6, 44
	sw $t6, 12($v0)
	sw $v0, -36($fp)
	li $a0, 8
	jal allocRecord
	move $a3, $v0
	la $t7, L147
	sw $t7, 0($a3)
	addi $t1, $a3, 4
	move $ra, $t1
	li $a0, 3
	li $a1, 1900
	jal initArray
	sw $v0, 0($ra)
	move $t2, $a3
	sw $t2, -40($fp)
	li $a2, 1
	li $t3, 4
	li $t9, 0
	mul $a1, $t3, $t9
	add $a0, $s0, $a1
	sw $a2, 0($a0)
	li $t8, 3
	li $t4, 4
	li $a0, 9
	mul $t6, $t4, $a0
	add $t9, $s0, $t6
	sw $t8, 0($t9)
	la $t7, L148
	li $t5, 4
	li $t6, 3
	mul $a0, $t5, $t6
	add $v0, $s2, $a0
	lw $t8, 0($v0)
	sw $t7, 0($t8)
	li $t0, 23
	li $t7, 4
	li $t8, 1
	mul $a1, $t7, $t8
	add $a3, $s2, $a1
	lw $a2, 0($a3)
	sw $t0, 12($a2)
	la $t5, L149
	li $t2, 4
	li $t4, 34
	mul $t0, $t2, $t4
	add $a2, $s3, $t0
	sw $t5, 0($a2)
	la $a3, L150
	lw $t2, -36($fp)
	sw $a3, 0($t2)
	li $t9, 2323
	lw $t3, -40($fp)
	lw $a3, 4($t3)
	li $a1, 4
	li $a2, 0
	mul $t1, $a1, $a2
	add $t0, $a3, $t1
	sw $t9, 0($t0)
	li $v0, 2323
	lw $t4, -40($fp)
	lw $t3, 4($t4)
	li $t0, 4
	li $t1, 2
	mul $t2, $t0, $t1
	add $t1, $t3, $t2
	sw $v0, 0($t1)
	li $v0, 0
	b L151
L151:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

