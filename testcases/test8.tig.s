main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L111:
	li $a0, 30
	li $a2, 10
	li $a3, 20
	bgt $a2, $a3, L107
b L108
L108:
	li $a0, 40
L107:
	move $a1, $a0
	b L110
L110:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

