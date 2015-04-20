main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L5:
	li $a2, 0
	li $a3, 0
	li $a0, 100
	ble $a3, $a0, L3
b L2
L2:
	li $v0, 0
	b L4
L3:
	addi $a2, $a2, 1
	addi $a3, $a3, 1
	li $a1, 100
	blt $a3, $a1, L3
b L6
L6:
	b L2
L4:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

