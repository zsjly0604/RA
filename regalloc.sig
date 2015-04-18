signature REG_ALLOC = 
sig
  structure Frame : FRAME
  type allocation = Frame.register Temp.Map.map
  val rewrite : Assem.instr list * Frame.frame * Temp.temp list -> Assem.instr list
  val alloc : Assem.instr list * Liveness.igraph * Frame.frame -> Assem.instr list * allocation
end
