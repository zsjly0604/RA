main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L126:
	li $a0, 10
	li $a1, 0
	jal initArray
	move $t0, $t1
	li $a2, 4
	li $a3, 2
	mul $t3, $a2, $a3
	add $t2, $t0, $t3
	lw $t1, 0($t2)
	b L125
L125:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

