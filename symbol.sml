signature SYMBOL =
sig
  eqtype symbol
  val symbol : string -> symbol
  val name : symbol -> string
  type 'a table
  val empty : 'a table
  val enter : 'a table * symbol * 'a -> 'a table
  val look  : 'a table * symbol -> 'a option
  val compare: symbol * symbol -> order
  structure OrdKey : ORD_KEY sharing type OrdKey.ord_key = symbol
end

structure Symbol :> SYMBOL =
struct

  type symbol = string * int

  structure H = HashTable
  fun compare((_,n1),(_,n2)) = Int.compare(n1,n2)

  structure OrdKey =
  struct 
    type ord_key = symbol
    val compare = compare
  end

  exception Symbol
  val nextsym = ref 0
  val sizeHint = 128
  val hashtable : (string,int) H.hash_table = 
		H.mkTable(HashString.hashString, op = ) (sizeHint,Symbol)
  
  fun symbol name =
      case H.find hashtable name
       of SOME i => (name,i)
        | NONE => let val i = !nextsym
	           in nextsym := i+1;
		      H.insert hashtable (name,i);
		      (name,i)
		  end

  fun name(s,n) = s

  structure Table = IntMapTable(type key = symbol
				fun getInt(s,n) = n)

  type 'a table= 'a Table.table
  val empty = Table.empty
  val enter = Table.enter
  val look = Table.look
end
