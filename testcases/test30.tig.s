main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L183:
	li $a0, 10
	li $a1, 0
	jal initArray
	li $t0, 4
	li $t1, 2
	mul $a3, $t0, $t1
	add $a2, $v0, $a3
	lw $v0, 0($a2)
	b L182
L182:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

