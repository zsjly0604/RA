main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L121:
	li $a2, 0
	lw $a0, 7($fp)
	li $a1, 2
	jal L119
	b L120
L120:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L119:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L123:
	lw $v0, -4($fp)
	b L122
L122:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

