main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L25:
	lw $a0, 0($fp)
	li $a1, 10
	jal L20
	b L24
L24:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L20:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L27:
	li $a2, 1
	lw $t0, -4($fp)
	beqz $t0, L21
b L22
L22:
	lw $t1, -4($fp)
	move $a0, $fp
	lw $a3, -4($fp)
	addi $a1, $a3, -1
	jal L20
	mul $a2, $t1, $v0
L21:
	move $v0, $a2
	b L26
L26:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

