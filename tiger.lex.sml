functor TigerLexFun(structure Tokens: Tiger_TOKENS)  = struct

    structure yyInput : sig

        type stream
	val mkStream : (int -> string) -> stream
	val fromStream : TextIO.StreamIO.instream -> stream
	val getc : stream -> (Char.char * stream) option
	val getpos : stream -> int
	val getlineNo : stream -> int
	val subtract : stream * stream -> string
	val eof : stream -> bool
	val lastWasNL : stream -> bool

      end = struct

        structure TIO = TextIO
        structure TSIO = TIO.StreamIO
	structure TPIO = TextPrimIO

        datatype stream = Stream of {
            strm : TSIO.instream,
	    id : int,  (* track which streams originated 
			* from the same stream *)
	    pos : int,
	    lineNo : int,
	    lastWasNL : bool
          }

	local
	  val next = ref 0
	in
	fun nextId() = !next before (next := !next + 1)
	end

	val initPos = 2 (* ml-lex bug compatibility *)

	fun mkStream inputN = let
              val strm = TSIO.mkInstream 
			   (TPIO.RD {
			        name = "lexgen",
				chunkSize = 4096,
				readVec = SOME inputN,
				readArr = NONE,
				readVecNB = NONE,
				readArrNB = NONE,
				block = NONE,
				canInput = NONE,
				avail = (fn () => NONE),
				getPos = NONE,
				setPos = NONE,
				endPos = NONE,
				verifyPos = NONE,
				close = (fn () => ()),
				ioDesc = NONE
			      }, "")
	      in 
		Stream {strm = strm, id = nextId(), pos = initPos, lineNo = 1,
			lastWasNL = true}
	      end

	fun fromStream strm = Stream {
		strm = strm, id = nextId(), pos = initPos, lineNo = 1, lastWasNL = true
	      }

	fun getc (Stream {strm, pos, id, lineNo, ...}) = (case TSIO.input1 strm
              of NONE => NONE
	       | SOME (c, strm') => 
		   SOME (c, Stream {
			        strm = strm', 
				pos = pos+1, 
				id = id,
				lineNo = lineNo + 
					 (if c = #"\n" then 1 else 0),
				lastWasNL = (c = #"\n")
			      })
	     (* end case*))

	fun getpos (Stream {pos, ...}) = pos

	fun getlineNo (Stream {lineNo, ...}) = lineNo

	fun subtract (new, old) = let
	      val Stream {strm = strm, pos = oldPos, id = oldId, ...} = old
	      val Stream {pos = newPos, id = newId, ...} = new
              val (diff, _) = if newId = oldId andalso newPos >= oldPos
			      then TSIO.inputN (strm, newPos - oldPos)
			      else raise Fail 
				"BUG: yyInput: attempted to subtract incompatible streams"
	      in 
		diff 
	      end

	fun eof s = not (isSome (getc s))

	fun lastWasNL (Stream {lastWasNL, ...}) = lastWasNL

      end

    datatype yystart_state = 
STRING | WHITESPACE | COMMENT | ESCAPE | INITIAL | ILLEGALSTRING
    structure UserDeclarations = 
      struct

type svalue = Tokens.svalue
type pos = int
type ('a, 'b) token = ('a, 'b) Tokens.token
type lexresult = (svalue, pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
val stringStartPos = ref 0
val stringContent = ref ""

fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end



      end

    datatype yymatch 
      = yyNO_MATCH
      | yyMATCH of yyInput.stream * action * yymatch
    withtype action = yyInput.stream * yymatch -> UserDeclarations.lexresult

    local

    val yytable = 
Vector.fromList []
    fun mk yyins = let
        (* current start state *)
        val yyss = ref INITIAL
	fun YYBEGIN ss = (yyss := ss)
	(* current input stream *)
        val yystrm = ref yyins
	(* get one char of input *)
	val yygetc = yyInput.getc
	(* create yytext *)
	fun yymktext(strm) = yyInput.subtract (strm, !yystrm)
        open UserDeclarations
        fun lex 
(yyarg as ()) = let 
     fun continue() = let
            val yylastwasn = yyInput.lastWasNL (!yystrm)
            fun yystuck (yyNO_MATCH) = raise Fail "stuck state"
	      | yystuck (yyMATCH (strm, action, old)) = 
		  action (strm, old)
	    val yypos = yyInput.getpos (!yystrm)
	    val yygetlineNo = yyInput.getlineNo
	    fun yyactsToMatches (strm, [],	  oldMatches) = oldMatches
	      | yyactsToMatches (strm, act::acts, oldMatches) = 
		  yyMATCH (strm, act, yyactsToMatches (strm, acts, oldMatches))
	    fun yygo actTable = 
		(fn (~1, _, oldMatches) => yystuck oldMatches
		  | (curState, strm, oldMatches) => let
		      val (transitions, finals') = Vector.sub (yytable, curState)
		      val finals = map (fn i => Vector.sub (actTable, i)) finals'
		      fun tryfinal() = 
		            yystuck (yyactsToMatches (strm, finals, oldMatches))
		      fun find (c, []) = NONE
			| find (c, (c1, c2, s)::ts) = 
		            if c1 <= c andalso c <= c2 then SOME s
			    else find (c, ts)
		      in case yygetc strm
			  of SOME(c, strm') => 
			       (case find (c, transitions)
				 of NONE => tryfinal()
				  | SOME n => 
				      yygo actTable
					(n, strm', 
					 yyactsToMatches (strm, finals, oldMatches)))
			   | NONE => tryfinal()
		      end)
	    in 
let
fun yyAction0 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.TYPE(yypos,yypos+size yytext))
      end
fun yyAction1 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.VAR(yypos,yypos+size yytext))
      end
fun yyAction2 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.FUNCTION(yypos,yypos+size yytext))
      end
fun yyAction3 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.BREAK(yypos,yypos+size yytext))
      end
fun yyAction4 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.OF(yypos,yypos+size yytext))
      end
fun yyAction5 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.END(yypos,yypos+size yytext))
      end
fun yyAction6 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.IN(yypos,yypos+size yytext))
      end
fun yyAction7 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.NIL(yypos,yypos+size yytext))
      end
fun yyAction8 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.LET(yypos,yypos+size yytext))
      end
fun yyAction9 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.DO(yypos,yypos+size yytext))
      end
fun yyAction10 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.TO(yypos,yypos+size yytext))
      end
fun yyAction11 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.FOR(yypos,yypos+size yytext))
      end
fun yyAction12 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.WHILE(yypos,yypos+size yytext))
      end
fun yyAction13 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.ELSE(yypos,yypos+size yytext))
      end
fun yyAction14 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.THEN(yypos,yypos+size yytext))
      end
fun yyAction15 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.IF(yypos,yypos+size yytext))
      end
fun yyAction16 (strm, lastMatch : yymatch) = (yystrm := strm;
      (Tokens.ARRAY(yypos,yypos+5)))
fun yyAction17 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.ASSIGN(yypos,yypos+size yytext))
      end
fun yyAction18 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.OR(yypos,yypos+size yytext))
      end
fun yyAction19 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.AND(yypos,yypos+size yytext))
      end
fun yyAction20 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.GE(yypos,yypos+size yytext))
      end
fun yyAction21 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.GT(yypos,yypos+size yytext))
      end
fun yyAction22 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.LE(yypos,yypos+size yytext))
      end
fun yyAction23 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.LT(yypos,yypos+size yytext))
      end
fun yyAction24 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.NEQ(yypos,yypos+size yytext))
      end
fun yyAction25 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.EQ(yypos,yypos+size yytext))
      end
fun yyAction26 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.DIVIDE(yypos,yypos+size yytext))
      end
fun yyAction27 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.TIMES(yypos,yypos+size yytext))
      end
fun yyAction28 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.MINUS(yypos,yypos+size yytext))
      end
fun yyAction29 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.PLUS(yypos,yypos+size yytext))
      end
fun yyAction30 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.DOT(yypos,yypos+size yytext))
      end
fun yyAction31 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.RBRACE(yypos,yypos+size yytext))
      end
fun yyAction32 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.LBRACE(yypos,yypos+size yytext))
      end
fun yyAction33 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.RPAREN(yypos,yypos+size yytext))
      end
fun yyAction34 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.LPAREN(yypos,yypos+size yytext))
      end
fun yyAction35 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.RBRACK(yypos,yypos+size yytext))
      end
fun yyAction36 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.LBRACK(yypos,yypos+size yytext))
      end
fun yyAction37 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.SEMICOLON(yypos,yypos+size yytext))
      end
fun yyAction38 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.COMMA(yypos,yypos+size yytext))
      end
fun yyAction39 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.COLON(yypos,yypos+size yytext))
      end
fun yyAction40 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (Tokens.ID(yytext,yypos,yypos+size yytext))
      end
fun yyAction41 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (Tokens.INT(valOf(Int.fromString yytext),yypos,yypos+size yytext))
      end
fun yyAction42 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN STRING;stringContent:="";stringStartPos:= yypos;continue()))
fun yyAction43 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN INITIAL;Tokens.STRING(!stringContent,!stringStartPos,yypos)))
fun yyAction44 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN ESCAPE;continue()))
fun yyAction45 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN ILLEGALSTRING;ErrorMsg.error yypos ("illegal newline in string"); continue()))
fun yyAction46 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm; (stringContent := !stringContent ^yytext;continue())
      end
fun yyAction47 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (YYBEGIN STRING;stringContent := !stringContent^String.str(Char.chr(valOf(Int.fromString yytext)));continue())
      end
fun yyAction48 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (YYBEGIN STRING;stringContent := !stringContent^String.str(Char.chr(valOf(Int.fromString yytext)));continue())
      end
fun yyAction49 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (YYBEGIN STRING;stringContent := !stringContent^String.str(Char.chr(valOf(Int.fromString yytext)));continue())
      end
fun yyAction50 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN STRING;stringContent := !stringContent ^ "\\";continue()))
fun yyAction51 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN STRING;stringContent := !stringContent ^ "\n";continue()))
fun yyAction52 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN STRING;stringContent := !stringContent ^ "\t";continue()))
fun yyAction53 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN STRING;stringContent := !stringContent ^ "\"";continue()))
fun yyAction54 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN WHITESPACE;continue()))
fun yyAction55 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (YYBEGIN ILLEGALSTRING;ErrorMsg.error yypos ("illegal escape ascii character in string:"^"\\"^yytext);continue())
      end
fun yyAction56 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (YYBEGIN ILLEGALSTRING;ErrorMsg.error yypos ("illegal escape character in string:"^"\\"^yytext);continue())
      end
fun yyAction57 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN INITIAL;continue()))
fun yyAction58 (strm, lastMatch : yymatch) = (yystrm := strm; (continue()))
fun yyAction59 (strm, lastMatch : yymatch) = (yystrm := strm; (continue()))
fun yyAction60 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN STRING;continue()))
fun yyAction61 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (YYBEGIN ILLEGALSTRING;ErrorMsg.error yypos ("illegal whitespace character in string:"^"\\"^yytext^"\\");continue())
      end
fun yyAction62 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN COMMENT;continue()))
fun yyAction63 (strm, lastMatch : yymatch) = (yystrm := strm; (continue()))
fun yyAction64 (strm, lastMatch : yymatch) = (yystrm := strm;
      (YYBEGIN INITIAL;continue()))
fun yyAction65 (strm, lastMatch : yymatch) = (yystrm := strm; (continue()))
fun yyAction66 (strm, lastMatch : yymatch) = (yystrm := strm;
      (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue()))
fun yyAction67 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (ErrorMsg.error yypos ("illegal character " ^ yytext); continue())
      end
fun yyQ125 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction57(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction57(strm, yyNO_MATCH)
      (* end case *))
fun yyQ124 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction58(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction58(strm, yyNO_MATCH)
      (* end case *))
fun yyQ5 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #"\v"
              then yyQ124(strm', lastMatch)
            else if inp < #"\v"
              then if inp = #"\n"
                  then if yyInput.eof(!(yystrm))
                      then UserDeclarations.eof(yyarg)
                      else yystuck(lastMatch)
                  else yyQ124(strm', lastMatch)
            else if inp = #"\""
              then yyQ125(strm', lastMatch)
              else yyQ124(strm', lastMatch)
      (* end case *))
fun yyQ73 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction31(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction31(strm, yyNO_MATCH)
      (* end case *))
fun yyQ72 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction18(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction18(strm, yyNO_MATCH)
      (* end case *))
fun yyQ71 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction32(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction32(strm, yyNO_MATCH)
      (* end case *))
fun yyQ74 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction40(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp = #"`"
              then yyAction40(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ78 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction12(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction12(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction12(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction12(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction12(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
            else if inp = #"`"
              then yyAction12(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
                  else yyAction12(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
              else yyAction12(strm, yyNO_MATCH)
      (* end case *))
fun yyQ77 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ78(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ76 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"l"
              then yyQ77(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"l"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ75 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"i"
              then yyQ76(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"i"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ70 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"h"
              then yyQ75(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"h"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ80 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction1(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction1(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction1(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction1(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction1, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction1(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction1, yyNO_MATCH))
            else if inp = #"`"
              then yyAction1(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction1, yyNO_MATCH))
                  else yyAction1(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction1, yyNO_MATCH))
              else yyAction1(strm, yyNO_MATCH)
      (* end case *))
fun yyQ79 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ80(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ69 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"b"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"b"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ79(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ85 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction0(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction0(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction0(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction0(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction0, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction0(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction0, yyNO_MATCH))
            else if inp = #"`"
              then yyAction0(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction0, yyNO_MATCH))
                  else yyAction0(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction0, yyNO_MATCH))
              else yyAction0(strm, yyNO_MATCH)
      (* end case *))
fun yyQ84 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ85(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ83 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"p"
              then yyQ84(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"p"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ82 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction10(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction10(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction10(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction10(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction10(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
            else if inp = #"`"
              then yyAction10(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
                  else yyAction10(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
              else yyAction10(strm, yyNO_MATCH)
      (* end case *))
fun yyQ87 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction14(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction14(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction14(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction14(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction14(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
            else if inp = #"`"
              then yyAction14(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
                  else yyAction14(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
              else yyAction14(strm, yyNO_MATCH)
      (* end case *))
fun yyQ86 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ87(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ81 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ86(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ68 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"a"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"a"
              then if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction40(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                      else yyAction40(strm, yyNO_MATCH)
                else if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"_"
                  then if inp <= #"Z"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                      else yyAction40(strm, yyNO_MATCH)
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"p"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"p"
              then if inp = #"i"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"i"
                  then if inp = #"h"
                      then yyQ81(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"o"
                  then yyQ82(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp = #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"z"
              then if inp = #"y"
                  then yyQ83(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ88 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction4(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction4(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction4(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction4(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction4(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
            else if inp = #"`"
              then yyAction4(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
                  else yyAction4(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
              else yyAction4(strm, yyNO_MATCH)
      (* end case *))
fun yyQ67 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"f"
              then yyQ88(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"f"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ90 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction7(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction7(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction7(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction7(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction7(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
            else if inp = #"`"
              then yyAction7(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
                  else yyAction7(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
              else yyAction7(strm, yyNO_MATCH)
      (* end case *))
fun yyQ89 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"l"
              then yyQ90(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"l"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ66 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"i"
              then yyQ89(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"i"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ92 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction8(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction8(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction8(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction8(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction8(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
            else if inp = #"`"
              then yyAction8(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
                  else yyAction8(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
              else yyAction8(strm, yyNO_MATCH)
      (* end case *))
fun yyQ91 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"t"
              then yyQ92(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"t"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ65 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ91(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ94 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction6(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction6(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction6(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction6(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction6(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
            else if inp = #"`"
              then yyAction6(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
                  else yyAction6(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
              else yyAction6(strm, yyNO_MATCH)
      (* end case *))
fun yyQ93 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction15(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction15(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction15(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction15(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction15(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
            else if inp = #"`"
              then yyAction15(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
                  else yyAction15(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
              else yyAction15(strm, yyNO_MATCH)
      (* end case *))
fun yyQ64 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"`"
              then yyAction40(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction40(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                      else yyAction40(strm, yyNO_MATCH)
                else if inp = #"["
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #"["
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ94(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"f"
                  then yyQ93(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ102 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction2(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction2(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction2(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction2(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction2(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
            else if inp = #"`"
              then yyAction2(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
                  else yyAction2(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
              else yyAction2(strm, yyNO_MATCH)
      (* end case *))
fun yyQ101 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ102(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ100 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"o"
              then yyQ101(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"o"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ99 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"i"
              then yyQ100(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"i"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ98 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"t"
              then yyQ99(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"t"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ97 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"c"
              then yyQ98(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"c"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ96 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ97(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ103 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction11(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction11(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction11(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction11(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction11(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
            else if inp = #"`"
              then yyAction11(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
                  else yyAction11(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
              else yyAction11(strm, yyNO_MATCH)
      (* end case *))
fun yyQ95 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ103(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ63 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"`"
              then yyAction40(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction40(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                      else yyAction40(strm, yyNO_MATCH)
                else if inp = #"["
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #"["
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"u"
              then yyQ96(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"u"
              then if inp = #"o"
                  then yyQ95(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ106 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction5(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction5(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction5(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction5(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction5(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
            else if inp = #"`"
              then yyAction5(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
                  else yyAction5(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
              else yyAction5(strm, yyNO_MATCH)
      (* end case *))
fun yyQ105 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"d"
              then yyQ106(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"d"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ108 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction13(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction13(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction13(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction13(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction13(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
            else if inp = #"`"
              then yyAction13(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
                  else yyAction13(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
              else yyAction13(strm, yyNO_MATCH)
      (* end case *))
fun yyQ107 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ108(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ104 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"s"
              then yyQ107(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"s"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ62 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"`"
              then yyAction40(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction40(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                      else yyAction40(strm, yyNO_MATCH)
                else if inp = #"["
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #"["
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ105(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"l"
                  then yyQ104(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ109 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction9(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction9(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction9(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction9(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction9(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
            else if inp = #"`"
              then yyAction9(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
                  else yyAction9(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
              else yyAction9(strm, yyNO_MATCH)
      (* end case *))
fun yyQ61 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"o"
              then yyQ109(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"o"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ113 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction3(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction3(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction3(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction3(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction3(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
            else if inp = #"`"
              then yyAction3(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
                  else yyAction3(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
              else yyAction3(strm, yyNO_MATCH)
      (* end case *))
fun yyQ112 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"k"
              then yyQ113(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"k"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ111 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"b"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"b"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ112(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ110 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ111(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ60 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ110(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ117 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction16(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction16(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction16(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction16(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction16(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
            else if inp = #"`"
              then yyAction16(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
                  else yyAction16(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
              else yyAction16(strm, yyNO_MATCH)
      (* end case *))
fun yyQ116 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"y"
              then yyQ117(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"y"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp = #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ115 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"b"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"b"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ116(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ114 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ115(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ59 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ114(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ58 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction35(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction35(strm, yyNO_MATCH)
      (* end case *))
fun yyQ57 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction36(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction36(strm, yyNO_MATCH)
      (* end case *))
fun yyQ56 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction40(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction40(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction40(strm, yyNO_MATCH)
                      else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction40(strm, yyNO_MATCH)
                  else yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
            else if inp = #"`"
              then yyAction40(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
                  else yyAction40(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ74(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ118 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction20(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction20(strm, yyNO_MATCH)
      (* end case *))
fun yyQ55 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction21(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"="
              then yyQ118(strm', yyMATCH(strm, yyAction21, yyNO_MATCH))
              else yyAction21(strm, yyNO_MATCH)
      (* end case *))
fun yyQ54 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction25(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction25(strm, yyNO_MATCH)
      (* end case *))
fun yyQ120 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction24(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction24(strm, yyNO_MATCH)
      (* end case *))
fun yyQ119 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction22(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction22(strm, yyNO_MATCH)
      (* end case *))
fun yyQ53 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction23(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #">"
              then yyQ120(strm', yyMATCH(strm, yyAction23, yyNO_MATCH))
            else if inp < #">"
              then if inp = #"="
                  then yyQ119(strm', yyMATCH(strm, yyAction23, yyNO_MATCH))
                  else yyAction23(strm, yyNO_MATCH)
              else yyAction23(strm, yyNO_MATCH)
      (* end case *))
fun yyQ52 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction37(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction37(strm, yyNO_MATCH)
      (* end case *))
fun yyQ121 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction17(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction17(strm, yyNO_MATCH)
      (* end case *))
fun yyQ51 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction39(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"="
              then yyQ121(strm', yyMATCH(strm, yyAction39, yyNO_MATCH))
              else yyAction39(strm, yyNO_MATCH)
      (* end case *))
fun yyQ122 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction41(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ122(strm', yyMATCH(strm, yyAction41, yyNO_MATCH))
            else if inp < #"0"
              then yyAction41(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ122(strm', yyMATCH(strm, yyAction41, yyNO_MATCH))
              else yyAction41(strm, yyNO_MATCH)
      (* end case *))
fun yyQ50 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction41(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ122(strm', yyMATCH(strm, yyAction41, yyNO_MATCH))
            else if inp < #"0"
              then yyAction41(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ122(strm', yyMATCH(strm, yyAction41, yyNO_MATCH))
              else yyAction41(strm, yyNO_MATCH)
      (* end case *))
fun yyQ123 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction62(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction62(strm, yyNO_MATCH)
      (* end case *))
fun yyQ49 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction26(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"*"
              then yyQ123(strm', yyMATCH(strm, yyAction26, yyNO_MATCH))
              else yyAction26(strm, yyNO_MATCH)
      (* end case *))
fun yyQ48 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction30(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction30(strm, yyNO_MATCH)
      (* end case *))
fun yyQ47 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction28(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction28(strm, yyNO_MATCH)
      (* end case *))
fun yyQ46 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction38(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction38(strm, yyNO_MATCH)
      (* end case *))
fun yyQ45 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction29(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction29(strm, yyNO_MATCH)
      (* end case *))
fun yyQ44 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction27(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction27(strm, yyNO_MATCH)
      (* end case *))
fun yyQ43 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction33(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction33(strm, yyNO_MATCH)
      (* end case *))
fun yyQ42 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction34(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction34(strm, yyNO_MATCH)
      (* end case *))
fun yyQ41 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction19(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction19(strm, yyNO_MATCH)
      (* end case *))
fun yyQ40 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction42(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction42(strm, yyNO_MATCH)
      (* end case *))
fun yyQ39 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction66(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction66(strm, yyNO_MATCH)
      (* end case *))
fun yyQ16 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction66(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction66(strm, yyNO_MATCH)
      (* end case *))
fun yyQ38 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction65(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction65(strm, yyNO_MATCH)
      (* end case *))
fun yyQ37 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction67(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction67(strm, yyNO_MATCH)
      (* end case *))
fun yyQ4 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #"A"
              then yyQ56(strm', lastMatch)
            else if inp < #"A"
              then if inp = #")"
                  then yyQ43(strm', lastMatch)
                else if inp < #")"
                  then if inp = #" "
                      then yyQ38(strm', lastMatch)
                    else if inp < #" "
                      then if inp = #"\v"
                          then yyQ37(strm', lastMatch)
                        else if inp < #"\v"
                          then if inp = #"\t"
                              then yyQ38(strm', lastMatch)
                            else if inp = #"\n"
                              then yyQ16(strm', lastMatch)
                              else yyQ37(strm', lastMatch)
                        else if inp = #"\r"
                          then yyQ39(strm', lastMatch)
                          else yyQ37(strm', lastMatch)
                    else if inp = #"&"
                      then yyQ41(strm', lastMatch)
                    else if inp < #"&"
                      then if inp = #"\""
                          then yyQ40(strm', lastMatch)
                          else yyQ37(strm', lastMatch)
                    else if inp = #"'"
                      then yyQ37(strm', lastMatch)
                      else yyQ42(strm', lastMatch)
                else if inp = #"0"
                  then yyQ50(strm', lastMatch)
                else if inp < #"0"
                  then if inp = #"-"
                      then yyQ47(strm', lastMatch)
                    else if inp < #"-"
                      then if inp = #"+"
                          then yyQ45(strm', lastMatch)
                        else if inp = #"*"
                          then yyQ44(strm', lastMatch)
                          else yyQ46(strm', lastMatch)
                    else if inp = #"."
                      then yyQ48(strm', lastMatch)
                      else yyQ49(strm', lastMatch)
                else if inp = #"<"
                  then yyQ53(strm', lastMatch)
                else if inp < #"<"
                  then if inp = #":"
                      then yyQ51(strm', lastMatch)
                    else if inp = #";"
                      then yyQ52(strm', lastMatch)
                      else yyQ50(strm', lastMatch)
                else if inp = #">"
                  then yyQ55(strm', lastMatch)
                else if inp = #"="
                  then yyQ54(strm', lastMatch)
                  else yyQ37(strm', lastMatch)
            else if inp = #"l"
              then yyQ65(strm', lastMatch)
            else if inp < #"l"
              then if inp = #"c"
                  then yyQ56(strm', lastMatch)
                else if inp < #"c"
                  then if inp = #"]"
                      then yyQ58(strm', lastMatch)
                    else if inp < #"]"
                      then if inp = #"["
                          then yyQ57(strm', lastMatch)
                        else if inp = #"\\"
                          then yyQ37(strm', lastMatch)
                          else yyQ56(strm', lastMatch)
                    else if inp = #"a"
                      then yyQ59(strm', lastMatch)
                    else if inp = #"b"
                      then yyQ60(strm', lastMatch)
                      else yyQ37(strm', lastMatch)
                else if inp = #"g"
                  then yyQ56(strm', lastMatch)
                else if inp < #"g"
                  then if inp = #"e"
                      then yyQ62(strm', lastMatch)
                    else if inp = #"d"
                      then yyQ61(strm', lastMatch)
                      else yyQ63(strm', lastMatch)
                else if inp = #"i"
                  then yyQ64(strm', lastMatch)
                  else yyQ56(strm', lastMatch)
            else if inp = #"v"
              then yyQ69(strm', lastMatch)
            else if inp < #"v"
              then if inp = #"p"
                  then yyQ56(strm', lastMatch)
                else if inp < #"p"
                  then if inp = #"n"
                      then yyQ66(strm', lastMatch)
                    else if inp = #"m"
                      then yyQ56(strm', lastMatch)
                      else yyQ67(strm', lastMatch)
                else if inp = #"t"
                  then yyQ68(strm', lastMatch)
                  else yyQ56(strm', lastMatch)
            else if inp = #"|"
              then yyQ72(strm', lastMatch)
            else if inp < #"|"
              then if inp = #"x"
                  then yyQ56(strm', lastMatch)
                else if inp < #"x"
                  then yyQ70(strm', lastMatch)
                else if inp = #"{"
                  then yyQ71(strm', lastMatch)
                  else yyQ56(strm', lastMatch)
            else if inp = #"}"
              then yyQ73(strm', lastMatch)
              else yyQ37(strm', lastMatch)
      (* end case *))
fun yyQ29 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction52(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction52(strm, yyNO_MATCH)
      (* end case *))
fun yyQ28 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction51(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction51(strm, yyNO_MATCH)
      (* end case *))
fun yyQ27 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction50(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction50(strm, yyNO_MATCH)
      (* end case *))
fun yyQ30 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ30(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp < #"0"
              then yyAction55(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ30(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
              else yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ26 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ30(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp < #"0"
              then yyAction55(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ30(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
              else yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ33 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction49(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ30(strm', yyMATCH(strm, yyAction49, yyNO_MATCH))
            else if inp < #"0"
              then yyAction49(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ30(strm', yyMATCH(strm, yyAction49, yyNO_MATCH))
              else yyAction49(strm, yyNO_MATCH)
      (* end case *))
fun yyQ32 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"6"
              then yyQ30(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp < #"6"
              then if inp <= #"/"
                  then yyAction55(strm, yyNO_MATCH)
                  else yyQ33(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp <= #"9"
              then yyQ30(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
              else yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ34 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction48(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ30(strm', yyMATCH(strm, yyAction48, yyNO_MATCH))
            else if inp < #"0"
              then yyAction48(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ30(strm', yyMATCH(strm, yyAction48, yyNO_MATCH))
              else yyAction48(strm, yyNO_MATCH)
      (* end case *))
fun yyQ31 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ34(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp < #"0"
              then yyAction55(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ34(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
              else yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ25 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"5"
              then yyQ32(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp < #"5"
              then if inp <= #"/"
                  then yyAction55(strm, yyNO_MATCH)
                  else yyQ31(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp <= #"9"
              then yyQ30(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
              else yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ36 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction47(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ30(strm', yyMATCH(strm, yyAction47, yyNO_MATCH))
            else if inp < #"0"
              then yyAction47(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ30(strm', yyMATCH(strm, yyAction47, yyNO_MATCH))
              else yyAction47(strm, yyNO_MATCH)
      (* end case *))
fun yyQ35 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ36(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp < #"0"
              then yyAction55(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ36(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
              else yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ24 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ35(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
            else if inp < #"0"
              then yyAction55(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ35(strm', yyMATCH(strm, yyAction55, yyNO_MATCH))
              else yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ23 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction53(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction53(strm, yyNO_MATCH)
      (* end case *))
fun yyQ22 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction54(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction54(strm, yyNO_MATCH)
      (* end case *))
fun yyQ21 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction54(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction54(strm, yyNO_MATCH)
      (* end case *))
fun yyQ20 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction56(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction56(strm, yyNO_MATCH)
      (* end case *))
fun yyQ3 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #"2"
              then yyQ25(strm', lastMatch)
            else if inp < #"2"
              then if inp = #"\^N"
                  then yyQ20(strm', lastMatch)
                else if inp < #"\^N"
                  then if inp = #"\n"
                      then yyQ22(strm', lastMatch)
                    else if inp < #"\n"
                      then if inp = #"\t"
                          then yyQ21(strm', lastMatch)
                          else yyQ20(strm', lastMatch)
                    else if inp = #"\r"
                      then yyQ21(strm', lastMatch)
                      else yyQ20(strm', lastMatch)
                else if inp = #"\""
                  then yyQ23(strm', lastMatch)
                else if inp < #"\""
                  then if inp = #" "
                      then yyQ21(strm', lastMatch)
                      else yyQ20(strm', lastMatch)
                else if inp <= #"/"
                  then yyQ20(strm', lastMatch)
                  else yyQ24(strm', lastMatch)
            else if inp = #"g"
              then yyQ20(strm', lastMatch)
            else if inp < #"g"
              then if inp = #"\\"
                  then yyQ27(strm', lastMatch)
                else if inp < #"\\"
                  then if inp <= #"9"
                      then yyQ26(strm', lastMatch)
                      else yyQ20(strm', lastMatch)
                else if inp = #"f"
                  then yyQ21(strm', lastMatch)
                  else yyQ20(strm', lastMatch)
            else if inp = #"o"
              then yyQ20(strm', lastMatch)
            else if inp < #"o"
              then if inp = #"n"
                  then yyQ28(strm', lastMatch)
                  else yyQ20(strm', lastMatch)
            else if inp = #"t"
              then yyQ29(strm', lastMatch)
              else yyQ20(strm', lastMatch)
      (* end case *))
fun yyQ19 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction64(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction64(strm, yyNO_MATCH)
      (* end case *))
fun yyQ18 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction63(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"/"
              then yyQ19(strm', yyMATCH(strm, yyAction63, yyNO_MATCH))
              else yyAction63(strm, yyNO_MATCH)
      (* end case *))
fun yyQ17 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction63(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction63(strm, yyNO_MATCH)
      (* end case *))
fun yyQ15 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction63(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction63(strm, yyNO_MATCH)
      (* end case *))
fun yyQ14 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction63(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction63(strm, yyNO_MATCH)
      (* end case *))
fun yyQ2 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #" "
              then yyQ15(strm', lastMatch)
            else if inp < #" "
              then if inp = #"\v"
                  then yyQ14(strm', lastMatch)
                else if inp < #"\v"
                  then if inp = #"\t"
                      then yyQ15(strm', lastMatch)
                    else if inp = #"\n"
                      then yyQ16(strm', lastMatch)
                      else yyQ14(strm', lastMatch)
                else if inp = #"\r"
                  then yyQ17(strm', lastMatch)
                  else yyQ14(strm', lastMatch)
            else if inp = #"+"
              then yyQ14(strm', lastMatch)
            else if inp < #"+"
              then if inp = #"*"
                  then yyQ18(strm', lastMatch)
                  else yyQ14(strm', lastMatch)
            else if inp = #"f"
              then yyQ15(strm', lastMatch)
              else yyQ14(strm', lastMatch)
      (* end case *))
fun yyQ13 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction60(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction60(strm, yyNO_MATCH)
      (* end case *))
fun yyQ12 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction59(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction59(strm, yyNO_MATCH)
      (* end case *))
fun yyQ11 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction59(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction59(strm, yyNO_MATCH)
      (* end case *))
fun yyQ10 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction61(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction61(strm, yyNO_MATCH)
      (* end case *))
fun yyQ1 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #" "
              then yyQ11(strm', lastMatch)
            else if inp < #" "
              then if inp = #"\v"
                  then yyQ10(strm', lastMatch)
                else if inp < #"\v"
                  then if inp = #"\t"
                      then yyQ11(strm', lastMatch)
                    else if inp = #"\n"
                      then yyQ12(strm', lastMatch)
                      else yyQ10(strm', lastMatch)
                else if inp = #"\r"
                  then yyQ11(strm', lastMatch)
                  else yyQ10(strm', lastMatch)
            else if inp = #"]"
              then yyQ10(strm', lastMatch)
            else if inp < #"]"
              then if inp = #"\\"
                  then yyQ13(strm', lastMatch)
                  else yyQ10(strm', lastMatch)
            else if inp = #"f"
              then yyQ11(strm', lastMatch)
              else yyQ10(strm', lastMatch)
      (* end case *))
fun yyQ9 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction44(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction44(strm, yyNO_MATCH)
      (* end case *))
fun yyQ8 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ7 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction45(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction45(strm, yyNO_MATCH)
      (* end case *))
fun yyQ6 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction46(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction46(strm, yyNO_MATCH)
      (* end case *))
fun yyQ0 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #"\""
              then yyQ8(strm', lastMatch)
            else if inp < #"\""
              then if inp = #"\n"
                  then yyQ7(strm', lastMatch)
                  else yyQ6(strm', lastMatch)
            else if inp = #"\\"
              then yyQ9(strm', lastMatch)
              else yyQ6(strm', lastMatch)
      (* end case *))
in
  (case (!(yyss))
   of STRING => yyQ0(!(yystrm), yyNO_MATCH)
    | WHITESPACE => yyQ1(!(yystrm), yyNO_MATCH)
    | COMMENT => yyQ2(!(yystrm), yyNO_MATCH)
    | ESCAPE => yyQ3(!(yystrm), yyNO_MATCH)
    | INITIAL => yyQ4(!(yystrm), yyNO_MATCH)
    | ILLEGALSTRING => yyQ5(!(yystrm), yyNO_MATCH)
  (* end case *))
end
            end
	  in 
            continue() 	  
	    handle IO.Io{cause, ...} => raise cause
          end
        in 
          lex 
        end
    in
    fun makeLexer yyinputN = mk (yyInput.mkStream yyinputN)
    fun makeLexer' ins = mk (yyInput.mkStream ins)
    end

  end
