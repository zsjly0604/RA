structure Translate : TRANSLATE = 
struct
  structure A = Absyn
  structure T = Tree
  structure F = MipsFrame

  datatype exp =  Ex of T.exp
                | Nx of T.stm
                | Cx of Temp.label * Temp.label -> T.stm 
    
  datatype level =  outermost
                  | nestLevel of {frame: F.frame, parent: level} * unit ref
  
  type access = level * F.access
  type frag = F.frag
  
  val frags = ref []: frag list ref
  val Impossible = ErrorMsg.impossible

   fun seq ([s]) = s
     | seq (h::t) = T.SEQ(h, seq(t)) 
     | seq [] = Impossible "Can't seq empty list"
   
   fun unEx (Ex e) = e
     | unEx (Cx genstm) = let val r = Temp.newtemp()
                              val t = Temp.newlabel() and f = Temp.newlabel()
                          in
                            T.ESEQ(seq[T.MOVE(T.TEMP r, T.CONST 1),
                                      genstm(t, f),
                                      T.LABEL f,
                                      T.MOVE(T.TEMP r, T.CONST 0),
                                      T.LABEL t],
                                      T.TEMP r)
                         end
     | unEx (Nx s) = case s of 
                        T.EXP(exp) => exp 
		      | _  => T.ESEQ(s, T.CONST 0)

   fun unNx (Ex e) = T.EXP e
     | unNx (Cx genstm) = let val t = Temp.newlabel() and f = Temp.newlabel()
                          in
                            genstm(t, f)
                          end
     | unNx (Nx s) = s

   fun unCx (Ex e) = (fn (t, f) => T.CJUMP(T.EQ, e, T.CONST 1, t, f))
     | unCx (Cx genstm) = genstm
     | unCx (Nx s) = (Printtree.printtree(TextIO.stdOut, s);
                      Impossible "Can't convert Nx to Cx")  
  
   fun newLevel ({parent: level, name: Temp.label, formals: bool list}) =
      let
	  val formals' = true::formals
	  val newframe = F.newFrame({name=name, formals = formals'})
      in
	  nestLevel({parent=parent, frame=newframe}, ref())
      end

  fun allocLocal (nestLevel({parent=parent, frame=frame}, unique)) = 
    let 
      fun allocL (escape:bool) = 
        let
          val frameAccess = F.allocLocal frame escape
        in
          (nestLevel({parent=parent, frame=frame}, unique), frameAccess)
        end
    in
      allocL
    end
    | allocLocal(outermost) = (Impossible "Error: cannot allocal local variable in ROOT level!")

  fun procEntryExit ({level= outermost, body=body}) = (Impossible "Error: no function should be at the ROOT level!")       
    | procEntryExit ({level= nestLevel ({frame=frame, parent=parent}, unique), body = body}) = 
    let
      val body' = F.procEntryExit1(frame, unNx body)
      val moveStm = T.MOVE(T.TEMP F.RV, unEx body)
    in
      frags := (F.PROC {body = moveStm, frame = frame})::(!frags)
    end

   fun formals (outermost) = (Impossible "no formals at outermost")
     | formals (nestLevel({parent=parent, frame=frame}, unique)) =
       let
	   val frameformals = #formals frame
	   fun makeTformal (level, []) = []
	     | makeTformal (level, frameformals::tail) = (level,frameformals)::makeTformal(level,tail)
       in
	   makeTformal(nestLevel({parent=parent,frame=frame},unique),frameformals)
       end
	       
   fun followSL (nestLevel(defLevel), outermost) = T.TEMP F.FP
     | followSL (outermost, _) = Impossible "No function defined at outermost"
     | followSL (nestLevel(defLevel), nestLevel(useLevel)) =
      let val dref = #2 defLevel
          val uref = #2 useLevel
          val {frame = uframe, parent = uparent} = #1 useLevel
      in
        if dref = uref then T.TEMP(F.FP)
        else
          let val locals = #locals uframe
          in
            T.MEM(T.BINOP(T.PLUS, T.CONST (!locals), followSL(nestLevel(defLevel), uparent)))  
          end
       end

  fun reset () = frags := nil 
  fun getResult () = !frags

  fun newDoneLabel () = Temp.newlabel()
  
  val mainLevel = newLevel({name = Temp.namedlabel "main", formals = [], parent = outermost})

  fun nilExp () = Ex(T.CONST 0)

  fun intExp (n) = Ex(T.CONST n)
 
  fun stringExp (str) = 
    let val strExist = List.find(fn (x) => case x of
                               F.PROC(_) => false
                             | F.STRING(lab, s) => s = str) (!frags)
    in
      case strExist of
          SOME(F.STRING(lab, s)) => Ex(T.NAME lab)
        | NONE => let val lab = Temp.newlabel()
                  in
                     !frags = F.STRING(lab, str) :: (!frags);
                     Ex(T.NAME lab)
                  end
	| _  => Impossible "string can't stored as function"
     end  

  fun simpleVar ((defLevel, frameAccess), useLevel) =
    let val staticLink = followSL(defLevel, useLevel)
        val varBase = F.exp(frameAccess) staticLink
    in    
        Ex(F.exp(frameAccess) staticLink)
    end
  
  fun subscriptVar (arrayBase, index) =
    let val arrayBase = unEx arrayBase
        val index = unEx index
    in
       Ex(T.MEM(T.BINOP(T.PLUS, arrayBase, T.BINOP(T.MUL, T.CONST(F.wordSize), index)))) 
    end

  fun fieldVar (recordBase, index) =
    let val recordBase = unEx recordBase
    in
      Ex(T.MEM(T.BINOP(T.PLUS, recordBase, T.CONST (F.wordSize * index))))
    end

  fun assignExp (left, right) =
    let val left = unEx left
        val right = unEx right
    in
      Nx(T.MOVE(left, right))
    end

  fun seqExp (expFront, expLast) =
      case expFront of
          [] => (case expLast of
                  Nx(s) => expLast
		| _ => Ex(unEx expLast))
	 | _  => (case expLast of
                  Nx(s) => Nx(T.SEQ(seq(map unNx expFront), s))
		| _ => Ex(T.ESEQ(seq(map unNx expFront), unEx expLast)))

  fun binop (oper, left, right) =
     let val troper = case oper of
                         A.PlusOp => T.PLUS
		       | A.MinusOp => T.MINUS
		       | A.TimesOp => T.MUL
		       | A.DivideOp => T.DIV
		       | _ => Impossible "Invalid binop operator"
         val left = unEx left
         val right = unEx right
     in
       Ex(T.BINOP(troper, left, right))
     end
   
  fun relop (oper, left, right) =
    let val troper = case oper of
                        A.LeOp => T.LE
		      | A.LtOp => T.LT
		      | A.GeOp => T.GE
		      | A.GtOp => T.GT
		      | A.EqOp => T.EQ
		      | A.NeqOp => T.NE
		      | _ => Impossible "Invalid relop operator" 
         val left = unEx left
         val right = unEx right
    in
      Cx(fn(t, f) => T.CJUMP(troper, left, right, t, f))
    end      

  fun ifthenExp (test, then') =
    let val t = Temp.newlabel() and f = Temp.newlabel()
        val test = unCx test
        val then' = unNx then'
    in
      Nx(seq[test(t, f),
             T.LABEL t,
             then',
             T.LABEL f])
    end

   fun ifthenelseExp (test, then', else') =
    let val r = Temp.newtemp()
        val t = Temp.newlabel() and f = Temp.newlabel()
        val done_label = Temp.newlabel()
        val test = unCx test
    in
        Ex(T.ESEQ(seq[T.MOVE(T.TEMP r, unEx(then')), 
                                   test(t, f),
                                   T.LABEL f,
                                   T.MOVE(T.TEMP r, unEx(else')),
                                   T.LABEL t],
                       T.TEMP r))
    end

  fun whileExp (test, body, SOME(done_label)) =
    let val test_label = Temp.newlabel() and body_label = Temp.newlabel()
        val test = unCx test
        val body = unNx body
    in 
      Nx(seq[T.LABEL test_label,
             test(body_label, done_label),
             T.LABEL body_label,
             body,
             T.JUMP(T.NAME test_label, [test_label]),
             T.LABEL done_label])
    end
    | whileExp (test, body, NONE) = Impossible "While loop done_label can't be NONE" 
  
  fun forExp (var, lo, hi, body, SOME(done_label)) =
    let val body_label = Temp.newlabel()
        val var = unEx var
        val lo = unEx lo
        val hi = unEx hi
    in
      Nx(seq[T.MOVE(var, lo),
             T.CJUMP(T.LE, var, hi, body_label, done_label),
             T.LABEL body_label,
             unNx body,
             T.MOVE(var, T.BINOP(T.PLUS, var, T.CONST 1)),
             T.CJUMP(T.LT, var, hi, body_label, done_label),
             T.LABEL done_label
             ])
    end
    | forExp (var, lo, hi, body, NONE) = Impossible "For loop done_label can't be NONE" 

   fun breakExp (done_label) = case done_label of
                                 SOME(lab) => Nx(T.JUMP(T.NAME lab, [lab]))
			       | NONE => Impossible "Can't break at label NONE" 

   fun callExp (defLevel, funcLabel, useLevel, args, isprocedure) = 
     let val staticLink = if defLevel = mainLevel then [] 
                          else [followSL(defLevel, useLevel)] 
         val Exargs = map unEx args
     in
       case isprocedure of
          true => Nx(T.EXP(T.CALL(T.NAME funcLabel, staticLink@Exargs)))
	| false =>Ex(T.CALL(T.NAME funcLabel, staticLink@Exargs)) 
     end
                                  
   fun recordExp (fields) = 
     let val r = Temp.newtemp()
         val size = List.length(fields)
         val recordBase = T.MOVE(T.TEMP r, F.externalCall("allocRecord", [T.CONST (size * F.wordSize)]))
         fun initialize (fields, index) =
           case fields of
             [] => []
	   | h::t => T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP r, T.CONST (F.wordSize * index))), unEx(h))::initialize(t, index + 1)
     in
        Ex(T.ESEQ(seq(recordBase::initialize(fields, 0)), T.TEMP r))
     end

  fun arrayExp (size, init) =
     Ex(F.externalCall("initArray", [unEx size, unEx init]))

end
