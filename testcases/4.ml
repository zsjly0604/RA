Standard ML of New Jersey v110.77 [built: Sat Aug 23 11:18:31 2014]
- use  "run.sml";
[opening run.sml]
[autoloading]
[library $smlnj/cm/cm.cm is stable]
[library $smlnj/internal/cm-sig-lib.cm is stable]
[library $/pgraph.cm is stable]
[library $smlnj/internal/srcpath-lib.cm is stable]
[library $SMLNJ-BASIS/basis.cm is stable]
[autoloading done]
[scanning sources.cm]
[library $/ml-yacc-lib.cm is stable]
[attempting to load plugin $/lex-ext.cm]
[library $/lex-ext.cm is stable]
[library $smlnj/cm/tools.cm is stable]
[library $smlnj/internal/cm-lib.cm is stable]
[plugin $/lex-ext.cm loaded successfully]
[attempting to load plugin $/mllex-tool.cm]
[library $/mllex-tool.cm is stable]
[plugin $/mllex-tool.cm loaded successfully]
[attempting to load plugin $/grm-ext.cm]
[library $/grm-ext.cm is stable]
[plugin $/grm-ext.cm loaded successfully]
[attempting to load plugin $/mlyacc-tool.cm]
[library $/mlyacc-tool.cm is stable]
[plugin $/mlyacc-tool.cm loaded successfully]
[library $SMLNJ-LIB/Util/smlnj-lib.cm is stable]
[library $SMLNJ-ML-YACC-LIB/ml-yacc-lib.cm is stable]
binfile format error: bad magic number
[compiling (sources.cm):table.sig]
[code: 52, env: 222 bytes]
binfile format error: bad magic number
[compiling (sources.cm):table.sml]
[code: 1084, env: 327 bytes]
binfile format error: bad magic number
[compiling (sources.cm):symbol.sml]
[code: 3851, data: 35, env: 1374 bytes]
binfile format error: bad magic number
[compiling (sources.cm):temp.sig]
[code: 52, env: 579 bytes]
binfile format error: bad magic number
[compiling (sources.cm):temp.sml]
[code: 3809, data: 1101, env: 1236 bytes]
binfile format error: bad magic number
[compiling (sources.cm):tree.sml]
[code: 256, env: 2298 bytes]
binfile format error: bad magic number
[compiling (sources.cm):errormsg.sml]
[code: 2766, data: 174, env: 452 bytes]
binfile format error: bad magic number
[compiling (sources.cm):assem.sml]
[code: 3069, data: 45, env: 683 bytes]
binfile format error: bad magic number
[compiling (sources.cm):frame.sml]
[code: 9766, data: 82, env: 1937 bytes]
binfile format error: bad magic number
[compiling (sources.cm):absyn.sml]
[code: 68, env: 2868 bytes]
binfile format error: bad magic number
[compiling (sources.cm):constFolding.sml]
[code: 4311, data: 135, env: 283 bytes]
binfile format error: bad magic number
[compiling (sources.cm):translate.sml]
[code: 28021, data: 577, env: 2209 bytes]
binfile format error: bad magic number
[compiling (sources.cm):testAll.sml]
[code: 1545, data: 225, env: 132 bytes]
binfile format error: bad magic number
[compiling (sources.cm):codegen.sml]
[code: 17876, data: 648, env: 680 bytes]
binfile format error: bad magic number
[compiling (sources.cm):types.sml]
[code: 68, env: 609 bytes]
binfile format error: bad magic number
[compiling (sources.cm):env.sml]
[code: 3166, data: 250, env: 909 bytes]
binfile format error: bad magic number
[compiling (sources.cm):semant.sml]
[code: 54768, data: 2160, env: 1294 bytes]
binfile format error: bad magic number
[compiling (sources.cm):canon.sml]
[code: 13371, data: 715, env: 280 bytes]
binfile format error: bad magic number
[compiling (sources.cm):findEscape.sml]
[code: 5108, env: 92 bytes]
binfile format error: bad magic number
[compiling (sources.cm):tiger.grm.sig]
[code: 56, env: 1005 bytes]
binfile format error: bad magic number
[compiling (sources.cm):tiger.grm.sml]
[code: 66233, data: 4933, env: 2016 bytes]
binfile format error: bad magic number
[compiling (sources.cm):tiger.lex.sml]
[code: 133603, data: 619, env: 3095 bytes]
binfile format error: bad magic number
[compiling (sources.cm):parse.sml]
[code: 5965, data: 85, env: 125 bytes]
binfile format error: bad magic number
[compiling (sources.cm):funcgraph.sig]
[code: 56, env: 1484 bytes]
binfile format error: bad magic number
[compiling (sources.cm):funcgraph.sml]
[code: 23755, data: 327, env: 2872 bytes]
binfile format error: bad magic number
[compiling (sources.cm):mygraph.sml]
[code: 256, env: 1554 bytes]
binfile format error: bad magic number
[compiling (sources.cm):flowgraph.sml]
[code: 68, env: 644 bytes]
binfile format error: bad magic number
[compiling (sources.cm):makegraph.sml]
[code: 7318, data: 86, env: 455 bytes]
binfile format error: bad magic number
[compiling (sources.cm):liveness.sml]
[code: 21701, data: 217, env: 2050 bytes]
binfile format error: bad magic number
[compiling (sources.cm):reg_alloc.sml]
[code: 45580, data: 768, env: 1474 bytes]
binfile format error: bad magic number
[compiling (sources.cm):main.sml]
[code: 5027, data: 339, env: 574 bytes]
binfile format error: bad magic number
[compiling (sources.cm):printtree.sml]
[code: 10631, data: 351, env: 176 bytes]
binfile format error: bad magic number
[compiling (sources.cm):prabsyn.sml]
[code: 24281, data: 537, env: 173 bytes]
binfile format error: bad magic number
[compiling (sources.cm):irmain.sml]
[code: 1863, data: 79, env: 195 bytes]
[New bindings added.]
val it = true : bool
[opening testAll.sml]
[autoloading]
[autoloading done]
structure TestAll : sig val testAll : (string -> 'a) -> string -> 'a list end
val it = () : unit

=============================================================
===================== Testing merge.tig =====================
=============================================================

===================== STRING ====================
L1: 
0
===================== STRING ====================
L2: 
9
===========================================================
                        isdigit
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $t1), (29, $t2), (30, $t1), (31, $v0), (32, $v0), (33, $t0), (34, $v0), (35, $t0), (36, $v0), (37, $t0), (38, $v0), (39, $t0), (40, $t0), (41, $t0), (42, $t0), (43, $t0), (44, $t1), (45, $t1), (46, $t1), (47, $a0), (48, $t0), (49, $t0), (50, $t0), (51, $t0), (52, $t2), (53, $t2), (54, $t2), (55, $a0), 
========================= ASSEMBLY ========================
isdigit:
move $fp, $sp
addi $sp, $sp, -20
sw $ra -16($fp)
L48:
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t1, 0($fp)
lw $t1, 0($t1)
sw $t0, 0($sp)
lw $a0, -4($t1)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal ord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t0, $v0
lw $t1, 0($fp)
lw $t1, 0($t1)
lw $t1, 0($t1)
sw $t1, 0($sp)
la $a0, L1
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal ord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
bge $t0, $v0, L3
j L4
L4:
li $v0, 0
L5:
j L47
L3:
li $t1, 1
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t2, 0($fp)
lw $t2, 0($t2)
sw $t0, 0($sp)
lw $a0, -4($t2)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal ord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t0, $v0
lw $t2, 0($fp)
lw $t2, 0($t2)
lw $t2, 0($t2)
sw $t2, 0($sp)
la $a0, L2
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal ord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
ble $t0, $v0, L6
j L7
L7:
li $t1, 0
L6:
move $v0, $t1
j L5
L47:
lw $ra -16($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L9: 
 
===================== STRING ====================
L10: 


===========================================================
                        skipto
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t1), (28, $t1), (29, $t1), (30, $t0), (31, $v0), (32, $t0), (33, $t0), (34, $v0), (35, $t0), (36, $v0), (37, $t0), (38, $t0), (39, $t0), (40, $t0), (41, $t0), (42, $a1), (43, $t0), (44, $t0), (45, $t0), (46, $t0), (47, $t0), (48, $a1), (49, $t0), (50, $t0), (51, $t1), (52, $t1), (53, $t1), (54, $t0), (55, $t0), (56, $t0), (57, $t0), (58, $a1), (59, $t0), 
========================= ASSEMBLY ========================
skipto:
move $fp, $sp
addi $sp, $sp, -16
sw $ra -12($fp)
L50:
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t1, 0($fp)
lw $t1, 0($t1)
sw $t0, 0($sp)
lw $a0, -4($t1)
la $a1, L9
sw $t0 -4($fp)
sw $t1 -8($fp)
jal stringEqual
sw $t1 -8($fp)
sw $t0 -4($fp)
li $t0, 0
bne $v0, $t0, L11
j L12
L12:
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t1, 0($fp)
lw $t1, 0($t1)
sw $t0, 0($sp)
lw $a0, -4($t1)
la $a1, L10
sw $t0 -4($fp)
sw $t1 -8($fp)
jal stringEqual
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t1, $v0
L13:
li $t0, 0
bne $t1, $t0, L14
j L8
L8:
li $v0, 0
j L49
L11:
li $t1, 1
j L13
L14:
lw $t0, 0($fp)
lw $t0, 0($t0)
addi $t0, $t0, -4
lw $t1, 0($fp)
lw $t1, 0($t1)
lw $t1, 0($t1)
sw $t1, 0($sp)
sw $t0 -4($fp)
sw $t1 -8($fp)
jal getchar
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $v0, 0($t0)
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t1, 0($fp)
lw $t1, 0($t1)
sw $t0, 0($sp)
lw $a0, -4($t1)
la $a1, L9
sw $t0 -4($fp)
sw $t1 -8($fp)
jal stringEqual
sw $t1 -8($fp)
sw $t0 -4($fp)
li $t0, 0
bne $v0, $t0, L11
j L51
L51:
j L12
L49:
lw $ra -12($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L16: 
0
===========================================================
                        readint
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $t1), (29, $t2), (30, $t0), (31, $t2), (32, $t0), (33, $v0), (34, $fp), (35, $t0), (36, $v0), (37, $fp), (38, $v0), (39, $t1), (40, $t0), (41, $v0), (42, $t0), (43, $v0), (44, $t0), (45, $v0), (46, $fp), (47, $t0), (48, $t0), (49, $t0), (50, $t0), (51, $t1), (52, $t1), (53, $t1), (54, $t0), (55, $t1), (56, $t1), (57, $a0), (58, $t1), (59, $t0), (60, $t2), (61, $t2), (62, $t0), 
========================= ASSEMBLY ========================
readint:
move $fp, $sp
addi $sp, $sp, -20
sw $ra -16($fp)
L53:
li $t1, 0
sw $fp, 0($sp)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal skipto
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
addi $t0, $a0, 0
lw $t2, 0($fp)
sw $fp, 0($sp)
lw $a0, -4($t2)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal isdigit
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $v0, 0($t0)
lw $t0, 0($fp)
sw $fp, 0($sp)
lw $a0, -4($t0)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal isdigit
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
li $t0, 0
bne $v0, $t0, L17
j L15
L15:
move $v0, $t1
j L52
L17:
li $t0, 10
mul $t0, $t1, $t0
lw $t1, 0($fp)
lw $t1, 0($t1)
lw $t1, 0($t1)
lw $t2, 0($fp)
sw $t1, 0($sp)
lw $a0, -4($t2)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal ord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
add $t0, $t0, $v0
lw $t1, 0($fp)
lw $t1, 0($t1)
sw $t1, 0($sp)
la $a0, L16
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal ord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
sub $t1, $t0, $v0
lw $t0, 0($fp)
addi $t0, $t0, -4
lw $t2, 0($fp)
lw $t2, 0($t2)
sw $t2, 0($sp)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal getchar
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $v0, 0($t0)
lw $t0, 0($fp)
sw $fp, 0($sp)
lw $a0, -4($t0)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal isdigit
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
li $t0, 0
bne $v0, $t0, L17
j L54
L54:
j L15
L52:
lw $ra -16($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        readlist
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $v0), (29, $v0), (30, $t1), (31, $v0), (32, $v0), (33, $t0), (34, $t0), (35, $t0), (36, $t0), (37, $t1), (38, $t0), (39, $t0), (40, $t0), (41, $t0), 
========================= ASSEMBLY ========================
readlist:
move $fp, $sp
addi $sp, $sp, -16
sw $ra -12($fp)
L56:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
li $a0, 4
sw $t0 -4($fp)
sw $t1 -8($fp)
jal allocRecord
sw $t1 -8($fp)
sw $t0 -4($fp)
li $t0, 0
sw $t0, 0($v0)
move $a0, $v0
sw $fp, 0($sp)
sw $t0 -4($fp)
sw $t1 -8($fp)
jal readint
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t1, 0($a0)
li $t0, 0
bne $t1, $t0, L18
j L19
L19:
li $v0, 0
L20:
j L55
L18:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
li $a0, 8
sw $t0 -4($fp)
sw $t1 -8($fp)
jal allocRecord
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t1, $v0
sw $v0, 0($t1)
addi $t0, $t1, 4
sw $fp, 0($sp)
sw $t0 -4($fp)
sw $t1 -8($fp)
jal readlist
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $v0, 0($t0)
move $v0, $t1
j L20
L55:
lw $ra -12($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        merge
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t1), (28, $a1), (29, $v0), (30, $v0), (31, $v0), (32, $v0), (33, $v0), (34, $t1), (35, $t0), (36, $t1), (37, $t0), (38, $t0), (39, $t0), (40, $t2), (41, $t0), (42, $t0), (43, $t0), (44, $t0), (45, $t0), (46, $t0), (47, $t0), (48, $t0), (49, $t0), 
========================= ASSEMBLY ========================
merge:
move $fp, $sp
addi $sp, $sp, -20
sw $ra -16($fp)
L58:
move $t1, $a0
li $t0, 0
beq $t1, $t0, L27
j L28
L28:
li $t0, 0
beq $a1, $t0, L24
j L25
L25:
lw $t2, 0($t1)
lw $t0, 0($a1)
blt $t2, $t0, L21
j L22
L22:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
li $a0, 8
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal allocRecord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t0, 0($a1)
sw $t0, 0($v0)
addi $t0, $v0, 4
sw $fp, 0($sp)
move $a0, $t1
lw $a1, 4($a1)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal merge
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t1, $v0
sw $t1, 0($t0)
L23:
L26:
L29:
j L57
L27:
move $v0, $a1
j L29
L24:
move $v0, $t1
j L26
L21:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
li $a0, 8
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal allocRecord
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t0, 0($t1)
sw $t0, 0($v0)
addi $t0, $v0, 4
sw $fp, 0($sp)
lw $a0, 4($t1)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
jal merge
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t1, $v0
sw $t1, 0($t0)
j L23
L57:
lw $ra -16($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L30: 
0
===========================================================
                        f
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t3), (28, $v0), (29, $v0), (30, $v0), (31, $t2), (32, $t1), (33, $t0), (34, $t0), (35, $a0), (36, $t0), (37, $t0), (38, $t0), (39, $t0), (40, $t0), (41, $t1), (42, $t1), (43, $t1), (44, $t1), (45, $t2), (46, $t2), (47, $t4), (48, $t2), (49, $t2), (50, $t3), (51, $t3), (52, $t3), (53, $a0), (54, $a0), 
========================= ASSEMBLY ========================
f:
move $fp, $sp
addi $sp, $sp, -28
sw $ra -24($fp)
L60:
move $t3, $a0
li $t0, 0
bgt $t3, $t0, L31
j L32
L32:
li $v0, 0
L33:
j L59
L31:
sw $fp, 0($sp)
li $t0, 10
div $a0, $t3, $t0
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
jal f
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t1, 0($fp)
lw $t1, 0($t1)
lw $t1, 0($t1)
lw $t1, 0($t1)
li $t2, 10
div $t4, $t3, $t2
li $t2, 10
mul $t2, $t4, $t2
sub $t2, $t3, $t2
lw $t3, 0($fp)
lw $t3, 0($t3)
lw $t3, 0($t3)
sw $t3, 0($sp)
la $a0, L30
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
jal ord
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $t1, 0($sp)
add $a0, $t2, $v0
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
jal chr
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $t0, 0($sp)
move $a0, $v0
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
jal print
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
j L33
L59:
lw $ra -24($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L34: 
-
===================== STRING ====================
L35: 
0
===========================================================
                        printint
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t1), (28, $v0), (29, $v0), (30, $t0), (31, $t0), (32, $t0), (33, $t0), (34, $a0), (35, $t0), (36, $t0), (37, $a0), (38, $a0), (39, $t0), 
========================= ASSEMBLY ========================
printint:
move $fp, $sp
addi $sp, $sp, -16
sw $ra -12($fp)
L62:
move $t1, $a0
li $t0, 0
blt $t1, $t0, L39
j L40
L40:
li $t0, 0
bgt $t1, $t0, L36
j L37
L37:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
la $a0, L35
sw $t0 -4($fp)
sw $t1 -8($fp)
jal print
sw $t1 -8($fp)
sw $t0 -4($fp)
L38:
L41:
j L61
L39:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
la $a0, L34
sw $t0 -4($fp)
sw $t1 -8($fp)
jal print
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $fp, 0($sp)
li $t0, 0
sub $a0, $t0, $t1
sw $t0 -4($fp)
sw $t1 -8($fp)
jal f
sw $t1 -8($fp)
sw $t0 -4($fp)
j L41
L36:
sw $fp, 0($sp)
move $a0, $t1
sw $t0 -4($fp)
sw $t1 -8($fp)
jal f
sw $t1 -8($fp)
sw $t0 -4($fp)
j L38
L61:
lw $ra -12($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L42: 


===================== STRING ====================
L43: 
 
===========================================================
                        printlist
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t1), (28, $v0), (29, $t0), (30, $t0), (31, $t0), (32, $a0), (33, $t0), (34, $t0), (35, $a0), 
========================= ASSEMBLY ========================
printlist:
move $fp, $sp
addi $sp, $sp, -16
sw $ra -12($fp)
L64:
move $t1, $a0
li $t0, 0
beq $t1, $t0, L44
j L45
L45:
sw $fp, 0($sp)
lw $a0, 0($t1)
sw $t0 -4($fp)
sw $t1 -8($fp)
jal printint
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
la $a0, L43
sw $t0 -4($fp)
sw $t1 -8($fp)
jal print
sw $t1 -8($fp)
sw $t0 -4($fp)
sw $fp, 0($sp)
lw $a0, 4($t1)
sw $t0 -4($fp)
sw $t1 -8($fp)
jal printlist
sw $t1 -8($fp)
sw $t0 -4($fp)
L46:
j L63
L44:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
la $a0, L42
sw $t0 -4($fp)
sw $t1 -8($fp)
jal print
sw $t1 -8($fp)
sw $t0 -4($fp)
j L46
L63:
lw $ra -12($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), (28, $a1), (29, $v0), (30, $t0), (31, $t1), (32, $t0), (33, $v0), (34, $fp), (35, $t0), (36, $t1), (37, $t0), (38, $t1), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -20
sw $ra -16($fp)
L66:
addi $t0, $fp, -4
lw $t1, 0($fp)
sw $t1, 0($sp)
sw $t0 -8($fp)
sw $t1 -12($fp)
jal getchar
sw $t1 -12($fp)
sw $t0 -8($fp)
sw $v0, 0($t0)
sw $fp, 0($sp)
sw $t0 -8($fp)
sw $t1 -12($fp)
jal readlist
sw $t1 -12($fp)
sw $t0 -8($fp)
addi $t0, $fp, -4
lw $t1, 0($fp)
sw $t1, 0($sp)
sw $t0 -8($fp)
sw $t1 -12($fp)
jal getchar
sw $t1 -12($fp)
sw $t0 -8($fp)
move $t1, $v0
sw $t1, 0($t0)
sw $fp, 0($sp)
sw $t0 -8($fp)
sw $t1 -12($fp)
jal readlist
sw $t1 -12($fp)
sw $t0 -8($fp)
move $a1, $v0
sw $fp, 0($sp)
move $a0, $v0
sw $t0 -8($fp)
sw $t1 -12($fp)
jal merge
sw $t1 -12($fp)
sw $t0 -8($fp)
sw $fp, 0($sp)
move $a0, $v0
sw $t0 -8($fp)
sw $t1 -12($fp)
jal printlist
sw $t1 -12($fp)
sw $t0 -8($fp)
j L65
L65:
lw $ra -16($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing queens.tig =====================
=============================================================

===================== STRING ====================
L3: 
 O
===================== STRING ====================
L4: 
 .
===================== STRING ====================
L10: 


===================== STRING ====================
L13: 


===========================================================
                        printboard
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t2), (28, $t0), (29, $t1), (30, $t0), (31, $t3), (32, $a0), (33, $t2), (34, $t1), (35, $t0), (36, $t1), (37, $t2), (38, $t0), (39, $t0), (40, $t0), (41, $t0), (42, $a0), (43, $t0), (44, $t0), (45, $t0), (46, $t0), (47, $a0), (48, $t0), (49, $t0), (50, $t0), (51, $t0), (52, $t0), (53, $t3), (54, $t3), (55, $t4), (56, $t3), (57, $t3), (58, $a0), (59, $t0), (60, $t0), (61, $a0), 
========================= ASSEMBLY ========================
printboard:
move $fp, $sp
addi $sp, $sp, -28
sw $ra -24($fp)
L34:
li $t2, 0
lw $t0, 0($fp)
lw $t0, -4($t0)
addi $t0, $t0, -1
ble $t2, $t0, L12
j L1
L1:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
la $a0, L13
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
jal print
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
j L33
L11:
addi $t2, $t2, 1
L12:
li $t1, 0
lw $t0, 0($fp)
lw $t0, -4($t0)
addi $t0, $t0, -1
ble $t1, $t0, L9
j L2
L2:
lw $t0, 0($fp)
lw $t0, 0($t0)
sw $t0, 0($sp)
la $a0, L10
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
jal print
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t0, 0($fp)
lw $t0, -4($t0)
addi $t0, $t0, -1
blt $t2, $t0, L11
j L35
L35:
j L1
L8:
addi $t1, $t1, 1
L9:
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t0, 0($t0)
lw $t3, 0($fp)
lw $t4, -12($t3)
li $t3, 4
mul $t3, $t2, $t3
add $t3, $t4, $t3
lw $t3, 0($t3)
beq $t3, $t1, L5
j L6
L6:
la $a0, L4
L7:
sw $t0, 0($sp)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
jal print
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t0, 0($fp)
lw $t0, -4($t0)
addi $t0, $t0, -1
blt $t1, $t0, L8
j L36
L36:
j L2
L5:
la $a0, L3
j L7
L33:
lw $ra -24($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        try
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t2), (28, $t0), (29, $t0), (30, $t1), (31, $t1), (32, $t3), (33, $t1), (34, $t1), (35, $t3), (36, $t1), (37, $t1), (38, $t1), (39, $t1), (40, $t1), (41, $t1), (42, $t1), (43, $t1), (44, $t1), (45, $t1), (46, $v0), (47, $t2), (48, $t0), (49, $t0), (50, $t0), (51, $t1), (52, $t1), (53, $t3), (54, $t1), (55, $t3), (56, $t1), (57, $t1), (58, $t1), (59, $t3), (60, $t3), (61, $t1), (62, $t1), (63, $t4), (64, $t3), (65, $t5), (66, $t3), (67, $t4), (68, $t3), (69, $t3), (70, $t4), (71, $t3), (72, $t5), (73, $t3), (74, $t4), (75, $t3), (76, $t3), (77, $t3), (78, $t4), (79, $t1), (80, $t3), (81, $t1), (82, $t1), (83, $t5), (84, $t1), (85, $t4), (86, $t1), (87, $t3), (88, $t1), (89, $t5), (90, $t1), (91, $t4), (92, $t1), (93, $t3), (94, $t1), (95, $t1), (96, $t1), (97, $t3), (98, $t1), (99, $t1), (100, $a0), (101, $t4), (102, $t1), (103, $t3), (104, $t1), (105, $t1), (106, $t5), (107, $t1), (108, $t4), (109, $t1), (110, $t3), (111, $t1), (112, $t5), (113, $t1), (114, $t4), (115, $t1), (116, $t3), (117, $t1), (118, $t1), 
========================= ASSEMBLY ========================
try:
move $fp, $sp
addi $sp, $sp, -32
sw $ra -28($fp)
L38:
move $t2, $a0
lw $t0, 0($fp)
lw $t0, -4($t0)
beq $t2, $t0, L30
j L31
L31:
li $t0, 0
lw $t1, 0($fp)
lw $t1, -4($t1)
addi $t1, $t1, -1
ble $t0, $t1, L29
j L14
L14:
li $v0, 0
L32:
j L37
L30:
sw $fp, 0($sp)
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
jal printboard
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
j L32
L28:
addi $t0, $t0, 1
L29:
lw $t1, 0($fp)
lw $t3, -8($t1)
li $t1, 4
mul $t1, $t0, $t1
add $t1, $t3, $t1
lw $t3, 0($t1)
li $t1, 0
beq $t3, $t1, L15
j L16
L16:
li $t1, 0
L17:
li $t3, 0
bne $t1, $t3, L20
j L21
L21:
li $t1, 0
L22:
li $t3, 0
bne $t1, $t3, L25
j L26
L26:
li $t1, 0
L27:
lw $t1, 0($fp)
lw $t1, -4($t1)
addi $t1, $t1, -1
blt $t0, $t1, L28
j L39
L39:
j L14
L15:
li $t1, 1
lw $t3, 0($fp)
lw $t5, -16($t3)
add $t4, $t0, $t2
li $t3, 4
mul $t3, $t4, $t3
add $t3, $t5, $t3
lw $t4, 0($t3)
li $t3, 0
beq $t4, $t3, L18
j L19
L19:
li $t1, 0
L18:
j L17
L20:
li $t1, 1
lw $t3, 0($fp)
lw $t5, -20($t3)
addi $t3, $t0, 7
sub $t4, $t3, $t2
li $t3, 4
mul $t3, $t4, $t3
add $t3, $t5, $t3
lw $t4, 0($t3)
li $t3, 0
beq $t4, $t3, L23
j L24
L24:
li $t1, 0
L23:
j L22
L25:
lw $t1, 0($fp)
li $t4, 1
lw $t3, -8($t1)
li $t1, 4
mul $t1, $t0, $t1
add $t1, $t3, $t1
sw $t4, 0($t1)
lw $t1, 0($fp)
li $t5, 1
lw $t4, -16($t1)
add $t3, $t0, $t2
li $t1, 4
mul $t1, $t3, $t1
add $t1, $t4, $t1
sw $t5, 0($t1)
lw $t1, 0($fp)
li $t5, 1
lw $t4, -20($t1)
addi $t1, $t0, 7
sub $t3, $t1, $t2
li $t1, 4
mul $t1, $t3, $t1
add $t1, $t4, $t1
sw $t5, 0($t1)
lw $t1, 0($fp)
lw $t3, -12($t1)
li $t1, 4
mul $t1, $t2, $t1
add $t1, $t3, $t1
sw $t0, 0($t1)
sw $fp, 0($sp)
addi $a0, $t2, 1
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
jal try
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
lw $t1, 0($fp)
li $t4, 0
lw $t3, -8($t1)
li $t1, 4
mul $t1, $t0, $t1
add $t1, $t3, $t1
sw $t4, 0($t1)
lw $t1, 0($fp)
li $t5, 0
lw $t4, -16($t1)
add $t3, $t0, $t2
li $t1, 4
mul $t1, $t3, $t1
add $t1, $t4, $t1
sw $t5, 0($t1)
lw $t1, 0($fp)
li $t5, 0
lw $t4, -20($t1)
addi $t1, $t0, 7
sub $t3, $t1, $t2
li $t1, 4
mul $t1, $t3, $t1
add $t1, $t4, $t1
sw $t5, 0($t1)
li $t1, 0
j L27
L37:
lw $ra -28($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t2), (28, $t2), (29, $t3), (30, $t3), (31, $t0), (32, $t0), (33, $t0), (34, $t0), (35, $t0), (36, $t0), (37, $t1), (38, $a0), (39, $t1), (40, $t1), (41, $t0), (42, $t1), (43, $a0), (44, $t1), (45, $t1), (46, $t0), (47, $t1), (48, $a0), (49, $t1), (50, $t1), (51, $t2), (52, $t1), (53, $t1), (54, $t1), (55, $t2), (56, $t1), (57, $t0), (58, $t1), (59, $a0), (60, $t1), (61, $t1), (62, $t2), (63, $t1), (64, $t1), (65, $t1), (66, $t2), (67, $t1), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -44
sw $ra -40($fp)
L41:
li $t0, 8
sw $t0, -4($fp)
addi $t0, $fp, -8
lw $t1, 0($fp)
sw $t1, 0($sp)
lw $t1, -4($fp)
addi $a0, $t1, 1
li $a1, 0
sw $t0 -24($fp)
sw $t1 -28($fp)
sw $t2 -32($fp)
sw $t3 -36($fp)
jal initArray
sw $t3 -36($fp)
sw $t2 -32($fp)
sw $t1 -28($fp)
sw $t0 -24($fp)
move $t2, $v0
addi $t1, $fp, -4
sw $t1, 0($t2)
addi $t2, $t2, 4
sw $t2, 0($t0)
addi $t0, $fp, -12
lw $t1, 0($fp)
sw $t1, 0($sp)
lw $t1, -4($fp)
addi $a0, $t1, 1
li $a1, 0
sw $t0 -24($fp)
sw $t1 -28($fp)
sw $t2 -32($fp)
sw $t3 -36($fp)
jal initArray
sw $t3 -36($fp)
sw $t2 -32($fp)
sw $t1 -28($fp)
sw $t0 -24($fp)
move $t2, $v0
addi $t1, $fp, -4
sw $t1, 0($t2)
addi $t2, $t2, 4
sw $t2, 0($t0)
addi $t0, $fp, -16
lw $t1, 0($fp)
sw $t1, 0($sp)
lw $t2, -4($fp)
lw $t1, -4($fp)
add $t1, $t2, $t1
addi $t1, $t1, -1
addi $a0, $t1, 1
li $a1, 0
sw $t0 -24($fp)
sw $t1 -28($fp)
sw $t2 -32($fp)
sw $t3 -36($fp)
jal initArray
sw $t3 -36($fp)
sw $t2 -32($fp)
sw $t1 -28($fp)
sw $t0 -24($fp)
move $t3, $v0
lw $t2, -4($fp)
lw $t1, -4($fp)
add $t1, $t2, $t1
addi $t1, $t1, -1
sw $t1, 0($t3)
addi $t3, $t3, 4
sw $t3, 0($t0)
addi $t0, $fp, -20
lw $t1, 0($fp)
sw $t1, 0($sp)
lw $t2, -4($fp)
lw $t1, -4($fp)
add $t1, $t2, $t1
addi $t1, $t1, -1
addi $a0, $t1, 1
li $a1, 0
sw $t0 -24($fp)
sw $t1 -28($fp)
sw $t2 -32($fp)
sw $t3 -36($fp)
jal initArray
sw $t3 -36($fp)
sw $t2 -32($fp)
sw $t1 -28($fp)
sw $t0 -24($fp)
move $t3, $v0
lw $t2, -4($fp)
lw $t1, -4($fp)
add $t1, $t2, $t1
addi $t1, $t1, -1
sw $t1, 0($t3)
addi $t3, $t3, 4
sw $t3, 0($t0)
sw $fp, 0($sp)
li $a0, 0
sw $t0 -24($fp)
sw $t1 -28($fp)
sw $t2 -32($fp)
sw $t3 -36($fp)
jal try
sw $t3 -36($fp)
sw $t2 -32($fp)
sw $t1 -28($fp)
sw $t0 -24($fp)
j L40
L40:
lw $ra -40($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test1.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), (28, $v0), (29, $t0), (30, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -8($fp)
L2:
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 11
li $a1, 0
sw $t0 -4($fp)
jal initArray
sw $t0 -4($fp)
li $t0, 10
sw $t0, 0($v0)
addi $v0, $v0, 4
j L1
L1:
lw $ra -8($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test12.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t2), (28, $t1), (29, $t0), (30, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L5:
li $t2, 0
li $t1, 0
li $t0, 100
ble $t1, $t0, L3
j L1
L1:
li $v0, 0
j L4
L2:
addi $t1, $t1, 1
L3:
addi $t2, $t2, 1
li $t0, 100
blt $t1, $t0, L2
j L6
L6:
j L1
L4:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test2.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), (28, $v0), (29, $t0), (30, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -8($fp)
L2:
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 11
li $a1, 0
sw $t0 -4($fp)
jal initArray
sw $t0 -4($fp)
li $t0, 10
sw $t0, 0($v0)
addi $v0, $v0, 4
j L1
L1:
lw $ra -8($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test27.tig =====================
=============================================================

===========================================================
                        f
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $t0), 
========================= ASSEMBLY ========================
f:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L2:
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $v0, -4($t0)
j L1
L1:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        g
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $a1), (29, $t0), 
========================= ASSEMBLY ========================
g:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L4:
lw $t0, 0($fp)
lw $v0, -4($t0)
j L3
L3:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -16
sw $ra -12($fp)
L6:
li $t0, 0
sw $t0, -4($fp)
sw $fp, 0($sp)
li $a0, 2
li $a1, 3
sw $t0 -8($fp)
jal g
sw $t0 -8($fp)
lw $v0, -4($fp)
j L5
L5:
lw $ra -12($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test27escape.tig =====================
=============================================================

===========================================================
                        f
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $t0), (29, $t0), (30, $t1), (31, $v0), (32, $t0), 
========================= ASSEMBLY ========================
f:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L2:
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t1, -4($t0)
lw $t0, 0($fp)
lw $t0, -4($t0)
add $v0, $t1, $t0
j L1
L1:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        g
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $t1), (29, $t0), (30, $t0), (31, $t0), (32, $v0), (33, $t1), 
========================= ASSEMBLY ========================
g:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -8($fp)
L4:
sw $a1, -4($fp)
lw $t0, -4($fp)
add $t0, $a0, $t0
lw $t1, 0($fp)
lw $t1, -4($t1)
add $v0, $t0, $t1
j L3
L3:
lw $ra -8($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -16
sw $ra -12($fp)
L6:
li $t0, 0
sw $t0, -4($fp)
sw $fp, 0($sp)
li $a0, 2
li $a1, 3
sw $t0 -8($fp)
jal g
sw $t0 -8($fp)
lw $v0, -4($fp)
j L5
L5:
lw $ra -12($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test3.tig =====================
=============================================================

===================== STRING ====================
L1: 
Nobody
===================== STRING ====================
L2: 
Somebody
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), (28, $v0), (29, $t0), (30, $t0), (31, $t0), (32, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -8($fp)
L4:
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 8
sw $t0 -4($fp)
jal allocRecord
sw $t0 -4($fp)
la $t0, L1
sw $t0, 0($v0)
li $t0, 1000
sw $t0, 4($v0)
la $t0, L2
sw $t0, 0($v0)
j L3
L3:
lw $ra -8($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test30.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), (28, $v0), (29, $t0), (30, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -8($fp)
L2:
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 11
li $a1, 0
sw $t0 -4($fp)
jal initArray
sw $t0 -4($fp)
li $t0, 10
sw $t0, 0($v0)
addi $v0, $v0, 4
lw $v0, 8($v0)
j L1
L1:
lw $ra -8($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test37.tig =====================
=============================================================

===================== STRING ====================
L1: 
 
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t0), (28, $v0), (29, $v0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L3:
li $t0, 0
la $v0, L1
j L2
L2:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test4.tig =====================
=============================================================

===========================================================
                        nfactor
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $v0), (29, $v0), (30, $t0), (31, $t0), (32, $a0), (33, $v0), 
========================= ASSEMBLY ========================
nfactor:
move $fp, $sp
addi $sp, $sp, -12
sw $ra -8($fp)
L5:
li $t0, 0
beq $a0, $t0, L1
j L2
L2:
move $t0, $a0
sw $fp, 0($sp)
addi $a0, $a0, -1
sw $t0 -4($fp)
jal nfactor
sw $t0 -4($fp)
mul $v0, $t0, $v0
L3:
j L4
L1:
li $v0, 1
j L3
L4:
lw $ra -8($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -4($fp)
L7:
sw $fp, 0($sp)
li $a0, 10
jal nfactor
j L6
L6:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test41.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L2:
li $v0, 0
j L1
L1:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test42.tig =====================
=============================================================

===================== STRING ====================
L1: 
aname
===================== STRING ====================
L2: 
somewhere
===================== STRING ====================
L3: 

===================== STRING ====================
L4: 
Kapoios
===================== STRING ====================
L5: 
Kapou
===================== STRING ====================
L6: 
Allos
===================== STRING ====================
L7: 
kati
===================== STRING ====================
L8: 
sfd
===================== STRING ====================
L9: 
sdf
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t5), (28, $t5), (29, $t4), (30, $v0), (31, $t4), (32, $t3), (33, $t3), (34, $t2), (35, $v0), (36, $t1), (37, $v0), (38, $t1), (39, $t0), (40, $t0), (41, $t0), (42, $t0), (43, $t0), (44, $t0), (45, $t1), (46, $t1), (47, $t1), (48, $t1), (49, $t1), (50, $t0), (51, $t0), (52, $a1), (53, $t0), (54, $t0), (55, $t0), (56, $t0), (57, $t0), (58, $t0), (59, $t0), (60, $t0), (61, $t0), (62, $t6), (63, $t6), (64, $t0), (65, $t0), (66, $t5), (67, $t0), (68, $t5), (69, $t0), (70, $t0), (71, $t0), (72, $t2), (73, $t0), (74, $t2), (75, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -32
sw $ra -32($fp)
L11:
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 11
li $a1, 0
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
sw $t6 -28($fp)
jal initArray
sw $t6 -28($fp)
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t5, $v0
li $t0, 10
sw $t0, 0($t5)
addi $t5, $t5, 4
lw $t0, 0($fp)
lw $t0, 0($t0)
lw $t1, 0($fp)
sw $t1, 0($sp)
li $a0, 16
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
sw $t6 -28($fp)
jal allocRecord
sw $t6 -28($fp)
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
la $t1, L1
sw $t1, 0($v0)
la $t1, L2
sw $t1, 4($v0)
li $t1, 0
sw $t1, 8($v0)
li $t1, 0
sw $t1, 12($v0)
sw $t0, 0($sp)
li $a0, 6
move $a1, $v0
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
sw $t6 -28($fp)
jal initArray
sw $t6 -28($fp)
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t4, $v0
li $t0, 5
sw $t0, 0($t4)
addi $t4, $t4, 4
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 101
la $a1, L3
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
sw $t6 -28($fp)
jal initArray
sw $t6 -28($fp)
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t3, $v0
li $t0, 100
sw $t0, 0($t3)
addi $t3, $t3, 4
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 16
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
sw $t6 -28($fp)
jal allocRecord
sw $t6 -28($fp)
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
la $t0, L4
sw $t0, 0($v0)
la $t0, L5
sw $t0, 4($v0)
li $t0, 2432
sw $t0, 8($v0)
li $t0, 44
sw $t0, 12($v0)
move $t2, $v0
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 8
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
sw $t6 -28($fp)
jal allocRecord
sw $t6 -28($fp)
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
move $t1, $v0
la $t0, L6
sw $t0, 0($t1)
addi $t0, $t1, 4
lw $t6, 0($fp)
sw $t6, 0($sp)
li $a0, 4
li $a1, 1900
sw $t0 -4($fp)
sw $t1 -8($fp)
sw $t2 -12($fp)
sw $t3 -16($fp)
sw $t4 -20($fp)
sw $t5 -24($fp)
sw $t6 -28($fp)
jal initArray
sw $t6 -28($fp)
sw $t5 -24($fp)
sw $t4 -20($fp)
sw $t3 -16($fp)
sw $t2 -12($fp)
sw $t1 -8($fp)
sw $t0 -4($fp)
li $t6, 3
sw $t6, 0($v0)
addi $v0, $v0, 4
sw $v0, 0($t0)
li $t0, 1
sw $t0, 0($t5)
li $t0, 3
sw $t0, 36($t5)
la $t5, L7
lw $t0, 12($t4)
sw $t5, 0($t0)
li $t5, 23
lw $t0, 4($t4)
sw $t5, 12($t0)
la $t0, L8
sw $t0, 136($t3)
la $t0, L9
sw $t0, 0($t2)
li $t2, 2323
lw $t0, 4($t1)
sw $t2, 0($t0)
li $t2, 2323
lw $t0, 4($t1)
sw $t2, 8($t0)
li $v0, 0
j L10
L10:
lw $ra -32($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test44.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L2:
li $t0, 0
li $t0, 0
li $v0, 0
j L1
L1:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test46.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t1), (28, $t0), (29, $v0), (30, $t0), (31, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L6:
li $t1, 0
li $t0, 1
li $t0, 0
beq $t1, $t0, L1
j L2
L2:
li $t0, 0
L1:
li $v0, 1
li $t0, 0
bne $t1, $t0, L3
j L4
L4:
li $v0, 0
L3:
j L5
L5:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test47.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L2:
li $t0, 4
li $v0, 0
j L1
L1:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test48.tig =====================
=============================================================

===========================================================
                        g
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), 
========================= ASSEMBLY ========================
g:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L2:
move $v0, $a0
j L1
L1:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        g
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), 
========================= ASSEMBLY ========================
g:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L4:
move $v0, $a0
j L3
L3:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L6:
li $v0, 0
j L5
L5:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test5.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), (28, $v0), (29, $t0), (30, $t0), (31, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -8($fp)
L2:
lw $t0, 0($fp)
sw $t0, 0($sp)
li $a0, 8
sw $t0 -4($fp)
jal allocRecord
sw $t0 -4($fp)
li $t0, 0
sw $t0, 0($v0)
li $t0, 0
sw $t0, 4($v0)
j L1
L1:
lw $ra -8($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test6.tig =====================
=============================================================

===========================================================
                        do_nothing1
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $a1), (29, $a0), 
========================= ASSEMBLY ========================
do_nothing1:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -4($fp)
L4:
sw $fp, 0($sp)
addi $a0, $a0, 1
jal do_nothing2
j L3
L3:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L1: 
str
===========================================================
                        do_nothing2
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $a1), 
========================= ASSEMBLY ========================
do_nothing2:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -4($fp)
L6:
sw $fp, 0($sp)
la $a1, L1
jal do_nothing1
j L5
L5:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L2: 
str2
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a1), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -4($fp)
L8:
sw $fp, 0($sp)
li $a0, 0
la $a1, L2
jal do_nothing1
j L7
L7:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test7.tig =====================
=============================================================

===========================================================
                        do_nothing1
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $a1), (29, $a0), 
========================= ASSEMBLY ========================
do_nothing1:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -4($fp)
L5:
sw $fp, 0($sp)
addi $a0, $a0, 1
jal do_nothing2
li $v0, 0
j L4
L4:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L1: 
str
===================== STRING ====================
L2: 
 
===========================================================
                        do_nothing2
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $a1), (29, $v0), 
========================= ASSEMBLY ========================
do_nothing2:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -4($fp)
L7:
sw $fp, 0($sp)
la $a1, L1
jal do_nothing1
la $v0, L2
j L6
L6:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===================== STRING ====================
L3: 
str2
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a1), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -8
sw $ra -4($fp)
L9:
sw $fp, 0($sp)
li $a0, 0
la $a1, L3
jal do_nothing1
j L8
L8:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test8.tig =====================
=============================================================

===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $v0), (28, $t1), (29, $t0), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L5:
li $t1, 10
li $t0, 20
bgt $t1, $t0, L1
j L2
L2:
li $v0, 40
L3:
j L4
L1:
li $v0, 30
j L3
L4:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)

=============================================================
===================== Testing test_initArray.tig =====================
=============================================================

===========================================================
                        try
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $a0), (28, $t0), (29, $t1), (30, $t0), (31, $t0), (32, $t0), (33, $v0), (34, $t1), 
========================= ASSEMBLY ========================
try:
move $fp, $sp
addi $sp, $sp, -4
sw $ra -4($fp)
L2:
lw $t0, 0($fp)
lw $t0, -8($t0)
lw $t0, 0($t0)
lw $t1, 0($fp)
lw $t1, -4($t1)
add $v0, $t0, $t1
j L1
L1:
lw $ra -4($fp)
move $sp, $fp
lw $fp, 0($fp)
===========================================================
                        tiger_main
===========================================================
======================= color_table =======================
            (0, $zero), (1, $v0), (2, $t0), (3, $t1), (4, $t2), (5, $t3), (6, $t4), (7, $t5), (8, $t6), (9, $t7), (10, $s0), (11, $s1), (12, $s2), (13, $s3), (14, $s4), (15, $s5), (16, $s6), (17, $s7), (18, $t8), (19, $t9), (20, $sp), (21, $fp), (22, $ra), (23, $a0), (24, $a1), (25, $a2), (26, $a3), (27, $t3), (28, $t0), (29, $t0), (30, $t0), (31, $t1), (32, $a0), (33, $t1), (34, $t1), (35, $t2), (36, $t1), (37, $t1), (38, $t1), (39, $t2), (40, $t1), 
========================= ASSEMBLY ========================
tiger_main:
move $fp, $sp
addi $sp, $sp, -32
sw $ra -28($fp)
L4:
li $t0, 8
sw $t0, -4($fp)
addi $t0, $fp, -8
lw $t1, 0($fp)
sw $t1, 0($sp)
lw $t2, -4($fp)
lw $t1, -4($fp)
add $t1, $t2, $t1
addi $t1, $t1, -1
addi $a0, $t1, 1
li $a1, 0
sw $t0 -12($fp)
sw $t1 -16($fp)
sw $t2 -20($fp)
sw $t3 -24($fp)
jal initArray
sw $t3 -24($fp)
sw $t2 -20($fp)
sw $t1 -16($fp)
sw $t0 -12($fp)
move $t3, $v0
lw $t2, -4($fp)
lw $t1, -4($fp)
add $t1, $t2, $t1
addi $t1, $t1, -1
sw $t1, 0($t3)
addi $t3, $t3, 4
sw $t3, 0($t0)
sw $fp, 0($sp)
li $a0, 100
sw $t0 -12($fp)
sw $t1 -16($fp)
sw $t2 -20($fp)
sw $t3 -24($fp)
jal try
sw $t3 -24($fp)
sw $t2 -20($fp)
sw $t1 -16($fp)
sw $t0 -12($fp)
j L3
L3:
lw $ra -28($fp)
move $sp, $fp
lw $fp, 0($fp)
val it = [(),(),(),(),(),(),(),(),(),(),(),(),...] : unit list
val it = () : unit
- 