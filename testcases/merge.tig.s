
	#.file	1 "runtime.c"
	.option pic2
	.text
	.align 4
	.globl	tig_initArray
	.ent	tig_initArray
tig_initArray:
.LFB1:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI0:
	sd	$ra,48($sp)
.LCFI1:
	sd	$fp,40($sp)
.LCFI2:
.LCFI3:
	move	$fp,$sp
.LCFI4:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	move	$v1,$v0
	sll	$v0,$v1,2
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,16($fp)
	sw	$v1,0($v0)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
.L3:
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	lw	$v1,24($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,.L6
	b	.L4
.L6:
	lw	$v0,24($fp)
	move	$v1,$v0
	sll	$v0,$v1,2
	lw	$v1,28($fp)
	addu	$v0,$v0,$v1
	lw	$v1,20($fp)
	sw	$v1,0($v0)
.L5:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L3
.L4:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L2
.L2:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE1:
	.end	tig_initArray
	.align 4
	.globl	tig_allocRecord
	.ent	tig_allocRecord
tig_allocRecord:
.LFB2:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI5:
	sd	$ra,48($sp)
.LCFI6:
	sd	$fp,40($sp)
.LCFI7:
.LCFI8:
	move	$fp,$sp
.LCFI9:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$a0,16($fp)
	la	$t9,malloc
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	sw	$v0,28($fp)
	sw	$v0,24($fp)
	sw	$zero,20($fp)
.L8:
	lw	$v0,20($fp)
	lw	$v1,16($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L11
	b	.L9
.L11:
	addu	$v0,$fp,24
	lw	$v1,0($v0)
	sw	$zero,0($v1)
	addu	$v1,$v1,4
	sw	$v1,0($v0)
.L10:
	lw	$v0,20($fp)
	addu	$v1,$v0,4
	sw	$v1,20($fp)
	b	.L8
.L9:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L7
.L7:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE2:
	.end	tig_allocRecord
	.align 4
	.globl	tig_stringEqual
	.ent	tig_stringEqual
tig_stringEqual:
.LFB3:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI10:
	sd	$fp,40($sp)
.LCFI11:
.LCFI12:
	move	$fp,$sp
.LCFI13:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	bne	$v0,$v1,.L13
	li	$v0,1			# 0x1
	b	.L12
.L13:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	beq	$v0,$v1,.L14
	move	$v0,$zero
	b	.L12
.L14:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L15:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L18
	b	.L16
.L18:
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v0,0($v0)
	lbu	$v1,0($a0)
	beq	$v0,$v1,.L17
	move	$v0,$zero
	b	.L12
.L19:
.L17:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L15
.L16:
	li	$v0,1			# 0x1
	b	.L12
.L12:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE3:
	.end	tig_stringEqual
	.align 4
	.globl	tig_print
	.ent	tig_print
tig_print:
.LFB4:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI14:
	sd	$ra,48($sp)
.LCFI15:
	sd	$fp,40($sp)
.LCFI16:
.LCFI17:
	move	$fp,$sp
.LCFI18:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	sw	$v1,24($fp)
	sw	$zero,20($fp)
.L21:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L24
	b	.L22
.L24:
	lw	$v0,24($fp)
	lbu	$v1,0($v0)
	move	$a0,$v1
	la	$t9,putchar
	jal	$ra,$t9
.L23:
	lw	$v0,20($fp)
	addu	$v1,$v0,1
	sw	$v1,20($fp)
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L21
.L22:
.L20:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE4:
	.end	tig_print
	.globl	consts
	.data
	.align 4
consts:
	.word	0

	.byte	0x0
	.space	3
	.space	2040
	.globl	empty
	.align 4
empty:
	.word	0

	.byte	0x0
	.space	3
	.text
	.align 4
	.globl	main
	.ent	main
main:
.LFB5:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI19:
	sd	$ra,48($sp)
.LCFI20:
	sd	$fp,40($sp)
.LCFI21:
.LCFI22:
	move	$fp,$sp
.LCFI23:
	.set	noat
	.set	at
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,16($fp)
.L26:
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	bne	$v1,$zero,.L29
	b	.L27
.L29:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v1,$v0
	li	$v1,1			# 0x1
	sw	$v1,0($v0)
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v0,$v1
	lbu	$v1,16($fp)
	sb	$v1,4($v0)
.L28:
	lw	$v0,16($fp)
	addu	$v1,$v0,1
	sw	$v1,16($fp)
	b	.L26
.L27:
	move	$a0,$zero
	la	$t9,tig_main
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L25
.L25:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE5:
	.end	main
	.align 4
	.globl	tig_ord
	.ent	tig_ord
tig_ord:
.LFB6:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI24:
	sd	$fp,40($sp)
.LCFI25:
.LCFI26:
	move	$fp,$sp
.LCFI27:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L31
	li	$v0,-1			# 0xffffffff
	b	.L30
	b	.L32
.L31:
	lw	$v0,16($fp)
	lbu	$v1,4($v0)
	move	$v0,$v1
	b	.L30
.L32:
.L30:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE6:
	.end	tig_ord
	.align 4
	.globl	tig_chr
	.ent	tig_chr
tig_chr:
.LFB7:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI28:
	sd	$ra,48($sp)
.LCFI29:
	sd	$fp,40($sp)
.LCFI30:
.LCFI31:
	move	$fp,$sp
.LCFI32:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	bltz	$v0,.L35
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	beq	$v1,$zero,.L35
	b	.L34
.L35:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L34:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L33
.L33:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE7:
	.end	tig_chr
	.align 4
	.globl	tig_size
	.ent	tig_size
tig_size:
.LFB8:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI33:
	sd	$fp,40($sp)
.LCFI34:
.LCFI35:
	move	$fp,$sp
.LCFI36:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	move	$v0,$v1
	b	.L36
.L36:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE8:
	.end	tig_size
.data
	.align 4
.LC0:

	.byte	0x73,0x75,0x62,0x73,0x74,0x72,0x69,0x6e
	.byte	0x67,0x28,0x5b,0x25,0x64,0x5d,0x2c,0x25
	.byte	0x64,0x2c,0x25,0x64,0x29,0x20,0x6f,0x75
	.byte	0x74,0x20,0x6f,0x66,0x20,0x72,0x61,0x6e
	.byte	0x67,0x65,0xa,0x0
	.text
	.align 4
	.globl	tig_substring
	.ent	tig_substring
tig_substring:
.LFB9:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI37:
	sd	$ra,64($sp)
.LCFI38:
	sd	$fp,56($sp)
.LCFI39:
.LCFI40:
	move	$fp,$sp
.LCFI41:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	sw	$a2,24($fp)
	lw	$v0,20($fp)
	bltz	$v0,.L39
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	addu	$v0,$v0,$v1
	lw	$v1,16($fp)
	lw	$a0,0($v1)
	slt	$v0,$a0,$v0
	bne	$v0,$zero,.L39
	b	.L38
.L39:
	lw	$v0,16($fp)
	la	$a0,.LC0
	lw	$a1,0($v0)
	lw	$a2,20($fp)
	lw	$a3,24($fp)
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L38:
	lw	$v0,24($fp)
	li	$v1,1			# 0x1
	bne	$v0,$v1,.L40
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$v0,20($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,0($v1)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L37
.L40:
	lw	$v1,24($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	sw	$v1,0($v0)
	sw	$zero,32($fp)
.L41:
	lw	$v0,32($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L44
	b	.L42
.L44:
	lw	$v0,28($fp)
	addu	$v1,$v0,4
	lw	$a0,32($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	lw	$a0,20($fp)
	lw	$a1,32($fp)
	addu	$a0,$a0,$a1
	addu	$v1,$v1,4
	addu	$a0,$v1,$a0
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L43:
	lw	$v0,32($fp)
	addu	$v1,$v0,1
	sw	$v1,32($fp)
	b	.L41
.L42:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L37
.L37:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE9:
	.end	tig_substring
	.align 4
	.globl	tig_concat
	.ent	tig_concat
tig_concat:
.LFB10:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI42:
	sd	$ra,64($sp)
.LCFI43:
	sd	$fp,56($sp)
.LCFI44:
.LCFI45:
	move	$fp,$sp
.LCFI46:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L46
	lw	$v1,20($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L46:
	lw	$v0,20($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L48
	lw	$v1,16($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L48:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	addu	$v0,$v0,$v1
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	lw	$v1,28($fp)
	sw	$v1,0($v0)
	sw	$zero,24($fp)
.L50:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L53
	b	.L51
.L53:
	lw	$v0,32($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L52:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L50
.L51:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L54:
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L57
	b	.L55
.L57:
	lw	$v0,32($fp)
	lw	$v1,16($fp)
	lw	$a0,24($fp)
	lw	$a1,0($v1)
	addu	$v1,$a0,$a1
	addu	$a0,$v0,4
	addu	$v0,$a0,$v1
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L56:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L54
.L55:
	lw	$v1,32($fp)
	move	$v0,$v1
	b	.L45
.L49:
.L47:
.L45:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE10:
	.end	tig_concat
	.align 4
	.globl	tig_not
	.ent	tig_not
tig_not:
.LFB11:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI47:
	sd	$fp,40($sp)
.LCFI48:
.LCFI49:
	move	$fp,$sp
.LCFI50:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	xori	$a0,$v0,0x0
	sltu	$v1,$a0,1
	move	$v0,$v1
	b	.L58
.L58:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE11:
	.end	tig_not
	.align 4
	.globl	tig_getchar
	.ent	tig_getchar
tig_getchar:
.LFB12:
	.frame	$fp,48,$ra		# vars= 0, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI51:
	sd	$ra,32($sp)
.LCFI52:
	sd	$fp,24($sp)
.LCFI53:
.LCFI54:
	move	$fp,$sp
.LCFI55:
	.set	noat
	.set	at
	la	$t9,getchar
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,tig_chr
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L59
.L59:
	move	$sp,$fp
	ld	$ra,32($sp)
	ld	$fp,24($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE12:
	.end	tig_getchar
tig_flush:
  j $ra
  .end tig_flush
tig_exit:
  j exit
  .end tig_exit
# system calls for Tiger, when running on SPIM
#
# $Id: sysspim.s,v 1.1 2002/08/25 05:06:41 shivers Exp $

	.globl malloc
	.ent malloc
	.text
malloc:
	# round up the requested amount to a multiple of 4
	add $a0, $a0, 3
	srl $a0, $a0, 2
	sll $a0, $a0, 2

	# allocate the memory with sbrk()
	li $v0, 9
	syscall
	
	j $ra

	.end malloc

	

	.data
	.align 4
getchar_buf:	.byte 0,0

	.text
getchar:
	# read the character
	la $a0, getchar_buf
	li $a1, 2
	li $v0, 8
	syscall

	# return it
	lb $v0, ($a0)
	j $ra
	

	.data
	.align 4
putchar_buf:	.byte 0,0

	.text
putchar:
	# save the character so that it is NUL-terminated 
	la $t0, putchar_buf
	sb $a0, ($t0)

	# print it out
	la $a0, putchar_buf
	li $v0, 4
	syscall

	j $ra


	.text	
# just prints the format string, not the arguments
printf:
	li $v0, 4
	syscall
	j $ra


	.text
exit:
	li $v0, 10
	syscall
	
tig_main:
	sw $fp, -956($sp)
	move $fp, $sp
	sw $sp, -960($fp)
	addi $sp, $sp, -1000
	sw $ra, -964($fp)
	sw $s0, -968($fp)
	sw $s1, -972($fp)
	sw $s2, -976($fp)
	sw $s3, -980($fp)
	sw $s4, -984($fp)
	sw $s5, -988($fp)
	sw $s6, -992($fp)
	sw $s7, -996($fp)
	addi $t0, $fp, -952
	jal getchar
	sw $v0, 0($t0)
	lw $a0, 195($fp)
	jal L290
	move $a1, $v0
	addi $a3, $fp, -952
	jal getchar
	sw $v0, 0($a3)
	lw $a0, 195($fp)
	jal L290
	move $a2, $v0
	lw $t1, 195($fp)
	lw $a0, 195($fp)
	jal L289
	move $a1, $v0
	move $a0, $t1
	jal L287
	li $v0, 0
	lw $s7, -996($fp)
	lw $s6, -992($fp)
	lw $s5, -988($fp)
	lw $s4, -984($fp)
	lw $s3, -980($fp)
	lw $s2, -976($fp)
	lw $s1, -972($fp)
	lw $s0, -968($fp)
	lw $ra, -964($fp)
	lw $fp, -960($fp)
	lw $sp, -956($fp)
	jr $ra
L316:
	L287:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
	la $a0, L275
	jal print
	lw $a3, -4($fp)
	beqz $a3, L313
b L314
L314:
	lw $t0, 195($fp)
	lw $a0, 0($t0)
	lw $t1, -4($fp)
	lw $a1, 0($t1)
	jal L288
	la $a0, L274
	jal print
	move $a0, $fp
	lw $t2, -4($fp)
	lw $a1, 4($t2)
	jal L287
	li $v0, 0
L313:
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L317:
	L288:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
	la $a0, L306
	jal print
	lw $a3, 195($fp)
	lw $a0, 0($a3)
	li $t0, 0
	lw $t1, -4($fp)
	sub $a1, $t0, $t1
	jal L303
	li $v0, 0
	lw $t2, -4($fp)
	bltz $t2, L310
b L311
L311:
	lw $t3, 195($fp)
	lw $a0, 0($t3)
	lw $a1, -4($fp)
	jal L303
	lw $t4, -4($fp)
	bgtz $t4, L307
b L308
L308:
	la $a0, L267
	jal print
L307:
L310:
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L318:
	.data
L306:
	.word 1
	.asciiz "-"
L303:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
	lw $t0, -4($fp)
	bgtz $t0, L304
b L305
L305:
	li $v0, 0
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L304:
	move $a0, $fp
	lw $t1, -4($fp)
	li $t2, 10
	div $a1, $t1, $t2
	jal L303
	lw $t3, -4($fp)
	lw $t6, -4($fp)
	li $t7, 10
	div $t5, $t6, $t7
	li $t8, 10
	mul $t4, $t5, $t8
	sub $a2, $t3, $t4
	la $a0, L267
	jal ord
	add $a0, $a2, $v0
	jal chr
	move $a0, $v0
	jal print
	b L305
L319:
	L289:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
	lw $v0, -4($fp)
	beqz $a1, L300
b L301
L301:
	lw $t3, -4($fp)
	beqz $t3, L297
b L298
L298:
	li $a0, 8
	jal tig_allocRecord
	lw $t4, 0($a1)
	sw $t4, 0($v0)
	addi $t0, $v0, 4
	move $a0, $fp
	lw $a1, 4($a1)
	lw $a2, -4($fp)
	jal L289
	sw $v0, 0($t0)
	lw $t5, 0($a1)
	lw $t7, -4($fp)
	lw $t6, 0($t7)
	blt $t5, $t6, L294
b L295
L295:
	li $a0, 8
	jal tig_allocRecord
	move $t1, $v0
	lw $t9, -4($fp)
	lw $t8, 0($t9)
	sw $t8, 0($t1)
	addi $a3, $t1, 4
	move $a0, $fp
	lw $a2, -4($fp)
	lw $a2, 4($a2)
	jal L289
	sw $v0, 0($a3)
	move $v0, $t1
L294:
	move $a1, $v0
L297:
	move $v0, $a1
L300:
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L320:
	L290:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
	li $a0, 4
	jal tig_allocRecord
	li $t2, 0
	sw $t2, 0($v0)
	move $a1, $v0
	lw $t3, 195($fp)
	lw $a0, 0($t3)
	jal L264
	move $t0, $v0
	li $a0, 8
	jal tig_allocRecord
	move $a3, $v0
	sw $t0, 0($a3)
	addi $a2, $a3, 4
	move $a0, $fp
	jal L290
	sw $v0, 0($a2)
	move $v0, $a3
	lw $t4, 0($a1)
	li $t5, 1
	beq $t4, $t5, L291
b L292
L292:
	li $v0, 0
L291:
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L321:
	L264:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
	li $a2, 0
	lw $t4, 195($fp)
	lw $a0, 0($t4)
	jal L265
	lw $t5, -4($fp)
	addi $t2, $t5, 0
	lw $t6, 195($fp)
	lw $a0, 0($t6)
	lw $t7, 0($fp)
	lw $a1, -952($t7)
	jal L266
	sw $v0, 0($t2)
L285:
	lw $t8, 195($fp)
	lw $a0, 0($t8)
	lw $t9, 0($fp)
	lw $a1, -952($t9)
	jal L266
	li $a0, 1
	beq $v0, $a0, L286
b L284
L284:
	move $v0, $a2
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L286:
	li $a1, 10
	mul $t1, $a2, $a1
	lw $a2, 0($fp)
	lw $a0, -952($a2)
	jal ord
	add $t0, $t1, $v0
	la $a0, L267
	jal ord
	sub $a2, $t0, $v0
	lw $a3, 0($fp)
	addi $a3, $a3, -952
	jal getchar
	sw $v0, 0($a3)
	b L285
L322:
	L265:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
L282:
	li $a1, 1
	lw $t1, 0($fp)
	lw $t0, 0($t1)
	lw $a3, -952($t0)
	la $t2, L274
	beq $a3, $t2, L276
b L277
L277:
	li $a1, 1
	lw $t5, 0($fp)
	lw $t4, 0($t5)
	lw $t3, -952($t4)
	la $t6, L275
	beq $t3, $t6, L279
b L280
L280:
	li $a1, 0
L279:
L276:
	li $t7, 1
	beq $a1, $t7, L283
b L281
L281:
	li $v0, 0
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L283:
	lw $t9, 0($fp)
	lw $t8, 0($t9)
	addi $a0, $t8, -952
	jal getchar
	sw $v0, 0($a0)
	b L282
L323:
	.data
L275:
	.word 2
	.asciiz "\n"
.data
L274:
	.word 1
	.asciiz " "
L266:
	sw $fp, -8($sp)
	move $fp, $sp
	sw $sp, -12($fp)
	addi $sp, $sp, -52
	sw $ra, -16($fp)
	sw $s0, -20($fp)
	sw $s1, -24($fp)
	sw $s2, -28($fp)
	sw $s3, -32($fp)
	sw $s4, -36($fp)
	sw $s5, -40($fp)
	sw $s6, -44($fp)
	sw $s7, -48($fp)
	li $a2, 1
	lw $t1, 0($fp)
	lw $t0, 0($t1)
	lw $a0, -952($t0)
	jal ord
	la $a0, L268
	jal ord
	ble $v0, $v0, L272
b L273
L273:
	li $a2, 0
L272:
	lw $t3, 0($fp)
	lw $t2, 0($t3)
	lw $a0, -952($t2)
	jal ord
	move $a1, $v0
	la $a0, L267
	jal ord
	bge $a1, $v0, L269
b L270
L270:
	li $a2, 0
L269:
	move $v0, $a2
	lw $s7, -48($fp)
	lw $s6, -44($fp)
	lw $s5, -40($fp)
	lw $s4, -36($fp)
	lw $s3, -32($fp)
	lw $s2, -28($fp)
	lw $s1, -24($fp)
	lw $s0, -20($fp)
	lw $ra, -16($fp)
	lw $fp, -12($fp)
	lw $sp, -8($fp)
	jr $ra
L324:
	.data
L268:
	.word 1
	.asciiz "9"
.data
L267:
	.word 1
	.asciiz "0"
