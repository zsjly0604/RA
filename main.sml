structure Main = struct

   structure Tr = Translate
   structure Frame = MipsFrame
    structure A = Assem

 fun getsome (SOME x) = x
   | getsome NONE = ErrorMsg.impossible "getsome none"

fun addtab instrs =
    map (fn (i) =>
            case i of
              l as A.LABEL _ => l
            | A.OPER{assem,src,dst,jump} =>
              A.OPER{assem="\t"^assem,src=src,dst=dst,jump=jump}
            | A.MOVE{assem,dst,src} =>
              A.MOVE{assem="\t"^assem,src=src,dst=dst}
        ) instrs

 val tag = ref true

 fun tempname alloc temp = 
   case Temp.Map.find(alloc, temp) of
     SOME(Frame.Reg r) => r
  |  NONE => Frame.tempname temp
 
 fun emitproc out (Frame.PROC{body,frame}) =
   let val _ = print ("emit " ^ Symbol.name (Frame.name frame) ^ "\n")
       (*val _ = Printtree.printtree(out,body);*)
        val stms = Canon.linearize body
         (*val _ = app (fn s => Printtree.printtree(out,s)) stms;*)
         val stms' = Canon.traceSchedule(Canon.basicBlocks stms)
	 val instrs =   List.concat(map MipsGen.codegen stms') 
         val instrs2 = Frame.procEntryExit2 (frame, instrs)
         val format1 = A.format(Temp.makestring)
         val (instrs2', alloc) = RegAlloc.alloc(instrs2, frame)
         val {prolog, body, epilog} = Frame.procEntryExit3(frame, instrs2') 
         val instrs'' = addtab body
         val format0 = A.format(tempname alloc)
         val regalloclist = Temp.Map.listItemsi(alloc)

   in
         TextIO.output(out, prolog);
          app (fn i => TextIO.output(out, format0 i)) instrs'';
         TextIO.output(out, epilog)
       end
   | emitproc out (Frame.STRING(lab,s)) =
     let
     in
	 ((*if (!tag) then (TextIO.output(out, "\n.data\n.align 4\n"); tag := false) else ();*)
	 TextIO.output(out,Frame.string(lab,s)))
     end
 fun printRunTimeFiles (out) = 
     let
	 val runTime = TextIO.openIn "runtime.s"
	 val sysSpim = TextIO.openIn "sysspim.s"
	 fun process(inStream) = (case TextIO.inputLine inStream of
                              SOME(l) => (TextIO.output(out, l); process(inStream))
				   | NONE => ())
     in
	 (TextIO.output(out, "\n");
	  process(runTime);
	  process(sysSpim))
     end
	 
	 
   fun withOpenFile fname f = 
       let val out = TextIO.openOut fname
       in (f out before TextIO.closeOut out) 
	  handle e => (TextIO.closeOut out; raise e)
       end 
	   
	   
   fun compile filename = 
       let val absyn = Parse.parse filename
	   val _ = tag := true
           val frags = (FindEscape.findEscape absyn; 
                        Semant.transProg absyn)
       in 
           withOpenFile (filename ^ ".s") 
			(fn out => (printRunTimeFiles out;(app (emitproc out) frags)))
       end
	   
   fun emitprocIGraph (Frame.PROC{body,frame}) =
       let 
           (*val _ = print ("emit " ^ Symbol.name (F.name frame) ^ "\n")*)
	   (*         val _ = Printtree.printtree(out,body); *)
	   val stms = Canon.linearize body
	   (*         val _ = app (fn s => Printtree.printtree(out,s)) stms; *)
	   val stms' = Canon.traceSchedule(Canon.basicBlocks stms)
	   val instrs =  List.concat(map MipsGen.codegen stms') 
				    
	   val (flowGraph, nodeList,llist) = MakeGraph.instrs2graph(instrs)
	   (*val _ = print ("before print")*)
	   val iGraph = Liveness.interferenceGraph (flowGraph, nodeList,llist)
       in  
	   
           (*(print("\n hahahah--->" ^ Int.toString(List.length nodeList))*)
           Liveness.show(TextIO.stdOut, iGraph)
       end
     | emitprocIGraph (Frame.STRING(lab,s)) = ()
						  
   fun printIGraph filename = 
       let
	   val absyn = Parse.parse filename
           val frags = (FindEscape.findEscape absyn; Semant.transProg absyn)
       in
           map emitprocIGraph frags
       end
end



