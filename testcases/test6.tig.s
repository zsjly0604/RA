main:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-44
L89:
	lw $a3, 7($fp)
	li $a1, 0
	la $a2, L87
	jal L85
	b L88
L88:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L84:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L91:
	lw $t0, 7($fp)
	lw $a3, 0($t0)
	lw $a1, -4($fp)
	la $a2, L86
	jal L85
	b L90
L90:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L85:
	sw	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L93:
	lw $a3, 7($fp)
	lw $a0, 0($a3)
	addi $a1, $a2, 1
	jal L84
	b L92
L92:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

