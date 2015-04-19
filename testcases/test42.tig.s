main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L209:
	li $a0, 10
	li $a1, 0
	jal initArray
	li $a0, 16
	jal allocRecord
	move $a1, $v0
	la $a3, L195
	sw $a3, 0($a1)
	la $t0, L196
	sw $t0, 4($a1)
	li $t1, 0
	sw $t1, 8($a1)
	li $t2, 0
	sw $t2, 12($a1)
	li $a0, 5
	jal initArray
	li $a0, 100
	la $a1, L198
	jal initArray
	li $a0, 16
	jal allocRecord
	la $t3, L201
	sw $t3, 0($v0)
	la $t4, L202
	sw $t4, 4($v0)
	li $t5, 2432
	sw $t5, 8($v0)
	li $t6, 44
	sw $t6, 12($v0)
	li $a0, 8
	jal allocRecord
	la $t7, L204
	sw $t7, 0($v0)
	addi $a2, $v0, 4
	li $a0, 3
	li $a1, 1900
	jal initArray
	sw $v0, 0($a2)
	li $t8, 1
	li $a1, 4
	li $a2, 0
	mul $a0, $a1, $a2
	add $t9, $v0, $a0
	sw $t8, 0($t9)
	li $a3, 3
	li $s3, 4
	li $s4, 9
	mul $s2, $s3, $s4
	add $s0, $v0, $s2
	sw $a3, 0($s0)
	la $s5, L205
	li $t1, 4
	li $t2, 3
	mul $t0, $t1, $t2
	add $s7, $v0, $t0
	lw $s6, 0($s7)
	sw $s5, 0($s6)
	li $t3, 23
	li $t7, 4
	li $t8, 1
	mul $t6, $t7, $t8
	add $t5, $v0, $t6
	lw $t4, 0($t5)
	sw $t3, 12($t4)
	la $t9, L206
	li $fp, 4
	li $sp, 34
	mul $ra, $fp, $sp
	add $v0, $v0, $ra
	sw $t9, 0($v0)
	la $0, L207
	sw $0, 0($v0)
	li $v1, 2323
	lw $a1, 4($v0)
	li $a3, 4
	li $s0, 0
	mul $a2, $a3, $s0
	add $a0, $a1, $a2
	sw $v1, 0($a0)
	li $s2, 2323
	lw $s4, 4($v0)
	li $s6, 4
	li $s7, 2
	mul $s5, $s6, $s7
	add $s3, $s4, $s5
	sw $s2, 0($s3)
	li $v0, 0
	b L208
L208:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

