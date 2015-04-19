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
                let val newt = Temp.newtemp()
                in                
                  if List.exists (fn x => x = t) dus then (gen_instrs(is_def, newt), map (fn x => if x = t then newt else x) dus)
                  else ([], dus)
                end

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

  fun alloc (instrs, frame)  =
    let val (flowGraph, nodeList,llist) = MakeGraph.instrs2graph(instrs)
        val iGraph = Liveness.interferenceGraph (flowGraph, nodeList,llist) 
        val (colored, spilledNodes) = Color.color{interference = iGraph, initialAlloc = Frame.tempMap, registers = Frame.registers}
        fun is_redundant instr =
          case instr of
              Assem.MOVE{assem,dst,src} =>
              valOf(Temp.Map.find(colored,dst)) = valOf(Temp.Map.find(colored,src))
            | _ => false 
    in
        if spilledNodes = [] then (List.filter (fn i => not (is_redundant i)) instrs,colored)
        else alloc(rewrite(instrs, frame, spilledNodes), frame)
     end
end
