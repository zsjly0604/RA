signature LIVENESS =
sig
    structure IGraph : FUNCGRAPH
    datatype igraph =
	     IGRAPH of {graph: Temp.temp IGraph.graph,
		        moves: (IGraph.nodeID * IGraph.nodeID) list}

    val interferenceGraph:
	 Flow.flowgraph * Flow.node Flow.Graph.node list*Temp.temp list ->
	igraph (* (Flow.node Flow.Graph.node -> Temp.temp list)*)
    val printSet: Temp.Set.set -> unit
    val show: TextIO.outstream * igraph -> unit
end

structure Liveness : LIVENESS =
struct
structure IGraph = FuncGraph(Temp.TempOrd)
structure F = Flow
structure FG = Flow.Graph
structure A = Assem
structure G = FuncGraph(Temp.TempOrd)
structure T = Temp
structure S = Symbol
fun printSet (set : Temp.Set.set) =
    (Temp.Set.app (fn (t : Temp.temp) => print (Temp.makestring t ^ ", "))  set;
     print "\n")

structure ioT = SplayMapFn(Temp.TempOrd)
val inTable : Temp.Set.set ioT.map = ioT.empty
val outTable : Temp.Set.set ioT.map = ioT.empty
 datatype igraph = IGRAPH of {graph: Temp.temp IGraph.graph,
                               moves: (IGraph.nodeID * IGraph.nodeID) list}
  fun inoutAnalysis (flowgraph,llist) =
      let
          val inSet = Temp.Set.empty
          val outSet = Temp.Set.empty
          fun init (label,(inTable,outTable,inSet,outSet)) =
	      let
		  val inBase = ioT.insert(inTable,label,inSet)
		  val outBase = ioT.insert(outTable,label,outSet)
	      in
		  (inBase,outBase,inSet,outSet)
	      end

	  val (initin,initout,inSet,outSet) = foldr init (inTable,outTable,inSet,outSet) llist
	  (*val _ = print "after init"*)
	  fun update (label,(flowgraph,inTable,outTable,tinTable,toutTable)) =
	      let
		  (*val _ = print ("update"^Int.toString(label)^"\n")*)
		  val (_,(_,def:Temp.temp list,use:Temp.temp list,_),s,p) = FG.getNode(flowgraph,label)
		  val defSet = Temp.Set.empty
		  val useSet = Temp.Set.empty
	          val tinSet = valOf(ioT.find(inTable,label))
		  val toutSet = valOf(ioT.find(outTable,label))
		  val cinSet = tinSet
		  val coutSet = toutSet
		  val succlist = FG.NodeSet.listItems(s)
		  val succinlist = map (fn label =>
					   let
					       val result = valOf(ioT.find(inTable,label))
					   in
					       (*print "successor set:";
					       printSet result;*)
					       result
					   end
				       ) succlist
		  val inSet = Temp.Set.union((Temp.Set.addList(useSet, use)),Temp.Set.difference(coutSet,Temp.Set.addList(defSet,def)))
		  val outSet = foldl (fn (set, oSet) => Temp.Set.union(set, oSet)) Temp.Set.empty succinlist
		  (*val _ = print "inSet:"
		  val _ = printSet inSet
		  val _ = print "outSet:"
	          val _ = printSet outSet
		  val _ = print "tinSet:"
		  val _ = printSet tinSet
		  val _ = print "toutSet:"
		  val _ = printSet toutSet
		  val _ = print "inSet:"
		  val _ = printSet inSet
		  val _ = print "outSet:"
		  val _ = printSet outSet*)
	      in
		  (flowgraph, ioT.insert(inTable, label, inSet),
		   ioT.insert(outTable, label, outSet),
		   ioT.insert(tinTable, label, cinSet),
		   ioT.insert(toutTable, label, coutSet))
	      end
          val tin = ioT.empty
	  val tout = ioT.empty
          val flag: bool ref = ref true
	  val isConverge: bool ref = ref false
	  fun converge (inTable,outTable,tin,tout) =
	      let
		  (*val _ = print "converge"*)
	          val (flowg,fin,fout,ftin,ftout) = foldr update (flowgraph, inTable, outTable,tin,tout) llist
		  val _ = (flag:= true)
		  fun decide (label,(ftin,ftout,fin,fout)) =
		      let
			 
			  fun compare (label, t1, t2) =
			      let
				  val set1 = valOf(ioT.find(t1,label))
				  (*val _ = print "Set1 for compare:"
				  val _ = printSet set1*)
				  val set2 = valOf(ioT.find(t2,label))
				  (*val _ = print "Set2 for compare:"
				  val _ = printSet set2*)
			      in
				  T.Set.equal(set1,set2)
			      end
		          val isSame1 = compare(label,ftin,fin)
			  val isSame2 = compare(label,ftout,fout)
			  val isSame = isSame1 andalso isSame2
			  (*val _ = print ("isSame:" ^ Bool.toString(isSame))*)
		      in
			  if isSame then (ftin,ftout,fin,fout)
			  else (flag := false; (ftin,ftout,fin,fout))	  
		      end
	          val _ = foldl decide (ftin, ftout, fin, fout) llist
	          val _ = (isConverge := (!flag))
		  (*val _ = print ("isConverge:" ^ Bool.toString(!isConverge))*)
	      in
		  if (!isConverge) then (fin,fout,ftin,ftout)
		  else converge (fin,fout,ftin,ftout)
	      end
      in
	  converge(initin, initout,tin,tout)
      end
	      
  fun prodIGraph (outTable: Temp.Set.set ioT.map,flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,llist:Temp.temp list) =
      let
	  val igraph_init:Temp.temp IGraph.graph = IGraph.empty
          fun addspecialregs igraph =
	      let
		  fun addonenode (temp,igraph) =
		      IGraph.addNode(igraph,temp,0)
	      in
		  foldl addonenode igraph MipsFrame.specialregs
	      end
	  val igraph_base_1 = addspecialregs(igraph_init);
	  val igraph_base = IGraph.addNode(igraph_base_1,106,0);
	  val movelist = ref []
	  fun outer (label,igraph) =
	      let
		  val (_,(_,defs,uses,isMove),s,p) = FG.getNode(flowgraph,label)
		  val emptydef = (defs = [])
		  fun procOneInsn def =
		      let
			  val louts = valOf(ioT.find(outTable,label))
		          val liveouts = Temp.Set.listItems(louts)
			  fun addtwoNodes (liveout,(igraph,def)) =
			      let
				val tempigraph1 = IGraph.addNode(igraph,def,0)
				val tempigraph2 = IGraph.addNode(tempigraph1,liveout,0)
			      in
				  (tempigraph2,def)
			      end
			  val (initigraph1,_) = foldr addtwoNodes (igraph,def) liveouts
		      in
			  initigraph1
		      end
	      in
		  if emptydef then igraph else procOneInsn (List.hd(defs))
	      end
		  
        fun initIGraph (igraph,llist) = foldl outer igraph llist
					      
		
	fun oneBlock (label,igraph) =
	    let
		(*val _ = print"before"*)
		val (_,(_,defs,uses,isMove),s,p) = FG.getNode(flowgraph,label) 
	        (*val _ = print"after"*)
		val emptydef = (defs = [])
		fun procNonMove def =
		    let
			(*val _ = print "before outTable"*)
			val louts = valOf(ioT.find(outTable, label))
			(*val _ = print "nonMove outSet:"
		        val _ = printSet louts*)
			(*val _ = print"outTable?"*)
			val liveouts = Temp.Set.listItems(louts)	
			fun oneEdge (liveout,(igraph,def)) =
			    let
				(*val _ = print "inNonMove"*)
				(*val tempigraph1 = IGraph.addNode(igraph,def,0)
				val tempigraph2 = IGraph.addNode(tempigraph1,liveout,0)*)
			    in
				(IGraph.doubleEdge(igraph:Temp.temp IGraph.graph,def:IGraph.nodeID,liveout:IGraph.nodeID),def)
			    end
			(*fun oneDef (def,igraph) = foldr oneEdge (igraph,def) liveouts*)
		        val (finaligraph,_) = foldr oneEdge (igraph,def) liveouts
		    in
			finaligraph
		    end
		fun procMove def =
	            let
			(*val _ = print "before outTable"*)
			val louts = valOf(ioT.find(outTable,label))
			(*val _ = print"ourTable?"*)
			(*val _ = print "Move outSet:"
		        val _ = printSet louts*)
			val liveouts = Temp.Set.listItems(louts)
			val use = List.hd(uses)
			fun oneEdge (liveout, (igraph,def)) =
			    let
				(*val _ = print"inMove"*)
				val useinfo = List.hd(uses)
				val moveinfer = (useinfo = liveout)
			        (*val tempigraph1 = IGraph.addNode(igraph,def,0)
				val tempigraph2 = IGraph.addNode(tempigraph1,liveout,0)*)
			    in
				if moveinfer then (igraph,def)
				else (IGraph.doubleEdge(igraph,def,liveout),def)
			    end
			val (finaligraph,_) = foldr oneEdge (igraph,def) liveouts
		   
		    in
			movelist := ((def,use)::(!movelist));
			finaligraph
		    end
	    in
		if emptydef then igraph
		else ((if isMove then procMove (List.hd(defs))
		     else procNonMove (List.hd(defs))))
	    end
	val igraph = initIGraph (igraph_base,llist)
    in
	((foldl oneBlock igraph llist),!movelist)
    end
      
  fun interferenceGraph (flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,nodelist,llist : Temp.temp list) =
      let

	  val (_,outT,_,_) = inoutAnalysis(flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,llist)

	  val (graph, moveList) = prodIGraph(outT,flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,llist)
	  (*val _ = print "finish igraph"*)
	  (*val out = prodOut(outTable nodelist)*)
      in
	  IGRAPH{graph=graph,moves=moveList} 
      end
      
    fun show (outstream : TextIO.outstream, igraph' : igraph) = 
	let
	    val _ = print "================== interference Graph ================="
	    val igraph = case igraph' of
			     IGRAPH {graph, ...} => graph
	    val _ = print "getigraph"
	    val _ = IGraph.printGraph (fn (nid, temp) => (Int.toString nid) ^ " <-> " ^ Temp.makestring temp) igraph
	in
	    ()
	end
end
