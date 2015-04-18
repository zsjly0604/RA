signature LIVENESS =
sig
    structure IGraph : FUNCGRAPH
    datatype igraph =
	     IGRAPH of {graph: Temp.temp IGraph.graph,
		        moves: (IGraph.nodeID * IGraph.nodeID) list}

    val interferenceGraph:
	 Flow.flowgraph * Flow.node Flow.Graph.node list*Temp.temp list ->
	igraph (* (Flow.node Flow.Graph.node -> Temp.temp list)*)

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
	  val (initin,initout,inSet,outSet) = foldl init (inTable,outTable,inSet,outSet) llist
	  fun update (label,(flowgraph,inTable,outTable,tinTable,toutTable)) =
	      let
		  val (_,(_,def:Temp.temp list,use:Temp.temp list,_),s,p) = FG.getNode(flowgraph,label)
		  val defSet = Temp.Set.empty
		  val useSet = Temp.Set.empty
	          val tinSet = valOf(ioT.find(inTable,label))
		  val toutSet = valOf(ioT.find(outTable,label))
		  val cinSet = tinSet
		  val coutSet = toutSet
		  val succlist = FG.NodeSet.listItems(s)
		  val succinlist = map (fn label => valOf(ioT.find(inTable,label))) succlist
		  val inSet = Temp.Set.union(Temp.Set.addList(useSet, use),Temp.Set.difference(coutSet,Temp.Set.addList(defSet,def)))
		  val outSet = foldl (fn (set, oSet) => Temp.Set.union(set, oSet)) Temp.Set.empty succinlist
	      in
		  (flowgraph, ioT.insert(inTable, label, inSet),
		   ioT.insert(outTable, label, outSet),
		   ioT.insert(tinTable, label, cinSet),
		   ioT.insert(toutTable, label, coutSet))
	      end
          val tin = ioT.empty
	  val tout = ioT.empty
          val flag: bool ref = ref true
	  fun converge (inTable,outTable,tin,tout) =
	      let 
	          val (flowg,fin,fout,ftin,ftout) = foldl update (flowgraph, inTable, outTable,tin,tout) llist
		  fun decide (label,(ftin,ftout,fin,fout)) =
		      let
			  fun compare (label, t1, t2) =
			      let
				  val set1 = valOf(ioT.find(t1,label))
				  val set2 = valOf(ioT.find(t2,label))
			      in
				  T.Set.equal(set1,set2)
			      end
		          val isSame1 = compare(label,ftin,fin)
			  val isSame2 = compare(label,ftout,fout)
			  val isSame = isSame1 andalso isSame2
		      in
			  if isSame then (ftin,ftout,fin,fout)
			  else (flag := false; (ftin,ftout,fin,fout))	  
		      end
	          val _ = foldl decide (ftin, ftout, fin, fout) llist
	          val isConverge = !flag
	      in
		  if isConverge then (fin,fout,ftin,ftout)
		  else converge (fin,fout,ftin,ftout)
	      end
      in
	  converge(initin, initout,tin,tout)
      end
	      
  fun prodIGraph (outTable: Temp.Set.set ioT.map,flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,llist:Temp.temp list) =
      let
	val igraph:Temp.temp IGraph.graph = IGraph.empty
	val movelist = ref [] 
	fun oneBlock (label,igraph) =
	    let
		val (_,(_,defs,uses,isMove),s,p) = FG.getNode(flowgraph,label) 
		fun procNonMove def =
		    let
			val louts = valOf(ioT.find(outTable, label))
			val liveouts = Temp.Set.listItems(louts)	
			fun oneEdge (liveout,(igraph,def)) =
			    let
				val tempigraph1 = IGraph.addNode(igraph,def,0)
				val tempigraph2 = IGraph.addNode(tempigraph1,liveout,0)
			    in
				(IGraph.doubleEdge(tempigraph2:Temp.temp IGraph.graph,def:IGraph.nodeID,liveout:IGraph.nodeID),def)
			    end
			(*fun oneDef (def,igraph) = foldr oneEdge (igraph,def) liveouts*)
		        val (finaligraph,_) = foldr oneEdge (igraph,def) liveouts
		    in
			finaligraph
		    end
		fun procMove def =
	            let
			val louts = valOf(ioT.find(outTable,label))
			val liveouts = Temp.Set.listItems(louts)
			val use = List.hd(uses)
			fun oneEdge (liveout, (igraph,def)) =
			    let
				val useinfo = List.hd(uses)
				val moveinfer = (useinfo = liveout)
			        val tempigraph1 = IGraph.addNode(igraph,def,0)
				val tempigraph2 = IGraph.addNode(tempigraph1,liveout,0)
			    in
				if moveinfer then (tempigraph2,def)
				else (IGraph.doubleEdge(tempigraph2,def,liveout),def)
			    end
			val (finaligraph,_) = foldr oneEdge (igraph,def) liveouts
		   
		    in
			movelist := ((def,use)::(!movelist));
			finaligraph
		    end
	    in
		if isMove then procMove (List.hd(defs))
		else procNonMove (List.hd(defs))
	    end
    in
	((foldr oneBlock igraph llist),!movelist)
    end

  (*fun prodOut (outTable,llist) =
      let
	  val out = ioT.empty
	  fun oneNode (label,outTable) =
	      let
		  val node = G.getNode(outTable,label)
	          val list = G.NodeSet.listItems(node)
	      in
		  ioT.insert(out,label,list)
	      end
      in
	  foldl oneNode out llist
      end*)
      
  fun interferenceGraph (flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,nodelist,llist : Temp.temp list) =
      let
	  val (_,outT,_,_) = inoutAnalysis(flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,llist)
	  fun translate outT =
	      let
		  val out_base : Temp.Set.set ioT.map = ioT.empty
		  fun converse (label : Temp.temp, out' : Temp.Set.set ioT.map) =
		      let
			  val tempout : Temp.Set.set = valOf(ioT.find(outT,label))
			  (*val outset = Temp.Set.empty
			  val outset'= Temp.Set.addList(tempout)*)
		      in
			  ioT.insert(out',label, tempout)
		      end
	      in
		  foldl converse out_base llist
	      end
	  val outTable = translate(outT)
	  val (graph, moveList) = prodIGraph(outTable,flowgraph:(string * Temp.temp list * Temp.temp list * bool) FG.graph,llist)
	  (*val out = prodOut(outTable nodelist)*)
      in
	  IGRAPH{graph=graph,moves=moveList} 
      end
      
    fun show (outstream : TextIO.outstream, igraph' : igraph) =
	let
	    val _ = print "================== interference Graph ================="
	    val igraph = case igraph' of
			     IGRAPH {graph, ...} => graph
	    val _ = IGraph.printGraph (fn (nid, temp) => (Int.toString nid) ^ " <-> " ^ Temp.makestring temp) igraph
	in
	    ()
	end
end
