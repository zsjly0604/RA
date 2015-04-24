structure Flow =
struct
structure Graph = FuncGraph(Temp.TempOrd)
structure LMap = SplayMapFn(
    struct 
	type ord_key = Symbol.symbol
	val compare = Symbol.compare					 
    end)

structure AMap = SplayMapFn(
    struct
       type ord_key = Assem.instr
       val compare = Assem.compare
    end)
			   
type node = string * Temp.temp list * Temp.temp list * bool
type flowgraph = node Graph.graph
end
			   

signature MAKEGRAPH = 
sig
    val instrs2graph: Assem.instr list -> Flow.flowgraph * Flow.node Flow.Graph.node list * Temp.temp list
    val llist: Temp.temp list ref
end

structure MakeGraph: MAKEGRAPH =
    struct

    structure F = Flow
    structure A = Assem
    structure G = Flow.Graph
    structure T = Temp
    structure S = Symbol
    structure LG = Flow.LMap
    structure AG = Flow.AMap
     
    val llist = ref [] : Temp.temp list ref

    exception NoSuchNode of Temp.temp
    fun instrs2graph ilist =
	let val _ = llist := []
	    val lIDmap : Temp.temp LG.map ref = ref LG.empty
	    val aIDmap : Temp.temp AG.map ref = ref AG.empty
	    fun prodNode (insn,g) =
		case insn of
		    A.OPER{assem=assem, dst=dst, src=src, jump=jump} =>
		    let
			val node = (assem, dst, src, false)
		        val ID = T.newtemp()
		    in
			llist := ((!llist)@[ID]);
			aIDmap := AG.insert(!aIDmap,insn,ID);
			(*print "here";
			print ("ID is " ^ Int.toString(valOf(AG.find(!aIDmap,insn))));*)
			G.addNode(g, ID, node)
		        
		    end
		  | A.LABEL{assem=assem,lab=lab} =>
		    let
			val ID = T.newtemp()
			val node = (assem, [],[],false)
		    in
			llist := ((!llist)@[ID]);
			aIDmap := AG.insert(!aIDmap,insn,ID:Temp.temp);
			lIDmap := LG.insert(!lIDmap,lab,ID:Temp.temp);
			G.addNode(g, ID, node)
		    end
		  | A.MOVE{assem=assem,dst=dst,src=src} =>
		    let
			val mID = T.newtemp()
			val node = (assem, [dst], [src], true)
		    in
			llist := ((!llist)@[mID]);
			aIDmap := AG.insert(!aIDmap,insn,mID:Temp.temp);
			G.addNode(g, mID, node)
		    end
			
			
	    fun prodEdges (instr,g) =
		let
		    (*val _ = print "getting ID\n";*)
		    val ID = valOf(AG.find(!aIDmap,instr))
		    (*val _ = print ("ID:" ^ Int.toString(ID)^"\n")*)
		    fun prodEdge (j,g) =
			if (ID = j) then g else
			(G.addEdge(g,{from = ID,to = j}))
		    fun getNext (ID:Temp.temp, labellist:Temp.temp list) =
			let
			    fun helper (ans,list) =
				case list of
				   first::next::rest => if (ID = first) then helper(next,next::rest) else helper(ans, next::rest)
				 | _ =>(ans,[])
			    val (ans,_) = helper (ID,!llist)
			in
			    ans
			end
		in
		    case instr of
			A.OPER{assem=assem, dst=dst, src=src, jump = jump} =>
			let
			    val jlist = case jump of
					    SOME(j) => j
					  | NONE => []
			    val jlength = List.length(jlist)
			    (*val _= print ("assem:"^ assem ^"jlist:" ^ Int.toString(jlength)^"\n")*)
			    val isBranch' = ((dst=[]) andalso (src=[]))
			    val isBranch = isBranch' andalso (jlength=1)
			    val tolist' = map (fn label => valOf(LG.find(!lIDmap, label))) jlist
			    val nextInsn = getNext(ID,!llist)
			    (*val _ = print ("nextInsn:" ^ Int.toString(nextInsn))*)
			    val tolist = if isBranch then tolist'
					 else (if (nextInsn = ID) then tolist' else (nextInsn::tolist'))
			    val length = List.length(tolist)
			in
			    (*print ("tolist:" ^ Int.toString(length)^"\n");*)
			    (foldl prodEdge g tolist)
			end
		      | A.LABEL{assem, lab} =>
			let val to = getNext(ID, !llist)
			    val from = ID
			in
			    if (from = to) then g else
			    G.addEdge(g, {from = from,to = to})
			end
		      | A.MOVE{assem, dst, src} => 
			let val to = getNext(ID,!llist)
			    val from = ID
			in
			    if (from = to) then g else
			    G.addEdge(g, {from = from,to = to})
			end
		end
	    val g_empty: Flow.flowgraph = G.empty
	    (*val _ = print "before adding base\n"*)
	    val g_base = foldl prodNode G.empty ilist
	    (*val _ = print "before adding edge\n"*)
	    val fg = foldl prodEdges g_base ilist
	    (*val _ = print "after adding edge\n"*)
	    val nodes = map (fn l => (G.getNode(fg, l))) (!llist)
	    (*val _ = print "after getting nodes"*)
	in
	    (*G.printGraph (fn (nid,(assem:string,def:Temp.temp list,use:Temp.temp list,isMove:bool)) => ("nid:"^Temp.makestring(nid)^"assem:"^assem)) fg;
	    print"after print";*)
	    (fg,nodes,!llist)
	end
    end
