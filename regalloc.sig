signature REG_ALLOC = 
sig
  structure Frame : FRAME
  type allocation = Frame.register Temp.Table.table
  val alloc : Assem.instr list * Liveness.igraph * Frame.frame -> Assem.instr list * allocation
end
