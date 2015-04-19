main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-72
L217:
	li $t3, 8
	sw $t3, -44($a3)
	addi $t2, $a3, -48
	lw $a0, -44($a3)
	li $a1, 0
	jal initArray
	sw $v0, 0($t2)
	addi $t1, $a3, -52
	lw $a0, -44($a3)
	li $a1, 0
	jal initArray
	sw $v0, 0($t1)
	addi $t0, $a3, -56
	lw $t5, -44($a3)
	lw $t6, -44($a3)
	add $t4, $t5, $t6
	addi $a0, $t4, -1
	li $a1, 0
	jal initArray
	sw $v0, 0($t0)
	addi $a2, $a3, -60
	lw $t8, -44($a3)
	lw $t9, -44($a3)
	add $t7, $t8, $t9
	addi $a0, $t7, -1
	li $a1, 0
	jal initArray
	sw $v0, 0($a2)
	lw $a0, 14($a3)
	li $a1, 0
	jal L186
	li $v0, 0
	b L216
L216:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L186:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-24
L219:
	lw $ra, 14($fp)
	lw $a0, 0($ra)
	jal L187
	move $a2, $a3
	lw $t8, -4($fp)
	lw $t4, 0($fp)
	lw $t3, -44($t4)
	beq $t8, $t3, L213
b L214
L214:
	li $t8, 0
	sw $t8, -8($fp)
	lw $t4, 0($fp)
	lw $t3, -44($t4)
	addi $t2, $t3, -1
	lw $t9, -8($fp)
	ble $t9, $t2, L212
b L199
L199:
	li $a2, 0
L213:
	move $a3, $a2
	b L218
L212:
	li $a3, 1
	lw $t7, 0($fp)
	lw $t7, -60($t7)
	li $t4, 4
	lw $t6, -8($fp)
	addi $t0, $t6, 7
	lw $t1, -4($fp)
	sub $t5, $t0, $t1
	mul $t5, $t4, $t5
	add $t6, $t7, $t5
	lw $t5, 0($t6)
	beqz $t5, L208
b L209
L209:
	li $a3, 0
L208:
	move $t0, $a3
	sw $t0, -12($fp)
	li $t9, 1
	lw $a0, 0($fp)
	lw $a3, -56($a0)
	li $v0, 4
	lw $t4, -4($fp)
	lw $t5, -8($fp)
	add $a2, $t5, $t4
	mul $t6, $v0, $a2
	add $v0, $a3, $t6
	lw $t8, 0($v0)
	beqz $t8, L203
b L204
L204:
	li $t9, 0
L203:
	move $t3, $t9
	lw $a2, 0($fp)
	lw $a2, -48($a2)
	li $a0, 4
	lw $a1, -8($fp)
	mul $t7, $a0, $a1
	add $a1, $a2, $t7
	lw $t9, 0($a1)
	beqz $t9, L200
b L201
L201:
	li $t3, 0
L200:
	li $a3, 1
	beq $t3, $a3, L205
b L206
L206:
	li $a1, 0
	sw $a1, -12($fp)
L205:
	li $t0, 1
	lw $a2, -12($fp)
	beq $a2, $t0, L210
b L211
L211:
	lw $v0, -8($fp)
	addi $t1, $v0, 1
	sw $t1, -8($fp)
	lw $t3, 0($fp)
	lw $t2, -44($t3)
	addi $t1, $t2, -1
	lw $a0, -8($fp)
	blt $a0, $t1, L212
b L220
L220:
	b L199
L210:
	li $a3, 1
	lw $t4, 0($fp)
	lw $ra, -48($t4)
	li $a2, 4
	lw $a1, -8($fp)
	mul $t5, $a2, $a1
	add $ra, $ra, $t5
	sw $a3, 0($ra)
	li $t0, 1
	lw $t7, 0($fp)
	lw $t8, -56($t7)
	li $t5, 4
	lw $t6, -4($fp)
	lw $t7, -8($fp)
	add $a3, $t7, $t6
	mul $t9, $t5, $a3
	add $t6, $t8, $t9
	sw $t0, 0($t6)
	li $t4, 1
	lw $v0, 0($fp)
	lw $a0, -60($v0)
	li $t9, 4
	lw $t2, -8($fp)
	addi $v0, $t2, 7
	lw $ra, -4($fp)
	sub $t0, $v0, $ra
	mul $ra, $t9, $t0
	add $t8, $a0, $ra
	sw $t4, 0($t8)
	lw $a1, 0($fp)
	lw $t1, -52($a1)
	li $a3, 4
	lw $t0, -4($fp)
	mul $a2, $a3, $t0
	add $a0, $t1, $a2
	lw $ra, -8($fp)
	sw $ra, 0($a0)
	move $a0, $fp
	lw $t1, -4($fp)
	addi $a1, $t1, 1
	jal L186
	li $a1, 0
	lw $t3, 0($fp)
	lw $t2, -48($t3)
	li $t0, 4
	lw $t1, -8($fp)
	mul $t8, $t0, $t1
	add $t2, $t2, $t8
	sw $a1, 0($t2)
	li $a0, 0
	lw $t5, 0($fp)
	lw $t2, -56($t5)
	li $t3, 4
	lw $t6, -4($fp)
	lw $t7, -8($fp)
	add $t1, $t7, $t6
	mul $t9, $t3, $t1
	add $t4, $t2, $t9
	sw $a0, 0($t4)
	li $a2, 0
	lw $t7, 0($fp)
	lw $a1, -60($t7)
	li $t9, 4
	lw $v0, -8($fp)
	addi $t2, $v0, 7
	lw $t3, -4($fp)
	sub $t8, $t2, $t3
	mul $a0, $t9, $t8
	add $t6, $a1, $a0
	sw $a2, 0($t6)
	b L211
L218:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L187:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L222:
	li $a1, 0
	lw $t1, 0($fp)
	lw $t0, -44($t1)
	addi $a3, $t0, -1
	ble $a1, $a3, L197
b L188
L188:
	la $a0, L198
	jal print
	li $v0, 0
	b L221
L197:
	li $a2, 0
	lw $t4, 0($fp)
	lw $t3, -44($t4)
	addi $t2, $t3, -1
	ble $a2, $t2, L195
b L189
L189:
	la $a0, L196
	jal print
	addi $a1, $a1, 1
	lw $t7, 0($fp)
	lw $t6, -44($t7)
	addi $t5, $t6, -1
	blt $a1, $t5, L197
b L223
L223:
	b L188
L195:
	la $a0, L190
	lw $s0, 0($fp)
	lw $a3, -52($s0)
	li $s3, 4
	mul $s2, $s3, $a1
	add $t9, $a3, $s2
	lw $t8, 0($t9)
	beq $t8, $a2, L192
b L193
L193:
	la $a0, L191
L192:
	jal print
	addi $a2, $a2, 1
	lw $s5, 0($fp)
	lw $s4, -44($s5)
	addi $a0, $s4, -1
	blt $a2, $a0, L195
b L224
L224:
	b L189
L221:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

