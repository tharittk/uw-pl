

(* Q. 1 *)
fun only_capitals strList = List.filter (fn x => Char.isUpper(String.sub(x, 0)) ) strList


(* Q. 2 *)
fun longest_string1 strList = List.foldl (fn (x,y) => if String.size(x) <= String.size(y) then y else x ) "" strList

(* Q. 2 *)
fun longest_string2 strList = List.foldl (fn (x,y) => if String.size(x) >= String.size(y) then x else y ) "" strList

(* Q. 4 *)
fun longest_string_helper f strList = 
				List.foldl (fn (x,y) => if f(String.size(x), String.size(y)) then x else y) "" strList

val longest_string3 = longest_string_helper (fn (x,y) => x > y)
val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

(* Q. 5 *)
val longest_capitalized = longest_string1 o only_capitals

(* Q. 6  *)
val rev_string = String.implode o List.rev o String.explode

exception NoAnswer
(* Q. 7 *)
fun first_answer f xs =     
	case xs of
		x::xs' => (case f x of
					 NONE => first_answer f xs'
					 | SOME v => v)
		| [] => raise NoAnswer

(* Q. 8 *)
fun all_answers f xs =
	let fun aux (ff, lst', acc) = 
		case lst' of
			[] => SOME acc
			| x::xs' => (case ff x of
						NONE => NONE
						| SOME lst =>  aux(ff, xs', acc @ lst))
	in
		aux(f, xs, []) 
	end

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
