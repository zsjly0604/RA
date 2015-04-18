signature SEMANT =
sig
  type venv = Env.enventry Symbol.table
  type tenv = Types.ty Symbol.table
  type expty = {exp: Translate.exp, ty: Types.ty}

  val transExp: (venv * tenv * Translate.level * Temp.label option) ->  Absyn.exp -> expty
  val transVar: (venv * tenv * Translate.level * Temp.label option) -> Absyn.var -> expty
  val transDec: venv * tenv * Absyn.dec * Temp.label option * Translate.level * Translate.exp list-> {venv: venv, tenv: tenv, explist: Translate.exp list}
  val transTy:  tenv * Absyn.ty -> Types.ty
  val transProg: Absyn.exp -> Translate.frag list
end

structure Semant :> SEMANT = struct
  structure A = Absyn
  structure Ty = Types
  structure Tr = Translate

  type venv = Env.enventry Symbol.table
  type tenv = Ty.ty Symbol.table
  type expty = {exp: Tr.exp, ty: Ty.ty}
  val err = ErrorMsg.error
   
  fun actual_ty (Ty.NAME(s, ty)) =
    (case !ty of
         NONE => Ty.NAME(s,ty)
      | SOME t => actual_ty t)
    | actual_ty t = t 

  fun checkInt (ty, pos, des) =
    case ty of
      Ty.INT => true
    | _ => (err pos ("Integer required: " ^ des);false)
  
  fun checkString (ty, pos, des) =
    case ty of
        Ty.STRING => true
       |_  => (err pos ("String required: " ^ des);false)
  
  fun checkUnit (ty, pos, des) =
    case ty of
        Ty.UNIT => true
	| _ => (err pos ("Unit required: " ^ des);false)

  fun checkRecord (ty, pos, des) =
    case ty of
        Ty.RECORD(slist,unique) => true
	| _ => (err pos ("Record required: " ^ des);false)

  fun checkArray (ty, pos, des) =
    case ty of
        Ty.ARRAY(ty, unique) => true
	| _ => (err pos ("Array required: " ^ des);false)

  fun compareTypePair (tyspec, tyactual, pos) = 
    let val tyactual' = actual_ty tyactual
        val tyspec' = actual_ty tyspec
    in
      if tyactual' = Ty.NIL then case tyspec' of
                                        Ty.RECORD(slist,unique) => true
                                      | _ => false
      else (tyspec' = tyactual')
    end

  fun compareTypeList (tyspec, tyactual, pos) = 
    ListPair.allEq(fn (ty1, ty2) => compareTypePair(ty1, ty2, pos)) (tyspec, tyactual)
      
  fun lookType (tenv, id, pos) = 
    case Symbol.look(tenv, id) of
       SOME ty => actual_ty ty
     | NONE =>  (err pos ("Undefined Type: " ^ Symbol.name id);
                 Ty.UNIT)

  fun indexOf (a, lst) =
    let fun indexOfAcc(a, [], acc) = ~1
	  | indexOfAcc(a, h::l, acc) =
              if (a = h) then acc
              else indexOfAcc(a, l, acc+1)
    in
       indexOfAcc(a, lst, 0)
    end
 
  (*fun printType (Ty.INT, pos) = err pos "Integer"
    | printType (Ty.STRING, pos) = err pos "String"
    | printType (Ty.ARRAY(ty, unique), pos) = err pos "Array"
    | printType (Ty.RECORD(slist, unique), pos) = err pos "Record"
    | printType (Ty.UNIT, pos) = err pos "Unit"
    | printType (Ty.NAME(n,nref),pos) = err pos "Name"
    | printType (Ty.NIL, pos)= err pos "NIL" *)

  fun checkname [] = false
    | checkname (name::ns) = (List.exists(fn n => n = name) ns) orelse (checkname ns)
		     
  fun transTy (tenv, ty) =
    let fun checkDups [] = false 
          | checkDups (a::l) = (List.exists (fn {name, escape, typ, pos} => if name = (#name a) then  (err pos ("Duplicate field names." ^ Symbol.name name);true)
                                                                            else false) l;
                                checkDups(l))  
        fun recordtys(fields) = map (fn{name, escape, typ, pos} => case SOME(lookType(tenv, typ, pos)) of
                 SOME t => (name, t)
               | NONE => (name,Ty.UNIT)) fields   
    in
      case ty of
        A.NameTy(n, pos) => lookType(tenv, n, pos)
       | A.RecordTy fields => (checkDups fields; Ty.RECORD(recordtys(fields), ref()))
       | A.ArrayTy(n, pos) => Ty.ARRAY(lookType(tenv, n, pos), ref())
    end

    fun transExp (venv, tenv, level, loop_done_label) =
	let fun trexp (A.NilExp) = {exp = Tr.nilExp(), ty = Ty.NIL}
	  | trexp (A.VarExp var) = transVar(venv, tenv, level, loop_done_label) var
	  | trexp (A.IntExp i) = {exp = Tr.intExp(i), ty = Ty.INT} 
	  | trexp (A.StringExp (str, pos))  = {exp = Tr.stringExp(str), ty = Ty.STRING}
	  | trexp (A.CallExp{func, args, pos}) = 
              let val trargs = map trexp args
                  val expargs = map #exp trargs
                  val tyargs = map #ty trargs
              in
                case Symbol.look(venv, func) of
                  SOME(Env.FunEntry{level = funcLevel, label = funcLabel, formals=tyformals, result=tyresult}) => if List.length(tyformals) <> List.length(tyargs) then (err pos ("Number of function parameters is wrong: "^Symbol.name func); {exp = Tr.nilExp(), ty=Ty.UNIT})
                                                                                                                else if compareTypeList(tyformals, tyargs, pos) then {exp = Tr.callExp(funcLevel, funcLabel, level, expargs, tyresult = Ty.UNIT), ty = tyresult}
                                                                                                                     else (err pos ("Function parameter type mismatch: " ^ Symbol.name func);{exp = Tr.nilExp(), ty = Ty.UNIT})
                  | _  => (err pos ("Undefined function: " ^ Symbol.name func);
                      {exp = Tr.nilExp(), ty = Ty.UNIT}) 
              end
	  | trexp (A.OpExp{left, oper, right, pos})  =
              let val {exp = expleft, ty = tyleft} = trexp left
                  val {exp = expright, ty = tyright} = trexp right
                  val operType =  if (oper = A.PlusOp orelse oper = A.MinusOp orelse oper = A.TimesOp orelse oper = A.DivideOp) then "math"
                                  else if (oper = A.LtOp orelse oper = A.LeOp orelse oper = A.GtOp orelse oper = A.GeOp) then "inequality"
                                       else if (oper = A.EqOp orelse oper = A.NeqOp) then "equality"
                                            else "error"
              in        
                  case operType of
                    "math" => if (checkInt(tyleft, pos, "Calculation") andalso checkInt(tyright, pos, "Calculation")) then {exp = Tr.binop(oper, expleft, expright), ty = Ty.INT}
                              else {exp = (Tr.nilExp()), ty = Ty.UNIT}
                   | "inequality" => (case tyleft of
                                      Ty.INT => if checkInt(tyright, pos, "Comparison") then {exp = Tr.relop(oper, expleft, expright),  ty = Ty.INT}
                                                   else {exp = Tr.nilExp(), ty = Ty.UNIT}
		                    | Ty.STRING => if checkString(tyright, pos, "Comparison") then {exp = Tr.relop(oper, expleft, expright),  ty = Ty.INT}
                                                      else {exp = Tr.nilExp(), ty = Ty.UNIT}  
                                    | _  => (err pos "Can't compare inequality";{exp = Tr.nilExp(), ty = Ty.UNIT}))
	           | "equality" => (case tyleft of
                                     Ty.INT => if checkInt(tyright, pos, "Comparison") then {exp = Tr.relop(oper, expleft, expright),  ty = Ty.INT}
                                                  else {exp = Tr.nilExp(), ty = Ty.UNIT}
		                    | Ty.STRING => if checkString(tyright, pos, "Comparison") then {exp = Tr.relop(oper, expleft, expright),  ty = Ty.INT}
                                                      else {exp = Tr.nilExp(), ty = Ty.UNIT}  
                                    | Ty.RECORD(slist, unique) => if ((tyright = Ty.NIL) orelse (checkRecord(tyright, pos, "Comparison"))) then {exp = Tr.relop(oper, expleft, expright),  ty = Ty.INT}
                                                                     else {exp = Tr.nilExp(), ty = Ty.UNIT}
                                    | Ty.ARRAY(ty, unique) => if checkArray(tyright, pos, "Comparison") then {exp = Tr.relop(oper, expleft, expright),  ty = Ty.INT}
                                                                 else {exp = Tr.nilExp(), ty = Ty.UNIT}
                                    | Ty.NIL => if checkRecord(tyright, pos, "Comparison") then {exp = Tr.relop(oper, expleft, expright),  ty = Ty.INT}
                                                   else {exp = Tr.nilExp(), ty = Ty.UNIT}
			            | _  => (err pos "Can't compare equality";{exp = Tr.nilExp(), ty = Ty.UNIT}))
	            | _  =>    (err pos "Illegal comparison operator";{exp = Tr.nilExp(), ty = Ty.UNIT})
              end
	  | trexp (A.RecordExp{fields, typ, pos})  = 
              let val tyrecord = lookType(tenv, typ, pos)
                  val fieldnames = map #1 fields
                  val trfields = map trexp (map #2 fields)
                  val tyfields = map #ty trfields
                  val expfields = map #exp trfields
              in
                case tyrecord of
                  Ty.RECORD(slist, unique) => let val decfieldnames = map #1 slist
                                                     val decfieldtypes = map actual_ty (map #2 slist)
                                                 in
                                                   if decfieldnames = fieldnames then if compareTypeList(decfieldtypes, tyfields, pos) then {exp = Tr.recordExp(expfields), ty = tyrecord}                                    
                                                                                      else (err pos ("Record field types mismatch: " ^ Symbol.name typ);
                                                                                            {exp = Tr.nilExp(), ty = Ty.UNIT}) 
                                                   else (err pos ("Record field names mismatch: " ^ Symbol.name typ);
                                                         {exp = Tr.nilExp(), ty = Ty.UNIT})
                                                 end
	       | _ =>  (err pos ("Undefined record: " ^ Symbol.name typ);
                        {exp = Tr.nilExp(),  ty = Ty.UNIT})
            end
	| trexp (A.SeqExp expposList)  =
            let val expList = map #1 expposList
                val trexpList = map trexp expList
                val expexpList = map #exp trexpList
                val tyexpList = map #ty trexpList
                val length = List.length(expexpList) 
            in  
               case length of
                  0 => {exp = Tr.nilExp(), ty = Ty.UNIT}
		| _  => {exp = Tr.seqExp(List.take(expexpList, length - 1), List.last(expexpList)),  ty = List.last(tyexpList)}
            end
	| trexp (A.AssignExp{var, exp, pos})  =
            let val {exp = expspec, ty = tyspec} = transVar(venv, tenv, level, loop_done_label) var
                val {exp = expactual, ty = tyactual} = trexp exp
            in 
              if compareTypePair(tyspec, tyactual, pos) then {exp = Tr.assignExp(expspec, expactual),  ty = Ty.UNIT}
              else (err pos "Assignment type mismatch";
                   {exp = Tr.nilExp(), ty = Ty.UNIT})
            end
	| trexp (A.IfExp{test, then', else', pos}) =
            let val {exp = exptest, ty = tytest} = trexp test
                val {exp = expthen', ty = tythen'} = trexp then'
            in
              case else' of 
                NONE => if (checkInt(tytest, pos, "If condition") andalso checkUnit(tythen', pos, "Then condition")) then {exp = Tr.ifthenExp(exptest, expthen'), ty = Ty.UNIT}
                        else {exp = Tr.nilExp(), ty = Ty.UNIT}
	      | SOME(else'_exp) => 
                  let val {exp = expelse', ty = tyelse'} = trexp else'_exp
                  in
                    if checkInt(tytest, pos, "If condition") then 
                       if compareTypePair(tythen',tyelse', pos) then {exp = Tr.ifthenelseExp(exptest, expthen', expelse'), ty = tythen'}
                       else (err pos "Then-else type mismatch";{exp = Tr.nilExp(), ty = Ty.UNIT})
                    else {exp = Tr.nilExp(), ty = Ty.UNIT}
                  end
            end
	| trexp (A.WhileExp{test, body, pos}) =
            let val {exp = exptest, ty = tytest} = trexp test
                val done_label = SOME(Tr.newDoneLabel())
                val {exp = expbody, ty = tybody} = transExp(venv, tenv, level, done_label) body         
            in
               if (checkInt(tytest, pos, "While loop condition") andalso checkUnit(tybody, pos, "While loop body")) then {exp = Tr.whileExp(exptest, expbody, done_label), ty = Ty.UNIT}
                else {exp = Tr.nilExp(), ty = Ty.UNIT}
            end
	| trexp (A.ForExp{var, escape, lo, hi, body, pos}) =
            let val {exp = explo, ty = tylo} = trexp lo
                val {exp = exphi, ty = tyhi} = trexp hi
		val access = Tr.allocLocal level (!escape)
                val new_venv = Symbol.enter(venv, var, Env.VarEntry{access=access,ty=Ty.INT})    
                val done_label = SOME(Tr.newDoneLabel())
                val {exp = expbody, ty = tybody} = transExp(new_venv, tenv, level, done_label) body
            in
              if (checkInt(tylo, pos, "For loop low bound") andalso checkInt(tyhi, pos, "For loop high bound") andalso checkUnit(tybody, pos, "For loop body")) then {exp = Tr.forExp(Tr.simpleVar(access, level), explo, exphi, expbody, done_label), ty = Ty.UNIT}
              else {exp = Tr.nilExp(), ty = Ty.UNIT}
            end
	| trexp (A.BreakExp pos) = 
            if loop_done_label = NONE then (err pos "Break not inside a loop.";
                                           {exp = Tr.nilExp(), ty = Ty.UNIT})
            else {exp = Tr.breakExp(loop_done_label), ty = Ty.UNIT}
	| trexp (A.LetExp{decs, body, pos}) =
          let
	      fun transOne(oneDec, {venv=venv, tenv=tenv, explist=initlist})=
		  transDec(venv,tenv,oneDec, loop_done_label, level, initlist)
	      val {venv = venv', tenv = tenv', explist = explist'} = foldl transOne {venv=venv, tenv=tenv, explist=[]} decs
	      val {exp = bodyexp, ty= bodyty} = transExp(venv',tenv', level, loop_done_label) body
          in   
	       {exp = Tr.seqExp(List.rev(explist'), bodyexp), ty = bodyty}
          end
	| trexp (A.ArrayExp{typ, size, init, pos})  =
            let val {exp = expsize, ty = tysize} = trexp size
                val {exp = expinit, ty = tyinit} = trexp init
                val tytyp = lookType(tenv, typ, pos)
            in
              if checkInt(tysize, pos, "Array size") then
                (case tytyp of 
                  Ty.ARRAY(ty, unique) => if compareTypePair(ty, tyinit, pos) then {exp = Tr.arrayExp(expsize, expinit), ty = tytyp}
                                             else (err pos "Array-init type mismatch";{exp = Tr.nilExp(), ty =tytyp})
                 |_  => (err pos ("Undefined array: "^Symbol.name typ);
                        {exp = Tr.nilExp(), ty = Ty.UNIT}))
              else {exp = Tr.nilExp(), ty = Ty.UNIT}
            end
	in
	    trexp
	end
 
    and transVar (venv, tenv, level, loop_done_label) =
      let fun trvar (A.SimpleVar(id, pos)) =
                (case Symbol.look(venv, id) of
                   SOME (Env.VarEntry{access = access, ty = ty}) => {exp = Tr.simpleVar(access, level), ty = actual_ty ty}
                  | _  => (err pos ("Undefined variable: " ^ Symbol.name id);
                           {exp = Tr.nilExp(), ty = Ty.UNIT}))
          | trvar (A.FieldVar(var, id, pos))  =
              let val {exp = expvar, ty = tyvar} = trvar var
              in
                case tyvar of
                  Ty.RECORD(slist, unique) => let val fieldnames = map #1 slist
                                                     val fieldtypes = map #2 slist
                                                     val index = indexOf(id, fieldnames)
                                                 in
                                                    if index = ~1 then (err pos ("No such field in record");
                                                                        {exp = Tr.nilExp(), ty = Ty.UNIT})
                                                    else {exp = Tr.fieldVar(expvar, index), ty = List.nth(fieldtypes, index)}
                                                 end
                  | _  => (err pos ("Undefined record");
                           {exp = Tr.nilExp(), ty = Ty.UNIT})
               end
      | trvar (A.SubscriptVar(var, exp, pos))  = 
          let val {exp = expvar, ty = tyvar} = trvar var
              val {exp = expexp, ty = tyexp} = transExp(venv, tenv, level, loop_done_label) exp
          in  
            (checkInt(tyexp, pos, "Array subscript");
             case tyvar of
               Ty.ARRAY(ty, unique) => {exp = Tr.subscriptVar(expvar, expexp), ty = ty}
             | _ => (err pos ("Undefined array");
                     {exp = (Tr.nilExp()), ty = Ty.UNIT}))
          end
      in
         trvar
      end
	  
  and transDec (venv,tenv,A.VarDec{name,
                                  escape,
                                  typ = NONE,
                                  init,
                                  pos}, endLabel, level, explist)=
      let val tyinit = #ty(transExp(venv,tenv, level, endLabel) init)
	  val exp = #exp(transExp(venv,tenv,level, endLabel) init)
	  val access = Tr.allocLocal level (!escape)
	  val explist' = Tr.assignExp(Tr.simpleVar(access, level), exp)::explist
      in 
          if tyinit <> Ty.NIL then {tenv = tenv, venv = Symbol.enter(venv,name,Env.VarEntry{access=access, ty = tyinit}), explist = explist'}
          else (err pos ("Non-record variable can't be initializing nil expression: " ^ Symbol.name name);{tenv = tenv, venv = venv, explist = explist})
      end
    | transDec (venv,tenv,A.VarDec{name,typ=SOME(s,pos),init, pos=pos1, escape=escape},endLable,level,explist) =
      let val tyinit = #ty(transExp (venv, tenv,level, endLable) init)
          val tys = lookType(tenv, s, pos)
          val exp = #exp(transExp(venv,tenv,level,endLable) init)
	  val access = Tr.allocLocal level (!escape)
	  val explist' = Tr.assignExp(Tr.simpleVar(access, level), exp)::explist
      in
          if compareTypePair(tys, tyinit,  pos) then ({tenv = tenv, venv = Symbol.enter(venv, name, Env.VarEntry{access=access, ty = tys}), explist = explist'})
          else (err pos1 ("Variable init type mismatch: " ^ Symbol.name name);({tenv = tenv, venv = Symbol.enter(venv, name, Env.VarEntry{access=access, ty = tys}), explist = explist'}))
      end
    | transDec (venv, tenv, A.TypeDec vardecs, endLable,level,explist) =
      let
	  val names = map #name vardecs
	  val repeat = checkname names
	  val positions = map #pos vardecs
	  val types = map #ty vardecs
	  fun addnamet (name,env) = Symbol.enter(env,name,Ty.NAME(name,ref(NONE)))
	  val tenv' = foldr addnamet tenv names
			    
	  fun update (((name,typ),pos),tenv')=
	      let val newtype = transTy (tenv',typ)
	      in
		  (case Symbol.look(tenv', name) of 
		       SOME(Ty.NAME(s, tref)) => (tref := SOME(newtype); tenv')
		     | _ => (err pos "Error defining types"; tenv'))
	      end
	  fun finalize (((name,typ),pos),tenv'': Ty.ty Symbol.table) =
	      let val counter = List.length(names)
		  fun determine (name:Symbol.symbol, count:int) =
		      let val counting : int ref= ref(count)			     
		      in
			  counting := count - 1;
			  if !counting < 0 then (err pos "Error with mutually recursive types";tenv'')
			  else (case Symbol.look(tenv'',name) of
				    NONE => (err pos "Error with NONE type";tenv'')
				   |SOME(Ty.NAME(s,nref))=> (case !nref of
								    NONE => (err pos "Error with NONE type";tenv'')
								   |SOME(rtyp: Ty.ty)=> (case rtyp of
												Ty.NAME(n,aref) => (determine(n,!counting))
											       |_=>(Symbol.enter(tenv'',name,rtyp))))
				   | _ => tenv'')
		      end 
	      in
		  determine (name,counter)
	      end
	  val tenv'' = foldl update tenv' (ListPair.zip(ListPair.zip(names,types),positions))
      in
	  (if repeat
	   then (err (#pos (List.hd(vardecs))) "Duplicate type definition"; {tenv = tenv, venv=venv, explist=explist})
	   else
	       {tenv = foldr finalize tenv'' (ListPair.zip(ListPair.zip(names,types),positions)), venv = venv, explist=explist})
      end
    | transDec (venv, tenv, (A.FunctionDec funcs),endlabel,level,explist) =
      let fun firstpass ({name=name, params=params, body=body, pos=pos, result=result},tempvenv) =
	      let val result_ty = case result of
                                      SOME(rt, position) => lookType(tenv, rt, pos)
				     |NONE => Ty.UNIT 
		  fun transparam (field:A.field) =
		      let val name = #name field
			  val typ = #typ field
			  val pos= #pos field
		      in
			  {name = name, ty = lookType(tenv, typ, pos)}
		      end
		  val params' = map transparam params

		  fun getEscape(field:A.field)= !(#escape field)
		  val newLabel = Temp.newlabel()
		  val newLevel = Tr.newLevel {parent = level, name = newLabel, formals = (map getEscape params)}
	      in
		  Symbol.enter(tempvenv, name, Env.FunEntry{formals = map #ty params', result = result_ty, level = newLevel, label = newLabel})
	      end  
	  val venv' = foldr firstpass venv funcs
	  val funcnames = map #name funcs
	  val repeat = checkname funcnames
	  fun secondpass (venv,[]) = ()
	    | secondpass (venv,(fundec:Absyn.fundec)::func) =
	      let
		  val name = #name fundec
		  val params = #params fundec
		  val body = #body fundec
		  val pos = #pos fundec
		  val result = #result fundec
		  val tyret = case result of 
				  SOME(rt,p) => lookType(tenv,rt, p)
				| NONE => Ty.UNIT
		  val funcentry = case Symbol.look(venv,name) of
				      SOME(Env.FunEntry funcentry) => funcentry
				     |_ => ErrorMsg.impossible "function not found in the environment" 
		  fun enterparam ({name = name, escape = escape, typ=typ, pos=pos}, (venv, access::rest)) =
	              let
			  val ty = lookType(tenv, typ, pos)
		      in
			  (Symbol.enter(venv,name,Env.VarEntry{access = access, ty=ty}),rest)
		      end
		    | enterparam ({name = name, escape=escape, typ=typ, pos=pos}, (venv,[])) =
		      let
			  val ty = lookType(tenv,typ,pos)
		      in
			  (ErrorMsg.impossible "Didn't allocate param earlier";
			   (Symbol.enter (venv, name, Env.VarEntry {access = Tr.allocLocal (#level funcentry) (!escape), ty = ty}), []))
		      end							    
										    
		  val (venv'',_) = foldr enterparam (venv', List.drop(Tr.formals (#level funcentry),0)) params 
		  val {exp=bodyexp , ty=bodytype} = transExp(venv'',tenv, (#level funcentry), endlabel) body
		  val result = Tr.procEntryExit({level = (#level funcentry), body = bodyexp})
	      in
		  
		  case compareTypePair(bodytype, tyret, pos) of
		      true =>  secondpass(venv,func)
		    | false => (err pos ("Function return type mismatch: " ^ Symbol.name name); secondpass(venv,func))
	      end
      in
	  (if repeat
	   then (err (#pos (List.hd(funcs))) "Duplicate function definition"; {tenv = tenv, venv=venv, explist = explist})
	   else
	       (secondpass(venv',funcs);
		{venv=venv', tenv = tenv, explist = explist}))
      end
    | transDec(venv,tenv, A.Initial(), endLabel, level, explist) = {venv = venv, tenv=tenv, explist = explist}
				  
	fun transProg(absyn) = 
	    let val reset = Tr.reset()
                val mainLevel = Tr.mainLevel
	        val mainLabel = SOME(Temp.newlabel())
		val result = transExp (Env.base_venv, Env.base_tenv, Tr.mainLevel, mainLabel) absyn; 
	    in
                Tr.procEntryExit({level = mainLevel, body = #exp result});
		Tr.getResult()
	    end
end
