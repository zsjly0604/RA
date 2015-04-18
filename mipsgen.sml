structure MipsGen :> CODEGEN = 
struct
  structure T = Tree
  structure A = Assem
  structure Frame : FRAME = MipsFrame

fun codegen (stm:T.stm) : A.instr list = 
  let val ilist = ref (nil:A.instr list)
      val calldefs = [Frame.RV, Frame.RA]@(map #1 Frame.argregs)
      fun emit x = ilist := x :: !ilist
      fun tostring i = if i >= 0 then Int.toString(i)
                       else ("-" ^ Int.toString(~i))
      fun result (gen) = let val t = Temp.newtemp()
                         in
                            gen t;
                            t
                         end
      fun munchStm (T.SEQ(a, b)) = (munchStm a; munchStm b)
        (*sw*)
        | munchStm (T.MOVE(T.MEM(T.BINOP(T.PLUS, e1, T.CONST i)), e2)) = emit(A.OPER{assem = "sw `s0, "^ tostring i ^ "(`s1)\n", 
                                                                                     src = [munchExp e2, munchExp e1], dst = [], jump = NONE})
        | munchStm (T.MOVE(T.MEM(T.BINOP(T.PLUS, T.CONST i, e1)), e2)) = emit(A.OPER{assem = "sw `s0, "^ tostring i ^ "(`s1)\n", 
                                                                                     src = [munchExp e2, munchExp e1], dst = [], jump = NONE})
	| munchStm (T.MOVE(T.MEM(T.BINOP(T.MINUS, e1, T.CONST i)), e2)) = emit(A.OPER{assem = "sw `s0, " ^ tostring(~i) ^ "(`s1)\n",
                                                                                      src = [munchExp e2, munchExp e1], dst = [], jump = NONE})
	| munchStm (T.MOVE(T.MEM(T.BINOP(T.MINUS, T.CONST i, e1)), e2)) = emit(A.OPER{assem = "sw `s0, " ^ tostring(~i) ^ "(`s1)\n",
                                                                                      src = [munchExp e2, munchExp e1], dst = [], jump = NONE})
        | munchStm (T.MOVE(T.MEM(T.CONST i), e)) = emit(A.OPER{assem = "sw `s0, "  ^ tostring i ^ "($ZERO)\n", 
                                                               src = [munchExp e], dst = [], jump = NONE})
        | munchStm (T.MOVE(T.MEM(e1), e2)) = emit(A.OPER{assem = "sw `s0, 0(`s1)\n", 
                                                         src = [munchExp e2, munchExp e1], dst = [], jump = NONE})
        (*li*)
	| munchStm (T.MOVE(T.TEMP t, T.CONST i)) = emit(A.OPER{assem = "li `d0, " ^ tostring i ^ "\n",
                                                               src =[], dst = [t], jump = NONE})
        (*lw*)
	| munchStm (T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.PLUS, e, T.CONST i)))) = emit(A.OPER{assem = "lw `d0, " ^ tostring i ^ "(`s0)\n",
                                                                                    src =[munchExp e], dst = [t], jump = NONE})
	| munchStm (T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.PLUS, T.CONST i, e)))) = emit(A.OPER{assem = "lw `d0, " ^ tostring i ^ "(`s0)\n",
                                                                                    src =[munchExp e], dst = [t], jump = NONE})
	| munchStm (T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.MINUS, e, T.CONST i)))) = emit(A.OPER{assem = "lw `d0, " ^ Int.toString (~i) ^ "(`s0)\n",
                                                                                     src =[munchExp e], dst = [t], jump = NONE})
	| munchStm (T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.MINUS, T.CONST i, e)))) = emit(A.OPER{assem = "lw `d0, " ^ Int.toString (~i) ^ "(`s0)\n",
                                                                                     src =[munchExp e], dst = [t], jump = NONE})
        (*move*)
        | munchStm (T.MOVE(T.TEMP t, e)) = emit(A.MOVE{assem = "move `d0, `s0\n", 
                                                       src = munchExp e, dst = t})
        (*unconditional branch*)
	| munchStm (T.JUMP(T.NAME lab, _)) = emit(A.OPER{assem = "b `j0\n",
                                                         src = [], dst = [], jump = SOME([lab])})
	| munchStm (T.JUMP(e, labs)) = emit(A.OPER{assem = "jr `s0\n", 
                                                   src = [munchExp e],dst = [], jump = SOME(labs)})
        (*comditional branch*)
	| munchStm (T.CJUMP(T.GE, e, T.CONST 0, l1, l2)) = emit(A.OPER{assem = "bgez `s0, `j0\nb `j1\n",
                                                                       src = [munchExp e], dst = [], jump = SOME([l1, l2])})
	| munchStm (T.CJUMP(T.GT, e, T.CONST 0, l1, l2)) = emit(A.OPER{assem = "bgtz `s0, `j0\nb `j1\n",
                                                                       src = [munchExp e], dst = [], jump = SOME([l1, l2])})    
	| munchStm (T.CJUMP(T.LE, e, T.CONST 0, l1, l2)) = emit(A.OPER{assem = "blez `s0, `j0\nb `j1\n",
                                                                       src = [munchExp e], dst = [], jump = SOME([l1, l2])})
	| munchStm (T.CJUMP(T.LT, e, T.CONST 0, l1, l2)) = emit(A.OPER{assem = "bltz `s0, `j0\nb `j1\n",
                                                                       src = [munchExp e], dst = [], jump = SOME([l1, l2])}) 
	| munchStm (T.CJUMP(T.EQ, e, T.CONST 0, l1, l2)) = emit(A.OPER{assem = "beqz `s0, `j0\nb `j1\n",
                                                                       src = [munchExp e], dst = [], jump = SOME([l1, l2])})
	| munchStm (T.CJUMP(T.NE, e, T.CONST 0, l1, l2)) = emit(A.OPER{assem = "bnez `s0, `j0\nb `j1\n",
                                                                       src = [munchExp e], dst = [], jump = SOME([l1, l2])})
	| munchStm (T.CJUMP(T.GE, e1, e2, l1, l2)) = emit(A.OPER{assem = "bge `s0, `s1, `j0\nb `j1\n",
                                                                 src = [munchExp e1, munchExp e2], dst = [], jump = SOME([l1, l2])})  
	| munchStm (T.CJUMP(T.GT, e1, e2, l1, l2)) = emit(A.OPER{assem = "bgt `s0, `s1, `j0\nb `j1\n",
                                                                 src = [munchExp e1, munchExp e2], dst = [], jump = SOME([l1, l2])}) 
	| munchStm (T.CJUMP(T.LE, e1, e2, l1, l2)) = emit(A.OPER{assem = "ble `s0, `s1, `j0\nb `j1\n",
                                                                 src = [munchExp e1, munchExp e2], dst = [], jump = SOME([l1, l2])}) 
	| munchStm (T.CJUMP(T.LT, e1, e2, l1, l2)) = emit(A.OPER{assem = "blt `s0, `s1, `j0\nb `j1\n",
                                                                 src = [munchExp e1, munchExp e2], dst = [], jump = SOME([l1, l2])})                   
        | munchStm (T.CJUMP(T.EQ, e1, e2, l1, l2)) = emit(A.OPER{assem = "beq `s0, `s1, `j0\nb `j1\n",
                                                                 src = [munchExp e1, munchExp e2], dst = [], jump = SOME([l1, l2])})
	| munchStm (T.CJUMP(T.NE, e1, e2, l1, l2)) = emit(A.OPER{assem = "bne `s0, `s1, `j0\nb `j1\n",
                                                                 src = [munchExp e1, munchExp e2], dst = [], jump = SOME([l1, l2])})           
	| munchStm (T.EXP(T.CALL(T.NAME(lab), args))) = 
            let val pairs = map (fn r => (Temp.newtemp(), r)) (map #1 Frame.callersaves)
                val srcs = map #1 pairs
            in
              emit(A.OPER{assem = "jal " ^ Symbol.name(lab) ^ "\n",
                          src = munchArgs(0, args), dst = calldefs, jump = NONE});
              ()
            end 
	| munchStm (T.EXP e) = (munchExp e;())
        | munchStm (T.LABEL lab) = emit(A.LABEL{assem = Symbol.name lab ^ ":\n", lab = lab})
        | munchStm _ = ErrorMsg.impossible "Invlaid stm"
 
      and munchExp (T.MEM(T.CONST i)) = result(fn r => emit(A.OPER{assem = "lw `d0, " ^ tostring i ^"($ZERO)\n",                                                                                                                         src = [],dst = [r],jump = NONE}))
	| munchExp (T.MEM(T.BINOP(T.PLUS, e, T.CONST i))) = result(fn r => emit(A.OPER{assem = "lw `d0, " ^ tostring i ^ "(`s0)\n",
                                                                                       src = [munchExp e],dst = [r], jump = NONE}))
        | munchExp (T.MEM(T.BINOP(T.PLUS, T.CONST i, e))) = result(fn r => emit(A.OPER{assem = "lw `d0, " ^ tostring i ^ "(`s0)\n",
                                                                                       src = [munchExp e],dst = [r],jump = NONE}))
	| munchExp (T.MEM(T.BINOP(T.MINUS, e, T.CONST i))) = result(fn r => emit(A.OPER{assem = "lw `d0, " ^ Int.toString (~i) ^ "(`s0)\n",
                                                                                        src = [munchExp e],dst = [r], jump = NONE}))
        | munchExp (T.MEM(e)) = result(fn r => emit(A.OPER{assem = "lw `d0, 0(`s0)\n",
                                                            src = [munchExp e], dst = [r],jump = NONE}))
        (*add*)
        | munchExp (T.BINOP(T.PLUS, e, T.CONST i)) = result(fn r => emit(A.OPER{assem = "addi `d0, `s0, " ^ tostring i ^ "\n",
    src = [munchExp e],dst = [r],jump = NONE}))
        | munchExp (T.BINOP(T.PLUS, T.CONST i, e)) = result(fn r => emit(A.OPER{assem = "addi `d0, `s0, " ^ tostring i ^ "\n",
    src = [munchExp e],dst = [r],jump = NONE}))                            
        | munchExp (T.BINOP(T.PLUS, e1, e2)) =  result(fn r => emit(A.OPER{assem = "add `d0, `s0, `s1\n",
                                                                           src = [munchExp e1, munchExp e2],dst = [r],jump = NONE}))
        (*sub*)
	| munchExp (T.BINOP(T.MINUS, e, T.CONST i)) = result(fn r => emit(A.OPER{assem = "addi `d0, `s0, " ^ tostring(~i) ^ "\n",
                                                                                 src = [munchExp e], dst = [r], jump = NONE})) 
        | munchExp (T.BINOP(T.MINUS, e1, e2)) =  result(fn r => emit(A.OPER{assem = "sub `d0, `s0, `s1\n",
                                                                            src = [munchExp e1, munchExp e2],dst = [r],jump = NONE}))
        (*div*)
        | munchExp (T.BINOP(T.DIV, e1, e2)) =  result(fn r => emit(A.OPER{assem = "div `d0, `s0, `s1\n",
                                                                          src = [munchExp e1, munchExp e2],dst = [r],jump = NONE}))
        (*mul*)
        | munchExp (T.BINOP(T.MUL, e1, e2)) =  result(fn r => emit(A.OPER{assem = "mul `d0, `s0, `s1\n",
                                                                          src = [munchExp e1, munchExp e2],dst = [r],jump = NONE}))
        (*and*)
	| munchExp (T.BINOP(T.AND, e, T.CONST i)) = result(fn r => emit(A.OPER{assem = "andi `d0, `s0, " ^ tostring i ^ "\n",
                                                                               src = [munchExp e], dst = [r], jump = NONE}))  
	| munchExp (T.BINOP(T.AND, T.CONST i, e)) = result(fn r => emit(A.OPER{assem = "andi `d0, `s0, " ^ tostring i ^ "\n",
                                                                               src = [munchExp e], dst = [r], jump = NONE}))
	| munchExp (T.BINOP(T.AND, e1, e2)) = result(fn r => emit(A.OPER{assem = "and `d0, `s0, `s1\n",
                                                                         src = [munchExp e1, munchExp e2], dst = [r], jump = NONE}))  
        (*or*)
	| munchExp (T.BINOP(T.OR, e, T.CONST i)) = result(fn r => emit(A.OPER{assem = "ori `d0, `s0, " ^ tostring i ^ "\n",
                                                                              src = [munchExp e], dst = [r], jump = NONE}))  
	| munchExp (T.BINOP(T.OR, T.CONST i, e)) = result(fn r => emit(A.OPER{assem = "ori `d0, `s0, " ^ tostring i ^ "\n",
                                                                              src = [munchExp e], dst = [r], jump = NONE}))
	| munchExp (T.BINOP(T.OR, e1, e2)) = result(fn r => emit(A.OPER{assem = "or `d0, `s0, `s1\n",
                                                                        src = [munchExp e1, munchExp e2], dst = [r], jump = NONE}))    
        (*li*)
	| munchExp (T.CONST i) = result(fn r => emit(A.OPER{assem = "li `d0, "^ tostring i ^ "\n",
                                                            src=[], dst = [r], jump = NONE}))
        (*TEMP*)
        | munchExp (T.TEMP t) = t 
        (*la*)
	| munchExp (T.NAME lab) = result(fn r => emit(A.OPER{assem = "la `d0, "^Symbol.name lab ^ "\n",
                                                             src = [], dst = [r], jump = NONE})) 
  
	| munchExp (T.CALL(T.NAME(lab), args)) = 
            let val pairs = map (fn r => (Temp.newtemp(), r)) (map #1 Frame.callersaves)
                val srcs = map #1 pairs
                fun fetch (a, r) = T.MOVE(T.TEMP r, T.TEMP a)
                fun store (a, r) = T.MOVE(T.TEMP a, T.TEMP r)
            in
               result(fn r => emit(A.OPER{assem = "jal " ^ Symbol.name(lab) ^ "\n",
                          src = munchArgs(0, args), dst = calldefs, jump = NONE}));
              Frame.RV
            end 
	| munchExp _  = ErrorMsg.impossible "Invalid exp"

  and munchArgs (_, nil) = nil
    | munchArgs (i, exp ::rest) = 
        let val len = List.length(Frame.argregs) 
        in
          if i < len then
            let val dst = List.nth((map #1 Frame.argregs), i)
                val src = munchExp(exp)
            in
              munchStm(T.MOVE(T.TEMP dst, T.TEMP src));
              dst::munchArgs(i + 1, rest)
            end
          else ErrorMsg.impossible "To much arguements"
        end 
  in 
    munchStm stm;
    List.rev(!ilist)
  end

end
