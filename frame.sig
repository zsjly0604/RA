signature FRAME =
sig type frame
    type access
    
    datatype frag =  PROC of {body: Tree.stm, frame: frame}
                   | STRING of Temp.label * string
    datatype register = Reg of string
    (*datatype regs = Regs of Temp.temp * register*)
    val tempMap: register Temp.Map.map
    val FP : Temp.temp
    val SP : Temp.temp
    val RV : Temp.temp
    val RA : Temp.temp
    val ZERO : Temp.temp

    val wordSize : int
    
    val specialregs : Temp.temp  list
    val argregs : Temp.temp list
    val callersaves : Temp.temp list
    val calleesaves : Temp.temp list

    val registers : register list

    val name : frame -> Temp.label
    val formals : frame -> access list
    
    val exp : access -> Tree.exp -> Tree.exp
    val newFrame : {name: Temp.label, formals: bool list} -> frame
    val allocLocal : frame -> bool -> access
    val externalCall : string * Tree.exp list -> Tree.exp
    val procEntryExit1 : frame * Tree.stm -> Tree.stm
    val procEntryExit2 : frame * Assem.instr list -> Assem.instr list
    val procEntryExit3 : frame * Assem.instr list -> {prolog : string, body : Assem.instr list, epilog : string}
    val gettemp : Temp.temp * register -> Temp.temp
    val lookreg : Temp.temp -> register
end
