main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L173:
	li $a1, 0
	li $a0, 0
	li $a2, 100
	ble $a0, $a2, L171
b L170
L170:
	li $v0, 0
	b L172
L171:
	addi $a1, $a1, 1
	addi $a0, $a0, 1
	li $a3, 100
	blt $a0, $a3, L171
b L174
L174:
	b L170
L172:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

