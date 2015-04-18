signature COLOR =
sig
  structure Frame : FRAME
  type allocation = Frame.register Temp.Table.table

  val color : {interference: Liveness.igraph, initialAlloc : allocation, registers: Frame.register list} -> allocation * Temp.temp list
end
