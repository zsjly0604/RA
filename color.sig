signature COLOR =
sig
  structure Frame : FRAME
  type allocation = Frame.register Temp.Map.map
  type nodeID = IGraph.nodeID

  val color : {interference: Liveness.igraph, initial : allocation, registers: Frame.register list} -> allocation * Temp.temp list
end
