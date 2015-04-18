signature STACK =
  sig

    val empty : Temp.temp list
    val isEmpty : Temp.temp list -> bool

    val push : (Temp.temp list * Temp.temp) -> Temp.temp list
    val pop : Temp.temp list -> Temp.temp list
    val top : Temp.temp list -> Temp.temp
  end

structure Stack :> STACK =
  struct
    val Impossible = ErrorMsg.impossible

    val empty = []
    fun isEmpty (l) = 
      case l of 
        [] => true
       | _ => false
    
    fun push (l, x) = x::l
    fun pop (l) = 
      case l of
        [] => Impossible "Empty stack"
       | (x::xs) => xs
    fun top (l) =
      case l of
        [] => Impossible "Empty stack"
       | (x::xs) => x
   end    
