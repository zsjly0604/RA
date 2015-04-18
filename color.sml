structure Color : COLOR =  struct

structure Frame = MipsFrame
type allocation = Frame.register Temp.Map.map
structure IGraph = FuncGraph(Temp.TempOrd)
structure MS = IGraph.EdgeSet
structure NM = IGraph.NodeMap
structure NS = IGraph.NodeSet
type nodeID = IGraph.nodeID

structure RM = SplayMapFn(struct type ord_key = Frame.register
                             fun compare (Frame.Reg x, Frame.Reg y) = String.compare(x, y)
                             end)
   
val Impossible = ErrorMsg.impossible

fun color {interference = Liveness.IGRAPH{graph, moves}, initial = initAlloc, registers} =
  let val movelist : MS.set NM.map ref = ref NM.empty
      
      val worklistMoves = ref MS.empty 
      val activeMoves  = ref MS.empty
      val frozenMoves  = ref MS.empty
      val coalescedMoves  = ref MS.empty 
      val constrainedMoves = ref MS.empty

      val selectStack = ref Stack.empty
      val alias : nodeID NM.map ref = ref NM.empty
      val degree : int NM.map ref = ref NM.empty
      val colorUsed : int RM.map ref = ref RM.empty 

      val spillWorklist : nodeID list ref = ref nil 
      val freezeWorklist: nodeID list ref = ref nil
      val simplifyWorklist : nodeID list ref = ref nil      
      val coalescedNodes : nodeID list ref =  ref nil
      val spilledNodes : nodeID list ref = ref nil

      val precolored = ref NS.empty
      val coloredNodes = ref NS.empty

      val initial = ref NS.empty

      val colored : allocation ref = ref Temp.Map.empty

      val nodes = IGraph.nodes(graph)
      val K = List.length(registers)

      fun deleteItem ([], _) = Impossible "Delete item from empty list"
        | deleteItem (l, item) = List.filter (fn x => x <> item) l 

      fun getDegree n = 
        case NM.find(!degree, n) of
          NONE => Impossible "Can't find degree"
        | SOME d => d

      fun getColor n = 
        case Temp.Map.find(!colored, n) of
          NONE => Impossible "Can't find color"
        | SOME c => c

      fun nodeMoves n =
        let val ms = case NM.find(!movelist, n) of
                        SOME moveset => moveset
                      | NONE => MS.empty
        in
          MS.intersection(ms, MS.union(!activeMoves, !worklistMoves))
      end

      fun moveRelated n = not(MS.isEmpty(nodeMoves n))

      fun enableMoves ns =
        let fun treatNode n = 
              let val ms = nodeMoves(n)
                  fun treatMove m =
                    if MS.member(!activeMoves, m) then (activeMoves := MS.delete(!activeMoves, m);
                                                        worklistMoves := MS.add(!worklistMoves, m)) else ()
              in
                 MS.app treatMove ms
              end
        in
          List.app treatNode ns
        end

    fun adjacent (n:nodeID) = 
      let val adjlist = IGraph.adj(IGraph.getNode(graph, n))
          val sclist = !selectStack @ !coalescedNodes 
      in
         foldl (fn (n, l) => deleteItem(l, n)) adjlist sclist
       end

     fun decrementDegree n =
       let val d = getDegree n
           val adj = adjacent n
           val nadj = n::adj
       in
         degree := NM.insert(!degree, n, d - 1);
         if d - 1 = K then (enableMoves nadj;
                            spillWorklist := deleteItem(!spillWorklist, n);
                            if moveRelated(n) then freezeWorklist := n::(!freezeWorklist)     
                             else simplifyWorklist := n::(!simplifyWorklist))
         else ()
       end

     fun getAlias n =
       if List.exists (fn x => x = n) (!coalescedNodes) then (case NM.find(!alias, n) of
                                                             NONE => Impossible "Empty alias list"
                                                           | SOME a => getAlias a)
       else n

     fun freezeMoves n =
       let val ms = nodeMoves n
           fun treatMove (m as {from = from, to = to}) =
             let val v =  if getAlias(to) = getAlias(n) then getAlias(from) else getAlias(to)
             in    
               activeMoves := MS.delete(!activeMoves, m);
               frozenMoves := MS.add(!frozenMoves, m);
               if (MS.isEmpty(nodeMoves(v)) andalso getDegree(v) < K) then (freezeWorklist := deleteItem(!freezeWorklist, v);simplifyWorklist := v::(!simplifyWorklist)) else ()
             end
       in
         MS.app treatMove ms
       end
 
     fun addWorklist u =
       if (not(NS.member(!precolored, u)) andalso not(moveRelated(u)) andalso getDegree(u) < K) then (freezeWorklist := deleteItem(!freezeWorklist, u);simplifyWorklist := u::(!simplifyWorklist))
       else ()

     fun OK (t:nodeID, r:nodeID) =
       let val t' = IGraph.getNode(graph, t)
           val r' = IGraph.getNode(graph,r)
       in
         getDegree(t) < K orelse NS.member(!precolored, t) orelse IGraph.isAdjacent(t', r')
       end

     fun conservative nodes =
       let val k = ref 0
       in
         app (fn n => if getDegree(n) >= K then k := !k + 1 else ()) nodes;
         (!k) < K
       end

     fun combine (u, v) =
       let val mlistu = case NM.find(!movelist, u) of
                          NONE => MS.empty
	        	   | SOME ms => ms
           val mlistv = case NM.find(!movelist, v) of
                          NONE => MS.empty
		        | SOME ms => ms
           val adjv = adjacent v
       in
         (if List.exists (fn x => x = v) (!freezeWorklist) then freezeWorklist := deleteItem(!freezeWorklist, v)
          else spillWorklist := deleteItem(!spillWorklist, v));
         coalescedNodes := v::(!coalescedNodes);
         alias := NM.insert(!alias, v, u);
         movelist := NM.insert(!movelist, u, MS.union(mlistu, mlistv));
         List.app (fn t => (IGraph.doubleEdge(graph, t,  u);decrementDegree(t))) adjv;
         if (getDegree(u) >= K andalso List.exists(fn n => n = u) (!freezeWorklist)) then (freezeWorklist := deleteItem(!freezeWorklist, u);spillWorklist := u::(!spillWorklist)) else ()
       end
 
     fun build () =
       let fun treatNode n =
             let val nid = IGraph.getNodeID n
             in 
               (case NM.find(initAlloc, nid) of
                  SOME reg => (precolored := NS.add(!precolored, nid);
                               colored := Temp.Map.insert(!colored, nid, reg);
                               case RM.find(!colorUsed, reg) of
                                  NONE => colorUsed := RM.insert(!colorUsed, reg, 1)
				| SOME x => colorUsed := RM.insert(!colorUsed, reg, x + 1))
	        | NONE => initial := NS.add(!initial, nid)); 
               movelist := NM.insert(!movelist, nid, MS.empty);
               degree := NM.insert(!degree, nid, IGraph.degree n)        
             end

           fun addMove (from, to) = 
             let val mlistfrom = case NM.find(!movelist, from) of
                                   NONE => MS.empty
                                 | SOME ms => ms
                 val mlistto = case NM.find(!movelist, to) of
                                  NONE => MS.empty
                                | SOME ms => ms
                 val m = {from = from, to = to}
             in 
               movelist := NM.insert(!movelist, from, MS.add(mlistfrom, m));
               movelist := NM.insert(!movelist, to, MS.add(mlistto, m));
               worklistMoves := MS.add(!worklistMoves, m)
              end
           
           fun addRegister r =
             colorUsed := RM.insert(!colorUsed, r, 0)
        in
           List.app addRegister registers;
           List.app treatNode nodes;
           List.app addMove moves
        end
  
     fun makeWorklist () = 
           let val n = List.hd(NS.listItems(!initial))
           in
             initial := NS.delete(!initial, n);
             (if getDegree(n) >= K then spillWorklist := n::(!spillWorklist)
              else if moveRelated(n) then freezeWorklist := n::(!freezeWorklist)
                   else simplifyWorklist := n::(!simplifyWorklist));
               if not(NS.isEmpty(!initial)) then makeWorklist() else ()
           end

     fun simplify (n::nl) = 
       let val adjn = adjacent n
       in
          simplifyWorklist := nl;
          Stack.push(!selectStack, n);
          app decrementDegree adjn
       end

     fun coalesce () =
       let val m = List.hd(MS.listItems(!worklistMoves)) 
          val x = getAlias(#from m)
          val y = getAlias(#to m)
          val (u, v) = case NS.member(!precolored, y) of
                         true => (y, x)
                       | false => (x, y)
          val u' = IGraph.getNode(graph, u)
          val v' = IGraph.getNode(graph, v) 
          val adju = adjacent(u)
          val adjv = adjacent(v)

          fun allOK (u, nodes) = not(List.exists(fn t => not(OK(t, u))) nodes)
       in
         worklistMoves := MS.delete(!worklistMoves, m);
         if (u = v) then (coalescedMoves := MS.add(!coalescedMoves, m);
                          addWorklist(u))
         else if (NS.member(!precolored, v) orelse IGraph.isAdjacent(u', v')) then (constrainedMoves := MS.add(!constrainedMoves, m);
                     addWorklist(u);
                     addWorklist(v))
               else if ((NS.member(!precolored, u) andalso allOK(u, adjv)) orelse (not(NS.member(!precolored, u)) andalso conservative(adju @ adjv))) then (coalescedMoves := MS.add(!coalescedMoves, m);combine(u, v);addWorklist(u))
               else activeMoves := MS.add(!activeMoves, m)
       end

     fun freeze () =
       let val selected = List.foldl (fn (a, b) => if valOf(NM.find(!degree, a)) > valOf(NM.find(!degree, b)) then a else b) (List.hd(!freezeWorklist)) (!freezeWorklist)
       in
         freezeWorklist := deleteItem(!freezeWorklist, selected);
         simplifyWorklist := selected::(!simplifyWorklist);
         freezeMoves(selected)
       end
 
     fun selectSpill () =
       let val selected = List.foldl (fn (a, b) => if valOf(NM.find(!degree, a)) > valOf(NM.find(!degree, b)) then a else b) (List.hd(!spillWorklist)) (!spillWorklist)
       in  
         spillWorklist := deleteItem(!spillWorklist, selected);
         simplifyWorklist := selected::(!simplifyWorklist);
         freezeMoves(selected)
       end

     fun assignColors () =
       let fun assigniter () = 
             let val n = Stack.top(!selectStack)
                 val okColors = ref registers
                 val adjlist = IGraph.adj(IGraph.getNode(graph, n))
                 fun filterColor (w) =
                       let val aw = getAlias(w) 
                       in
                         if (NS.member(!precolored, aw) orelse NS.member(!coloredNodes, aw)) then okColors := deleteItem(!okColors, getColor(aw)) else ()
                  end 
                  fun selectColor () = 
                    let val selected = List.foldl (fn (a, b) => if valOf(RM.find(!colorUsed, a)) < valOf(RM.find(!colorUsed, b)) then a else b) (List.hd(!okColors)) (!okColors)                     val x = valOf(RM.find(!colorUsed, selected))
                  in
                    colored := Temp.Map.insert(!colored, n, selected);
                    colorUsed := RM.insert(!colorUsed, selected, x + 1)
                  end
             in
               selectStack := Stack.pop(!selectStack);
               List.app filterColor adjlist;
               (if !okColors = [] then spilledNodes := n::(!spilledNodes)
               else coloredNodes := NS.add(!coloredNodes, n));
               selectColor()
            end
          fun colorCoalesced (n) =
                let val an = getAlias(n)
                    val c = getColor(an)
                in
                  colored := Temp.Map.insert(!colored, n, c)
                end 
       in
         if Stack.isEmpty(!selectStack) = false then (assigniter();assignColors())
         else List.app colorCoalesced (!coalescedNodes)
  end
      
    fun repeat () =
        if !simplifyWorklist <> [] then (simplify(!simplifyWorklist);repeat())
        else if MS.isEmpty(!worklistMoves) = false then (coalesce();repeat())
             else if !freezeWorklist <> [] then (freeze();repeat()) 
                  else if !spillWorklist <> [] then (selectSpill();repeat())
                       else () 
  
  in
     build();
     makeWorklist();
     repeat();
     assignColors();
     (!colored, !spilledNodes)
  end
end
  
