structure RegAlloc : REG_ALLOC =
struct
  structure Frame = MipsFrame
  type allocation = Frame.register Temp.Map.map

  fun rewrite (instrs, frame, spilledNodes) =
    let fun rewrite1 (instrs, t) =
          let val ae = Frame.exp (Frame.allocLocal(frame) true) (Tree.TEMP Frame.FP)
              fun gen_instrs (is_def, t) =
                if is_def then MipsGen.codegen (Tree.MOVE(ae, Tree.TEMP t)) else MipsGen.codegen(Tree.MOVE(Tree.TEMP t, ae))

              fun alloc_du (is_def, dus, t) =
                if List.exists (fn x => x = t) dus then (gen_instrs(is_def, Temp.newtemp()), map (fn x => if x = t then Temp.newtemp() else x) dus)
                else ([], dus)

              fun trans_instr instr =
                case instr of
                    Assem.OPER{assem,dst,src,jump} =>
                    let val (store,dst') = alloc_du(true,dst,t)
                        val (fetch,src') = alloc_du(false,src,t)
                    in (fetch@[Assem.OPER{assem=assem,dst=dst',
                                      src=src',jump=jump}]@store)
                    end
                  | Assem.MOVE{assem,dst,src} =>
                    let val (store,[dst']) = alloc_du(true,[dst],t)
                        val (fetch,[src']) = alloc_du(false,[src],t)
                    in (fetch@[Assem.MOVE{assem=assem,dst=dst',src=src'}]@store)
                    end
                  | instr => [instr]
          in
            List.foldl (fn (i,acc) => acc @ trans_instr i) nil instrs
          end
      in
        List.foldl (fn (t,ins) => rewrite1(ins,t)) instrs spilledNodes
    end
 
  fun alloc (instrs, iGraph, frame)  =
    let fun tempname (alloc, temp) =
          case Temp.Table.look(alloc, temp) of
            SOME(r) => r
	   | NONE => Frame.lookreg temp        
         val (colored, spilledNodes) = Color.color{interference = iGraph, initialAlloc = Frame.tempMap, registers = Frame.registers}
     in
        if spilledNodes = [] then (instrs, colored)
        else alloc(rewrite(instrs, frame, spilledNodes), iGraph, frame)
     end
end
