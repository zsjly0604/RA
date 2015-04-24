signature TEMP = 
sig
  eqtype temp
  val labelCount : int ref
  val temps : int ref
  val reset : unit -> unit
  val newtemp : unit -> temp
  val compare : temp * temp -> order
  val makestring: temp -> string
  structure Table : TABLE sharing type Table.key = temp
  type label = Symbol.symbol
  val newlabel : unit -> label
  val namedlabel : string -> label
   structure TempOrd : ORD_KEY sharing type TempOrd.ord_key = temp
  structure Set : ORD_SET 
  structure Map : ORD_MAP 
  type 'a table
  val empty : 'a table
  val enter : 'a table * temp * 'a -> 'a table
  val look  : 'a table * temp -> 'a option
  val resetTempCount : unit -> unit
end

