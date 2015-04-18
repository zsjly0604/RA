signature CODEGEN = 
sig
  structure Frame : FRAME
  val codegen : Tree.stm -> Assem.instr list
end
