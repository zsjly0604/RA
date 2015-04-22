main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-48
L241:
	sw $a3, -4($fp)
	move $a0, $ra
	move $t6, $s0
	move $t5, $s1
	move $t4, $s2
	move $t3, $s3
	move $t7, $s6
	move $a1, $s7
	addi $a2, $fp, -36
	jal getchar
	sw $v0, 0($a2)
	lw $a3, 8($fp)
	jal L210
	move $t9, $v0
	addi $t2, $fp, -36
	jal getchar
	sw $v0, 0($t2)
	lw $a3, 8($fp)
	jal L210
	lw $t8, 8($fp)
	lw $a3, 8($fp)
	move $t0, $t9
	move $t1, $v0
	jal L209
	move $t0, $v0
	move $a3, $t8
	jal L207
	li $v0, 0
	move $s7, $a1
	move $s6, $t7
	move $s3, $t3
	move $s2, $t4
	move $s1, $t5
	move $s0, $t6
	move $ra, $a0
	b L240
L240:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L207:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L243:
	sw $a2, -4($fp)
	move $t6, $ra
	move $t3, $s0
	move $t4, $s5
	move $t8, $s6
	move $t7, $s7
	la $a2, L235
	jal print
	lw $t0, -4($fp)
	beqz $t0, L237
b L238
L238:
	lw $t5, 8($fp)
	lw $a2, 0($t5)
	lw $t1, -4($fp)
	lw $a3, 0($t1)
	jal L208
	la $a2, L236
	jal print
	move $a2, $fp
	lw $t2, -4($fp)
	lw $a3, 4($t2)
	jal L207
	li $v0, 0
L237:
	move $s7, $t7
	move $s6, $t8
	move $s5, $t4
	move $s0, $t3
	move $ra, $t6
	b L242
L242:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L208:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L245:
	sw $a2, -4($fp)
	move $t0, $s1
	move $t5, $s2
	move $t4, $s3
	move $t3, $s4
	move $t2, $s5
	la $a2, L227
	jal print
	lw $t6, 8($fp)
	lw $a2, 0($t6)
	li $t7, 0
	lw $t8, -4($fp)
	sub $a1, $t7, $t8
	jal L223
	li $v0, 0
	lw $a3, -4($fp)
	bltz $a3, L232
b L233
L233:
	lw $t9, 8($fp)
	lw $a2, 0($t9)
	lw $a1, -4($fp)
	jal L223
	lw $t1, -4($fp)
	bgtz $t1, L229
b L230
L230:
	la $a2, L228
	jal print
L229:
L232:
	move $s5, $t2
	move $s4, $t3
	move $s3, $t4
	move $s2, $t5
	move $s1, $t0
	b L244
L244:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L223:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-24
L247:
	sw $a2, -4($fp)
	sw $ra, -8($fp)
	sw $s0, -12($fp)
	move $s0, $s1
	move $a0, $s2
	move $t9, $s3
	move $t2, $s4
	move $t0, $s5
	lw $s1, -4($fp)
	bgtz $s1, L225
b L226
L226:
	li $v0, 0
	move $s5, $t0
	move $s4, $t2
	move $s3, $t9
	move $s2, $a0
	move $s1, $s0
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	b L246
L225:
	move $a2, $fp
	lw $t3, -4($fp)
	li $t4, 10
	div $a1, $t3, $t4
	jal L223
	lw $t1, -4($fp)
	lw $t6, -4($fp)
	li $t7, 10
	div $t5, $t6, $t7
	li $t8, 10
	mul $a2, $t5, $t8
	sub $a3, $t1, $a2
	la $a2, L224
	jal ord
	add $a2, $a3, $v0
	jal chr
	move $a2, $v0
	jal print
	b L226
L246:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L209:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-24
L249:
	sw $a0, -4($fp)
	move $t3, $t0
	move $a3, $ra
	sw $a3, -8($fp)
	sw $s0, -12($fp)
	move $ra, $s1
	move $t3, $s2
	move $a3, $s4
	move $a2, $s5
	move $t8, $s6
	move $t7, $s7
	lw $v0, -4($fp)
	beqz $t5, L220
b L221
L221:
	move $v0, $t5
	lw $s4, -4($fp)
	beqz $s4, L217
b L218
L218:
	li $a0, 8
	jal allocRecord
	lw $s6, 0($t5)
	sw $s6, 0($v0)
	addi $s5, $v0, 4
	move $a0, $fp
	lw $t0, 4($t5)
	lw $t2, -4($fp)
	jal L209
	sw $v0, 0($s5)
	lw $t9, 0($t5)
	lw $a1, -4($fp)
	lw $a0, 0($a1)
	blt $t9, $a0, L214
b L215
L215:
	li $a0, 8
	jal allocRecord
	move $t4, $v0
	lw $s2, -4($fp)
	lw $s1, 0($s2)
	sw $s1, 0($t4)
	addi $s0, $t4, 4
	move $t1, $s0
	move $a0, $fp
	move $t0, $t5
	lw $t6, -4($fp)
	lw $t2, 4($t6)
	jal L209
	sw $v0, 0($t1)
	move $v0, $t4
L214:
L217:
L220:
	move $s7, $t7
	move $s6, $t8
	move $s5, $a2
	move $s4, $a3
	move $s2, $t3
	move $s1, $ra
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	b L248
L248:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L210:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L251:
	sw $a3, -4($fp)
	move $t5, $ra
	move $t2, $s0
	move $t1, $s1
	move $s0, $s2
	move $a0, $s3
	move $t6, $s4
	move $t5, $s5
	move $t2, $s6
	move $t1, $s7
	li $a3, 4
	jal allocRecord
	li $t9, 0
	sw $t9, 0($v0)
	move $s1, $v0
	lw $a1, 8($fp)
	lw $a3, 0($a1)
	move $t8, $s1
	jal L183
	move $a2, $v0
	li $a3, 8
	jal allocRecord
	move $t7, $v0
	sw $a2, 0($t7)
	addi $t0, $t7, 4
	move $a3, $fp
	jal L210
	sw $v0, 0($t0)
	move $v0, $t7
	lw $t3, 0($s1)
	li $t4, 1
	beq $t3, $t4, L211
b L212
L212:
	li $v0, 0
L211:
	move $s7, $t1
	move $s6, $t2
	move $s5, $t5
	move $s4, $t6
	move $s3, $a0
	move $s2, $s0
	move $s1, $t1
	move $s0, $t2
	move $ra, $t5
	b L250
L250:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L183:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L253:
	sw $a0, -4($fp)
	move $t0, $ra
	move $a3, $s1
	move $a1, $s2
	move $t7, $s3
	move $t6, $s4
	move $t2, $s5
	move $t0, $s6
	move $a3, $s7
	li $a2, 0
	lw $s3, 8($fp)
	lw $a0, 0($s3)
	jal L184
	lw $s4, -4($fp)
	addi $s2, $s4, 0
	lw $s5, 8($fp)
	lw $a0, 0($s5)
	lw $s6, 0($fp)
	lw $t3, -36($s6)
	jal L185
	sw $v0, 0($s2)
L205:
	lw $t8, 8($fp)
	lw $a0, 0($t8)
	lw $t4, 0($fp)
	lw $t3, -36($t4)
	jal L185
	li $t5, 1
	beq $v0, $t5, L206
b L203
L203:
	move $v0, $a2
	move $s7, $a3
	move $s6, $t0
	move $s5, $t2
	move $s4, $t6
	move $s3, $t7
	move $s2, $a1
	move $s1, $a3
	move $ra, $t0
	b L252
L206:
	li $s7, 10
	mul $s1, $a2, $s7
	lw $t1, 0($fp)
	lw $a0, -36($t1)
	jal ord
	add $a2, $s1, $v0
	la $a0, L204
	jal ord
	sub $a0, $a2, $v0
	move $a2, $a0
	lw $t9, 0($fp)
	addi $t1, $t9, -36
	jal getchar
	sw $v0, 0($t1)
	b L205
L252:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L184:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-24
L255:
	sw $a0, -4($fp)
	sw $ra, -8($fp)
	sw $s0, -12($fp)
	move $s0, $s1
	move $t5, $s2
	move $t3, $s3
	move $a2, $s4
	move $a0, $s5
L201:
	li $a1, 1
	lw $t7, 0($fp)
	lw $t6, 0($t7)
	lw $a3, -36($t6)
	la $t0, L193
	beq $a3, $t0, L195
b L196
L196:
	li $a1, 1
	lw $t9, 0($fp)
	lw $t8, 0($t9)
	lw $t1, -36($t8)
	la $t2, L194
	beq $t1, $t2, L198
b L199
L199:
	li $a1, 0
L198:
L195:
	li $a3, 1
	beq $a1, $a3, L202
b L200
L200:
	li $v0, 0
	move $s5, $a0
	move $s4, $a2
	move $s3, $t3
	move $s2, $t5
	move $s1, $s0
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	b L254
L202:
	lw $s1, 0($fp)
	lw $a1, 0($s1)
	addi $t4, $a1, -36
	jal getchar
	sw $v0, 0($t4)
	b L201
L254:
		move	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

