structure Main = struct

   structure Tr = Translate
   structure F = MipsFrame
    structure A = Assem

 fun getsome (SOME x) = x
   | getsome NONE = ErrorMsg.impossible "getsome none"

 fun emitproc out (F.PROC{body,frame}) =
   let val _ = print ("emit " ^ Symbol.name (F.name frame) ^ "\n")
       (*val _ = Printtree.printtree(out,body);*)
        val stms = Canon.linearize body
         (*val _ = app (fn s => Printtree.printtree(out,s)) stms;*)
         val stms' = Canon.traceSchedule(Canon.basicBlocks stms)
	 val instrs =   List.concat(map MipsGen.codegen stms') 
         val format0 = A.format(Temp.makestring)
      in  
          app (fn i => TextIO.output(out,format0 i)) instrs
       end
    | emitproc out (F.STRING(lab,s)) = TextIO.output(out,s)

   fun withOpenFile fname f = 
       let val out = TextIO.openOut fname
        in (f out before TextIO.closeOut out) 
	    handle e => (TextIO.closeOut out; raise e)
       end 

    fun emitprocIGraph (F.PROC{body,frame}) =
     let 
          (*val _ = print ("emit " ^ Symbol.name (F.name frame) ^ "\n")*)
(*         val _ = Printtree.printtree(out,body); *)
       val stms = Canon.linearize body
(*         val _ = app (fn s => Printtree.printtree(out,s)) stms; *)
       val stms' = Canon.traceSchedule(Canon.basicBlocks stms)
       val instrs =  List.concat(map MipsGen.codegen stms') 
       val (flowGraph, nodeList,llist) = MakeGraph.instrs2graph(instrs)
       val iGraph = Liveness.interferenceGraph (flowGraph, nodeList,llist)
       val (instrs2, regAllocation) = RegAlloc.alloc(instrs, iGraph, frame)
       val regalloclist = Temp.Map.listItemsi(regAllocation)
      in  
         Liveness.show(TextIO.stdOut, iGraph);
         print("============regalloc map==========\n");
         List.app (fn (k, F.Reg r) => print(Temp.makestring k ^ "->" ^ r ^ "\n")) regalloclist
     end
    | emitprocIGraph (F.STRING(lab,s)) = ()

   fun printIGraph filename = 
    let val absyn = Parse.parse filename
            val frags = (FindEscape.findEscape absyn; Semant.transProg absyn)
        in 
            print "here"; map emitprocIGraph frags
        end

     fun compile filename = 
       let val absyn = Parse.parse filename
           val frags = (FindEscape.findEscape absyn; 
                        Semant.transProg absyn)
        in 
            (*withOpenFile (filename ^ ".s") 
	    (fn out => (app (emitproc out) frags))*)
           app emitprocIGraph frags
       end

end



