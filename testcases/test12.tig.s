main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L116:
	li $a2, 0
	li $a3, 0
	li $a0, 100
	ble $a3, $a0, L114
b L113
L113:
	li $v0, 0
	b L115
L114:
	addi $a2, $a2, 1
	addi $a3, $a3, 1
	li $a1, 100
	blt $a3, $a1, L114
b L117
L117:
	b L113
L115:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

