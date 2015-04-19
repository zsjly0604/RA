main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L101:
	lw $a3, 7($fp)
	li $a1, 0
	la $a2, L99
	jal L96
	b L100
L100:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L95:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L103:
	lw $t0, 7($fp)
	lw $a3, 0($t0)
	lw $a1, -4($fp)
	la $a2, L97
	jal L96
	la $v0, L98
	b L102
L102:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L96:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L105:
	lw $a3, 7($fp)
	lw $a0, 0($a3)
	addi $a1, $a2, 1
	jal L95
	li $v0, 0
	b L104
L104:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

