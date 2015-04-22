main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-68
L290:
	sw $a0, -4($fp)
	move $t7, $ra
	move $t6, $s0
	move $t4, $s1
	move $t1, $s2
	move $t2, $s6
	move $t8, $s7
	li $a3, 8
	sw $a3, -40($fp)
	addi $a2, $fp, -44
	lw $a0, -40($fp)
	li $a2, 0
	jal initArray
	sw $v0, 0($a2)
	addi $a1, $fp, -48
	lw $a0, -40($fp)
	li $a2, 0
	jal initArray
	sw $v0, 0($a1)
	addi $a0, $fp, -52
	lw $s1, -40($fp)
	lw $s2, -40($fp)
	add $s0, $s1, $s2
	addi $a0, $s0, -1
	li $a2, 0
	jal initArray
	sw $v0, 0($a0)
	addi $t5, $fp, -56
	move $t9, $t5
	lw $a3, -40($fp)
	lw $t0, -40($fp)
	add $t3, $a3, $t0
	addi $a0, $t3, -1
	li $a2, 0
	jal initArray
	sw $v0, 0($t9)
	lw $a0, 13($fp)
	li $a2, 0
	jal L259
	li $v0, 0
	move $s7, $t8
	move $s6, $t2
	move $s2, $t1
	move $s1, $t4
	move $s0, $t6
	move $ra, $t7
	b L289
L289:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L259:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-56
L292:
	sw $a0, -4($fp)
	sw $ra, -8($fp)
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	sw $s4, -28($fp)
	sw $s5, -32($fp)
	sw $s6, -36($fp)
	sw $s7, -40($fp)
	lw $t1, 13($fp)
	lw $a0, 0($t1)
	jal L260
	lw $t2, -4($fp)
	lw $t4, 0($fp)
	lw $t3, -40($t4)
	beq $t2, $t3, L286
b L287
L287:
	li $s1, 0
	sw $s1, -44($fp)
	lw $t7, 0($fp)
	lw $t6, -40($t7)
	addi $t5, $t6, -1
	lw $s2, -44($fp)
	ble $s2, $t5, L285
b L272
L272:
	li $v0, 0
L286:
	lw $s7, -40($fp)
	lw $s6, -36($fp)
	lw $s5, -32($fp)
	lw $s4, -28($fp)
	lw $s3, -24($fp)
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	b L291
L285:
	li $a2, 1
	lw $a1, 0($fp)
	lw $a0, -56($a1)
	li $s0, 4
	lw $s3, -44($fp)
	addi $s2, $s3, 7
	lw $s3, -4($fp)
	sub $s1, $s2, $s3
	mul $a3, $s0, $s1
	add $t9, $a0, $a3
	lw $t8, 0($t9)
	beqz $t8, L281
b L282
L282:
	li $a2, 0
L281:
	li $t0, 1
	lw $s7, 0($fp)
	lw $s6, -52($s7)
	li $t2, 4
	lw $t4, -4($fp)
	lw $s4, -44($fp)
	add $t3, $s4, $t4
	mul $t1, $t2, $t3
	add $s5, $s6, $t1
	lw $s4, 0($s5)
	beqz $s4, L276
b L277
L277:
	li $t0, 0
L276:
	lw $t8, 0($fp)
	lw $t7, -44($t8)
	li $v0, 4
	lw $s5, -44($fp)
	mul $t9, $v0, $s5
	add $t6, $t7, $t9
	lw $t5, 0($t6)
	beqz $t5, L273
b L274
L274:
	li $t0, 0
L273:
	li $ra, 1
	beq $t0, $ra, L278
b L279
L279:
	li $a2, 0
L278:
	li $t0, 1
	beq $a2, $t0, L283
b L284
L284:
	lw $s6, -44($fp)
	addi $a3, $s6, 1
	sw $a3, -44($fp)
	lw $a1, 0($fp)
	lw $a0, -40($a1)
	addi $a2, $a0, -1
	lw $s7, -44($fp)
	blt $s7, $a2, L285
b L293
L293:
	b L272
L283:
	li $a2, 1
	lw $s1, 0($fp)
	lw $s0, -44($s1)
	li $s3, 4
	lw $t0, -44($fp)
	mul $s2, $s3, $t0
	add $a3, $s0, $s2
	sw $a2, 0($a3)
	li $t3, 1
	lw $s6, 0($fp)
	lw $s5, -52($s6)
	li $t0, 4
	lw $t2, -4($fp)
	lw $t1, -44($fp)
	add $t1, $t1, $t2
	mul $s7, $t0, $t1
	add $s4, $s5, $s7
	sw $t3, 0($s4)
	li $t9, 1
	lw $t5, 0($fp)
	lw $t4, -56($t5)
	li $t7, 4
	lw $t2, -44($fp)
	addi $v0, $t2, 7
	lw $ra, -4($fp)
	sub $t8, $v0, $ra
	mul $t6, $t7, $t8
	add $t3, $t4, $t6
	sw $t9, 0($t3)
	lw $a2, 0($fp)
	lw $a1, -48($a2)
	li $s0, 4
	lw $s1, -4($fp)
	mul $a3, $s0, $s1
	add $a0, $a1, $a3
	lw $t4, -44($fp)
	sw $t4, 0($a0)
	move $a0, $fp
	lw $s2, -4($fp)
	addi $a1, $s2, 1
	jal L259
	li $s3, 0
	lw $s6, 0($fp)
	lw $s5, -44($s6)
	li $t0, 4
	lw $t5, -44($fp)
	mul $s7, $t0, $t5
	add $s4, $s5, $s7
	sw $s3, 0($s4)
	li $t8, 0
	lw $t3, 0($fp)
	lw $t2, -52($t3)
	li $t5, 4
	lw $t7, -4($fp)
	lw $t6, -44($fp)
	add $t6, $t6, $t7
	mul $t4, $t5, $t6
	add $t1, $t2, $t4
	sw $t8, 0($t1)
	li $a2, 0
	lw $v0, 0($fp)
	lw $t9, -56($v0)
	li $a0, 4
	lw $t7, -44($fp)
	addi $a3, $t7, 7
	lw $s0, -4($fp)
	sub $a1, $a3, $s0
	mul $ra, $a0, $a1
	add $t8, $t9, $ra
	sw $a2, 0($t8)
	b L284
L291:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L260:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L295:
	sw $a0, -4($fp)
	li $a1, 0
	lw $t1, 0($fp)
	lw $t0, -40($t1)
	addi $a3, $t0, -1
	ble $a1, $a3, L270
b L261
L261:
	la $a0, L271
	jal print
	li $v0, 0
	b L294
L270:
	li $a2, 0
	lw $t4, 0($fp)
	lw $t3, -40($t4)
	addi $t2, $t3, -1
	ble $a2, $t2, L268
b L262
L262:
	la $a0, L269
	jal print
	addi $a1, $a1, 1
	lw $t7, 0($fp)
	lw $t6, -40($t7)
	addi $t5, $t6, -1
	blt $a1, $t5, L270
b L296
L296:
	b L261
L268:
	la $a0, L263
	lw $s0, 0($fp)
	lw $a3, -48($s0)
	li $s2, 4
	mul $s1, $s2, $a1
	add $t9, $a3, $s1
	lw $t8, 0($t9)
	beq $t8, $a2, L265
b L266
L266:
	la $a0, L264
L265:
	jal print
	addi $a2, $a2, 1
	lw $s4, 0($fp)
	lw $s3, -40($s4)
	addi $a0, $s3, -1
	blt $a2, $a0, L268
b L297
L297:
	b L262
L294:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

