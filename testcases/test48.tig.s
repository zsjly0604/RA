main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-52
L180:
	li $v0, 0
	b L179
L179:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L178:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L182:
	lw $v0, -4($fp)
	b L181
L181:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L177:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L184:
	lw $v0, -4($fp)
	b L183
L183:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

