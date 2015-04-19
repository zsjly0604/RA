main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L28:
	li $v0, 0
	b L27
L27:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L26:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L30:
	lw $v0, -4($fp)
	b L29
L29:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L25:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L32:
	lw $v0, -4($fp)
	b L31
L31:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

