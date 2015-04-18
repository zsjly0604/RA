signature FRAME =
sig type frame
    type access
    
    datatype frag =  PROC of {body: Tree.stm, frame: frame}
                   | STRING of Temp.label * string
    datatype register = Reg of string
    (*datatype regs = Regs of Temp.temp * register*)
    val tempMap: register Temp.table
    val FP : Temp.temp
    val SP : Temp.temp
    val RV : Temp.temp
    val RA : Temp.temp
    val wordSize : int
    
    val argregs : (Temp.temp * register) list
    val callersaves : (Temp.temp * register) list
    val calleesaves : (Temp.temp * register) list

    val name : frame -> Temp.label
    val formals : frame -> access list

    val exp : access -> Tree.exp -> Tree.exp
    val newFrame : {name: Temp.label, formals: bool list} -> frame
    val allocLocal : frame -> bool -> access
    val externalCall : string * Tree.exp list -> Tree.exp
    val procEntryExit1 : frame * Tree.stm -> Tree.stm
    val lookreg : Temp.temp -> string
end
