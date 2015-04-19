main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-76
L284:
	addi $t4, $fp, -64
	jal getchar
	sw $t1, 0($t4)
	lw $a0, 15($fp)
	jal L253
	move $t0, $t1
	addi $t3, $fp, -64
	jal getchar
	sw $t1, 0($t3)
	lw $a0, 15($fp)
	jal L253
	lw $t2, 15($fp)
	lw $a0, 15($fp)
	move $a2, $t1
	jal L252
	move $t0, $t1
	move $a0, $t2
	jal L250
	li $t1, 0
	b L283
L283:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L250:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L286:
	la $a2, L278
	jal print
	lw $a3, -4($fp)
	beqz $a3, L280
b L281
L281:
	lw $t0, 15($fp)
	lw $a2, 0($t0)
	lw $t1, -4($fp)
	lw $a1, 0($t1)
	jal L251
	la $a2, L279
	jal print
	move $a2, $fp
	lw $t2, -4($fp)
	lw $a1, 4($t2)
	jal L250
	li $v0, 0
L280:
	b L285
L285:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L251:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L288:
	la $a2, L270
	jal print
	lw $a3, 15($fp)
	lw $a2, 0($a3)
	li $t0, 0
	lw $t1, -4($fp)
	sub $a1, $t0, $t1
	jal L266
	li $v0, 0
	lw $t2, -4($fp)
	bltz $t2, L275
b L276
L276:
	lw $t3, 15($fp)
	lw $a2, 0($t3)
	lw $a1, -4($fp)
	jal L266
	lw $t4, -4($fp)
	bgtz $t4, L272
b L273
L273:
	la $a2, L271
	jal print
L272:
L275:
	b L287
L287:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L266:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L290:
	lw $a1, -4($t0)
	bgtz $a1, L268
b L269
L269:
	li $v0, 0
	b L289
L268:
	move $a2, $t0
	lw $a3, -4($t0)
	li $s0, 10
	div $a1, $a3, $s0
	jal L266
	lw $s2, -4($t0)
	lw $s4, -4($t0)
	li $s5, 10
	div $s3, $s4, $s5
	li $s6, 10
	mul $a2, $s3, $s6
	sub $a3, $s2, $a2
	la $a2, L267
	jal ord
	add $a2, $a3, $v0
	jal chr
	move $a2, $v0
	jal print
	b L269
L289:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L252:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L292:
	lw $a3, -4($t1)
	beqz $a3, L263
b L264
L264:
	lw $t2, -4($t1)
	beqz $t2, L260
b L261
L261:
	li $t8, 8
	jal allocRecord
	lw $t3, 0($a3)
	sw $t3, 0($a3)
	addi $s5, $a3, 4
	move $t8, $t1
	lw $t0, 4($a3)
	lw $a2, -4($t1)
	jal L252
	sw $a3, 0($s5)
	lw $s6, 0($a3)
	lw $t0, -4($t1)
	lw $s7, 0($t0)
	blt $s6, $s7, L257
b L258
L258:
	li $t8, 8
	jal allocRecord
	move $t2, $a3
	lw $t8, -4($t1)
	lw $t7, 0($t8)
	sw $t7, 0($t2)
	addi $s4, $t2, 4
	move $t7, $s4
	move $t8, $t1
	move $t0, $a3
	lw $a3, -4($t1)
	lw $a2, 4($a3)
	jal L252
	sw $a3, 0($t7)
	move $a3, $t2
L257:
L260:
L263:
	b L291
L291:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L253:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L294:
	li $a0, 4
	jal allocRecord
	li $a1, 0
	sw $a1, 0($t0)
	move $a1, $t0
	lw $a3, 15($t3)
	lw $a0, 0($a3)
	jal L226
	move $a2, $t0
	li $a0, 8
	jal allocRecord
	move $t2, $t0
	sw $a2, 0($t2)
	addi $t1, $t2, 4
	move $a0, $t3
	jal L253
	sw $t0, 0($t1)
	move $t0, $t2
	lw $a2, 0($a1)
	li $a3, 1
	beq $a2, $a3, L254
b L255
L255:
	li $t0, 0
L254:
	b L293
L293:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L226:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L296:
	li $t1, 0
	lw $s4, 15($fp)
	lw $t9, 0($s4)
	jal L227
	lw $s5, -4($fp)
	addi $a3, $s5, 0
	lw $s6, 15($fp)
	lw $t9, 0($s6)
	lw $s7, 0($fp)
	lw $a1, -64($s7)
	jal L228
	sw $t2, 0($a3)
L248:
	lw $t0, 15($fp)
	lw $t9, 0($t0)
	lw $t2, 0($fp)
	lw $a1, -64($t2)
	jal L228
	li $a2, 1
	beq $t2, $a2, L249
b L246
L246:
	move $t2, $t1
	b L295
L249:
	li $t3, 10
	mul $a2, $t1, $t3
	lw $t1, 0($fp)
	lw $t9, -64($t1)
	jal ord
	add $a3, $a2, $t2
	la $t9, L247
	jal ord
	sub $t1, $a3, $t2
	lw $t9, 0($fp)
	addi $a1, $t9, -64
	jal getchar
	sw $t2, 0($a1)
	b L248
L295:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L227:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L244:
	li $t1, 1
	lw $a0, 0($t3)
	lw $t2, 0($a0)
	lw $a0, -64($t2)
	la $a2, L236
	beq $a0, $a2, L238
b L239
L239:
	li $t1, 1
	lw $a2, 0($t3)
	lw $a1, 0($a2)
	lw $a1, -64($a1)
	la $a3, L237
	beq $a1, $a3, L241
b L242
L242:
	li $t1, 0
L241:
L238:
	li $a3, 1
	beq $t1, $a3, L245
b L243
L243:
	li $v0, 0
	b L297
L245:
	lw $s6, 0($t3)
	lw $s5, 0($s6)
	addi $t0, $s5, -64
	jal getchar
	sw $v0, 0($t0)
	b L244
L297:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L228:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L299:
	li $a2, 1
	lw $t0, 0($fp)
	lw $a3, 0($t0)
	lw $a0, -64($a3)
	jal ord
	la $a0, L230
	jal ord
	ble $v0, $v0, L234
b L235
L235:
	li $a2, 0
L234:
	lw $t2, 0($fp)
	lw $t1, 0($t2)
	lw $a0, -64($t1)
	jal ord
	move $a1, $v0
	la $a0, L229
	jal ord
	bge $a1, $v0, L231
b L232
L232:
	li $a2, 0
L231:
	move $v0, $a2
	b L298
L298:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

