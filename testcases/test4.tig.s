main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L77:
	lw $a0, 7($fp)
	li $a1, 10
	jal L72
	b L76
L76:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L72:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L79:
	li $v0, 1
	lw $a3, -4($fp)
	beqz $a3, L73
b L74
L74:
	lw $a2, -4($fp)
	move $a0, $fp
	lw $t0, -4($fp)
	addi $a1, $t0, -1
	jal L72
	mul $v0, $a2, $v0
L73:
	b L78
L78:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

