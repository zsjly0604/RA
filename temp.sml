structure Temp : TEMP =
struct
    type temp = int

    val labelCount = ref 0
    val temps = ref 100

    fun resetTempCount () = (temps := 102) 

    fun reset () = 
	let val () = temps := 100
	    val () = labelCount := 0
	in
	    ()
	end


    fun newtemp() = 
	let val t  = !temps 
	    val () = temps := t+1
	in 
	    t
	end

    structure Table = IntMapTable(type key = int
				  fun getInt n = n)

    fun makestring t = "t" ^ Int.toString t
    fun compare (t1, t2) = Int.compare (t1, t2)
    
    type 'a table= 'a Table.table
    val empty = Table.empty
    val enter = Table.enter
    val look = Table.look		       
    
    type label = Symbol.symbol 

     structure TempOrd = struct 
      type ord_key = temp
      val compare  = compare
    end

    structure Set = SplaySetFn(TempOrd)
    structure Map = SplayMapFn(TempOrd)
 
    fun newlabel() = 
	let val x  = !labelCount
	    val () = labelCount := x +1
	in
	    Symbol.symbol ("L" ^ Int.toString (!labelCount))
	end
    val namedlabel = Symbol.symbol


end
