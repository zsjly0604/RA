structure RegAlloc : REG_ALLOC =
struct
  structure Frame = MipsFrame
  type allocation = Frame.register Temp.Table.table

  fun alloc (instrs, iGraph, frame)  =
    let fun tempname (alloc, temp) =
          case Temp.Table.look(alloc, temp) of
            SOME(r) => r
	   | NONE => Frame.lookreg temp        
         val (colored, spilledNodes) = Color.color{interference = iGraph, initialAlloc = Frame.tempMap, registers = Frame.registers}
     in
        (instrs, colored)
     end
end
