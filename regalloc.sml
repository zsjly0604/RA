structure RegAlloc : REG_ALLOC =
struct
  structure Frame = MipsFrame
  type allocation = Frame.register Temp.Map.map

  fun alloc (instrs, frame) : Assem.instr list * allocation =
  let
     fun 
