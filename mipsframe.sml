structure MipsFrame : FRAME =
struct
  structure T = Tree

  datatype access =  InFrame of int
                   | InReg of Temp.temp
  (*type frame = {name: Temp.label, formals: access list, locals: int ref, offset:int ref, moveArg: T.stm}*)
  type frame = {label: Temp.label,
	        formals: access list,
		viewShiftInstns: T.stm,
		numVar: int ref,
		locals: int ref}
		   
  val wordSize = 4

  datatype frag = PROC of {body:Tree.stm, frame:frame}
		| STRING of Temp.label * string

  datatype register = Reg of string
  structure TempMap = Temp.Map
  val Impossible = ErrorMsg.impossible
  
  val FP = Temp.newtemp() 
  val RV = Temp.newtemp()
  val RA = Temp.newtemp()
  val SP = Temp.newtemp() 
  val ZERO = Temp.newtemp()

  val a0 = Temp.newtemp()   
  val a1 = Temp.newtemp()   
  val a2 = Temp.newtemp()   
  val a3 = Temp.newtemp()   

  val t0 = Temp.newtemp()  
  val t1 = Temp.newtemp()   
  val t2 = Temp.newtemp()   
  val t3 = Temp.newtemp()   
  val t4 = Temp.newtemp()   
  val t5 = Temp.newtemp()   
  val t6 = Temp.newtemp()   
  val t7 = Temp.newtemp()   
  val t8 = Temp.newtemp()   
  val t9 = Temp.newtemp()   
                            
  val s0 = Temp.newtemp()  
  val s1 = Temp.newtemp()   
  val s2 = Temp.newtemp()   
  val s3 = Temp.newtemp()   
  val s4 = Temp.newtemp()   
  val s5 = Temp.newtemp()   
  val s6 = Temp.newtemp()   
  val s7 = Temp.newtemp()   

  val tempMap = foldr (fn ((temp, regEntry), table) => TempMap.insert(table, temp, regEntry))
            TempMap.empty
            [(FP, Reg "$fp"),
             (RV, Reg "$v0"),
             (RA, Reg "$ra"),
             (SP, Reg "$sp"),
             (ZERO, Reg "$0"),
             (a0, Reg "$a0"),
             (a1, Reg "$a1"),
             (a2, Reg "$a2"),
             (a3, Reg "$a3"),
             (t0, Reg "$t0"),
             (t1, Reg "$t1"),
             (t2, Reg "$t2"),
             (t3, Reg "$t3"),
             (t4, Reg "$t4"),
             (t5, Reg "$t5"),
             (t6, Reg "$t6"),
             (t7, Reg "$t7"),
             (t8, Reg "$t8"),
             (t9, Reg "$t9"),
             (s0, Reg "$s0"),
             (s1, Reg "$s1"),
             (s2, Reg "$s2"),
             (s3, Reg "$s3"),
             (s4, Reg "$s4"),
             (s5, Reg "$s5"),
             (s6, Reg "$s6"),
             (s7, Reg "$s7")]

  val myTempMap = ref tempMap

  val specialregs =  [FP, RV, RA, SP, ZERO] 
  val argregs = [a0,a1,a2,a3]
  val argoffset = ref 0
  val calleesaves = [s0,s1,s2,s3,s4,s5,s6,s7] 
  val callersaves = [t0,t1,t2,t3,t4,t5,t6,t7,t8,t9] 
  
  fun lookreg temp =
      case TempMap.find(tempMap,temp) of
	  NONE => Impossible "No such register"
	| SOME(r) => r

    fun exp (InFrame(k)) = 
      let
	  fun getexp(framePointer) =
	     (print("const k is :"^Int.toString(k)^"\n");
	      Tree.MEM(Tree.BINOP(Tree.PLUS, framePointer, Tree.CONST(k))))
      in
       getexp
      end
    | exp (InReg(temp)) = 
      let
	  fun getexp(_) = Tree.TEMP(temp)
      in
          getexp
      end

	     
    fun seq nil = T.EXP(T.CONST 0)
      | seq [st] = st
      | seq (st::rest) = T.SEQ(st, seq(rest))
  
  fun tempname temp =
      case TempMap.find(tempMap,temp) of
	  NONE => Temp.makestring temp
	| SOME(Reg r) => r
  
  val registers = map lookreg (argregs @ calleesaves @ callersaves @ [RV, RA])				   
  fun name (f:frame) = #label f
  
  fun formals (f:frame) = #formals f
  
  (*fun allocLocal ({name = name, formals = formals, offset = offset, locals = locals,moveArg=moveArg}) =
      let 	  
	  fun allocLoc(escape) = if escape
				 then (offset := (!offset - wordSize);
				       (locals := !locals+1);
				       print "in allocLocal,offset = ";
				       print (Int.toString(!offset)^"\n");
				       InFrame(!offset))
				 else InReg(Temp.newtemp())
      in
	  allocLoc
      end*)

     fun allocLocal (frm:frame) true =
	let
	    val numVar = #numVar frm
	in
	    (*print "alloc local in frame";*)
	    numVar:= !numVar + 1;
	    InFrame(!numVar*(~4))
	end
      | allocLocal frm false = InReg(Temp.newtemp())
      
  (*fun newFrame ({name:Temp.label, formals = formals}) =
      let
	  val _ = argoffset:= 0
	  val offset = ref 0
          val viewshiftInsns = ref [] : T.stm list ref
	  val allocatedSL = (viewshiftInsns :=(!viewshiftInsns)@[T.MOVE(exp (InFrame(!offset)) (T.TEMP FP),T.TEMP (List.nth(argregs,0)))];
	                    InFrame(!offset))
	  val _ = argoffset:=(!argoffset)+1
	  fun allocFrame(escape) =
	      let
		  val temp = Temp.newtemp()
	      in
		  if escape
		  then (offset := !offset -wordSize;
			argoffset := ((!argoffset)+1);
			viewshiftInsns:=(!viewshiftInsns)@[T.MOVE(exp (InFrame(!offset))(T.TEMP FP), T.TEMP (List.nth(argregs,!argoffset)))];
			print ("escape in "^Symbol.name(name)^"\n");
			InFrame(!offset))
		  else (argoffset := (!argoffset+1);
			viewshiftInsns:=(!viewshiftInsns)@[T.MOVE(T.TEMP temp,T.TEMP(List.nth(argregs,!argoffset)))];
	                InReg(Temp.newtemp()))
	      end
	  val _= argoffset:=0
      in
	  {name = name, formals = allocatedSL::(map allocFrame formals),offset = offset, locals = ref 0, moveArg = seq(!viewshiftInsns)}
      end*)

       fun newFrame ({name: Temp.label, formals: bool list}) =
	let
	    val count = ref ~1
	    fun whereToGo true = (print "alloc formal in frame in newframe";count:=(!count)+1;InFrame(!count*(~4)))
	      | whereToGo false = (print "alloc formal in register in newframe";InReg(Temp.newtemp()))
	in
	    {formals = map whereToGo formals,
	     viewShiftInstns = T.MOVE(T.TEMP FP, T.TEMP SP),
	     numVar = count,
	     label = name,
	     locals = ref 0}
	end

    fun externalCall (funcname, args) =
       Tree.CALL(Tree.NAME(Temp.namedlabel funcname), args)

  
    (*fun procEntryExit1 (frame:frame,body) =
	let
	    val args = #moveArg frame
	    val label = #name frame
	    val offset = #offset frame
	    val _ = print ("offset:"^Int.toString(!offset))
	    val _ = offset := ((!offset) - 4)
	    val _ = print ("offset:"^Int.toString(!offset))
	    val fpSave = T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP SP, T.CONST(!offset))), T.TEMP FP)
	    val _ = offset := ((!offset) - 4)
	    val _ = print ("offset:"^Int.toString(!offset))
	    val spSave = T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP FP, T.CONST(!offset))), T.TEMP SP)
	    val fpUpdate = T.MOVE(T.TEMP FP, T.TEMP SP)
	    (*val _ = print ("offset:"^Int.toString(!offset))*)
	    val spUpdate = T.MOVE(T.TEMP SP, T.BINOP(T.PLUS, T.TEMP SP, T.CONST((!offset-40))))
	    val pairs = map (fn r => ((allocLocal frame true), r)) (RA::calleesaves) 
	    val saves = map (fn (a, r) => T.MOVE(exp a (T.TEMP FP), T.TEMP r)) pairs
            val restores = map (fn (a, r) => T.MOVE(T.TEMP r, exp a (T.TEMP FP))) (List.rev pairs)
	    val fpRestore = T.MOVE(T.TEMP FP, T.MEM(T.BINOP(T.PLUS, T.TEMP FP, T.CONST(!offset+36))))
	    (*val _ = offset := (!offset + 4)*)
	    val spRestore = T.MOVE(T.TEMP SP, T.MEM(T.BINOP(T.PLUS, T.TEMP FP, T.CONST(!offset+40))))
	    (*val _ = offset := (!offset + 4)*)
                   
          
	in
            seq([(*T.LABEL (Symbol.symbol("\009.globl"^(Symbol.name label))),
		 T.LABEL (Symbol.symbol("\009.ent "^(Symbol.name label))),
		 T.LABEL (Symbol.symbol("\009.text")),*)
		   T.LABEL label]@[fpSave,fpUpdate,spSave,spUpdate] @[args]@ saves @ [body] @[fpRestore,spRestore]@restores@[T.JUMP(T.TEMP RA, [])](*@[T.LABEL (Symbol.symbol("\009.end "^(Symbol.name label)))]*))
	end*)

    fun genSEQ [] = T.EXP(T.CONST 0)
      | genSEQ (first::nil) = first
      | genSEQ [first,second] = T.SEQ(first, second)
      | genSEQ (first::rest) = T.SEQ(first, genSEQ(rest))
				    
    fun procEntryExit1(frame:frame,body) =
	let
	    val {formals,viewShiftInstns,numVar,label,locals} = frame
	    fun plusAndGet() = (numVar := !numVar + 1; !numVar)						 
	    fun getAndMinus() = (numVar := !numVar - 1; !numVar+1)
	    fun genSave (reg, seq) = T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP FP, T.CONST(plusAndGet()*(~4)))), T.TEMP reg)::seq
	    val seqSave =
		let
		    val fpSave = T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP SP, T.CONST(plusAndGet()*(~4)))), T.TEMP FP)
		    val spSave = T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP FP, T.CONST(plusAndGet()*(~4)))), T.TEMP SP)
		    val fpUpdate = T.MOVE(T.TEMP FP, T.TEMP SP)
		    val spUpdate = T.MOVE(T.TEMP SP, T.BINOP(T.PLUS, T.TEMP SP, T.CONST((!numVar+10)*(~4))))
		in
		    genSEQ([fpSave,
			    fpUpdate,
			    spSave,
			    spUpdate]@
			   (foldr genSave [] (RA::calleesaves)))
		end
	    fun genRestore (reg, seq) = T.MOVE(T.TEMP reg, T.MEM(T.BINOP(T.PLUS, T.TEMP FP, T.CONST(getAndMinus()*(~4)))))::seq
	
	    val seqRestore =
		let
(*		    val fpRestore = T.MOVE(T.TEMP fp, T.MEM(T.BINOP(T.PLUS, T.TEMP fp, T.CONST(getAndMinus()*(~4)))))
		    val spRestore = T.MOVE(T.TEMP sp, T.MEM(T.BINOP(T.PLUS, T.TEMP fp, T.CONST(getAndMinus()*(~4)))))
*)		in
		    genSEQ(List.rev(foldl genRestore [] (RA::calleesaves@[SP, FP])))
		end
	    val cnt = ref ~1
	    fun genMove (loc, seq) = case loc of
					 InReg(t) => (cnt := !cnt+1; T.MOVE(T.TEMP t, T.TEMP(List.nth(argregs,!cnt)))::seq)
				       | InFrame(k) => (cnt := !cnt+1; T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP FP, T.CONST k)), T.TEMP(List.nth(argregs,!cnt)))::seq)
	    val seqMove = genSEQ(foldl genMove [] formals)
	    
	in
	    case body of T.EXP(e) => genSEQ([(*T.LABEL (Symbol.symbol("\009.globl "^(Symbol.name label))),
					     T.LABEL (Symbol.symbol("\009.ent "^(Symbol.name label))),
					     T.LABEL (Symbol.symbol("\009.text")),*)
					     T.LABEL label,
					     seqSave,
					     seqMove,
					     T.MOVE(T.TEMP RV, e),
					     seqRestore,
					     T.JUMP(T.TEMP RA, [])(*,
					     T.LABEL ((*Symbol.symbol("\009.end "^*)(Symbol.name label))*)])
		       | _ => genSEQ([(*T.LABEL (Symbol.symbol("\009.globl "^(Symbol.name label))),
				      T.LABEL (Symbol.symbol("\009.ent "^(Symbol.name label))),
				      T.LABEL (Symbol.symbol("\009.text")),*)
				      T.LABEL label,
				      seqSave,
				      seqMove,
				      body,
				      seqRestore,
				      T.JUMP(T.TEMP RA, [])(*,
				      T.LABEL ((*Symbol.symbol("\009.end "^*)(Symbol.name label))*)])
	end

    fun gettemp (temp,register) = temp

    fun procEntryExit2 (frame,body)=
	body @ [Assem.OPER{assem = "", src = specialregs@calleesaves, dst=[], jump=SOME[]}]

    fun procEntryExit3 (frame, body) =
      let (*val offset = (!locals + (List.length argregs)) * wordSize*)
      in
	{prolog = "",
	 body = body,
	 epilog = ""
         }
      end

  (*fun string (lab, str) = 
    let
      val l = String.size str
      fun countSlash(oneChar::rest, currCount) = 
        (case oneChar of 
          #"\\" => (case rest of
                    nextChar::rest2 => countSlash(rest2, currCount+1)
                    | _ => ErrorMsg.impossible "Escape string error: unclosed string because ending with \\ char!")
          | _ => countSlash(rest, currCount))
        | countSlash([], currCount) = currCount
      val numOfSlash = countSlash ((explode str), 0)
    in
      Symbol.name lab ^ ":\n\t.word " ^ (Int.toString (l-numOfSlash)) ^ "\n\t.ascii \"" ^ str ^ "\"\n"
    end*)
  fun string (lab,s) =
	let
	    val s = String.translate (fn c=> case c of
						 #"\n"=> "\092n"
					       | _ => (Char.toString c)) s
	    val len = String.size(s)
	in
	    ".data\n.align 4\n"
	    ^ Symbol.name lab ^ ":\n"
	    ^ "\009.word " ^ Int.toString(len)^"\n"
	    ^ "\009.asciiz \034"^s^"\034\n"
	end
end
