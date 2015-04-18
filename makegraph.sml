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
    val lIDmap : Temp.temp LG.map ref = ref LG.empty
    val aIDmap : Temp.temp AG.map ref = ref AG.empty

    exception NoSuchNode of Temp.temp
    fun instrs2graph ilist =
	let
	    fun prodNode (insn,g) =
		case insn of
		    A.OPER{assem=assem, dst=dst, src=src, jump=jump} =>
		    let
			val node = (assem, dst, src, false)
		        val ID = T.newtemp()
		    in
			llist := ((!llist)@[ID]);
			aIDmap := AG.insert(!aIDmap,insn,ID);
			G.addNode(g, ID, node)
		        
		    end
		  | A.LABEL{assem=assem,lab=lab} =>
		    let
			val ID = T.newtemp()
			val node = (assem, [],[],false)
		    in
			llist := ((!llist)@[ID]);
			aIDmap := AG.insert(!aIDmap,insn,ID:Temp.temp);
			lIDmap:= LG.insert(!lIDmap,lab,ID:Temp.temp);
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
		    val ID = valOf(AG.find(!aIDmap,instr))
		    
		   
		    fun prodEdge (j,g) = G.addEdge(g,{from = ID,to = j})
		    fun getNext (ID:Temp.temp, labellist:Temp.temp list) =
			case labellist of
			    a::ID::next::rest => next
			  | a::ID::[] => ID
			  | _ => raise NoSuchNode(ID)
		in
		    case instr of
			A.OPER{assem=assem, dst=dst, src=src, jump = SOME(jlist)} =>
			let
			    val tolist = map (fn label => valOf(LG.find(!lIDmap, label))) jlist
			in
			    (foldl prodEdge g tolist)
			end
		      | A.LABEL{assem, lab} =>
			let val to = getNext(ID, !llist)
			    val from = ID
			in
			    G.addEdge(g, {from = from,to=to})
			end
		      | A.MOVE{assem, dst, src} => 
			let val to = getNext(ID,!llist)
			    val from = ID
			in
			    G.addEdge(g, {from = from,to = to})
			end
		end
	    val g_empty: Flow.flowgraph = G.empty
	    val g_base = foldl prodNode G.empty ilist
	    val fg = foldl prodEdges g_base ilist
	    val nodes = map (fn l => G.getNode(fg, l)) (!llist)
	in
	    (fg,nodes,!llist)
	end
    end
