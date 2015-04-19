main:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-40
L158:
	lw $a0, 6($fp)
	li $a1, 0
	la $a2, L156
	jal L153
	b L157
L157:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L152:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L160:
	lw $a3, 6($fp)
	lw $a0, 0($a3)
	lw $a1, -4($fp)
	la $a2, L154
	jal L153
	la $v0, L155
	b L159
L159:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

L153:
	ws	$fp	0($sp)
	move	$fp	$sp
	addiu	$sp	$sp	-16
L162:
	lw $a3, 6($fp)
	lw $a0, 0($a3)
	addi $a1, $a2, 1
	jal L152
	li $v0, 0
	b L161
L161:
	tmove	$sp	$fp
	lw	$fp	0($sp)
	jr	$ra

