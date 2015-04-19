main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L168:
	li $v0, 30
	li $a0, 10
	li $a1, 20
	bgt $a0, $a1, L164
b L165
L165:
	li $v0, 40
L164:
	b L167
L167:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

