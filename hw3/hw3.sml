 

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

(* Provided code of Q. 9 forward *)
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

(* Q. 9abc *)
val count_wildcards = g (fn _ =>1) (fn s => 0)
val count_wildcards_and_variable_length = g (fn _ =>1) (fn s => String.size(s))
fun count_some_var (s,p) = g (fn _ => 0) (fn x => if x=s then 1 else 0) p


(* Q. 10 *)
fun check_pat pat =
	let
		fun strings_used_in_variables_p (p) = 
			case p of
			Wildcard          => []
			| Variable x        => [x]
			| TupleP ps         => List.foldl (fn (p',i) => (strings_used_in_variables_p p') @ i ) [] ps
			| ConstructorP(_,p') => strings_used_in_variables_p(p')
			| _                 => []

		fun string_list_is_all_distinct (xs) = 
			case xs of
			[] => true
			| x::xs' =>  if List.exists (fn s => s=x) xs' then false else string_list_is_all_distinct (xs')
	in
	(string_list_is_all_distinct o strings_used_in_variables_p) pat
	end 

(* Q. 11 *)
fun match(v, p) =
	let
		fun aux (vs, ps, acc) = 
			case (vs, ps) of
				(vi::vs', pi::ps') => (case match(vi, pi) of
										NONE => NONE
										| SOME lst => aux (vs', ps', acc@lst))
				| ([], []) => SOME acc
				| _ => NONE
	in
		case (v, p) of
			(_, Wildcard) => SOME []
			| (vv, Variable s) => SOME [(s, vv)]
			| (Unit, UnitP) => SOME []
			| (Const c1, ConstP c2) => if c1=c2 then SOME [] else NONE
			| (Tuple vs, TupleP ps) =>
				if List.length (vs) = List.length (ps)
				then aux (vs, ps, [])
				else NONE
			| (Constructor(s2, vi), ConstructorP(s1, pi)) =>
				if (s1 = s2) then match (vi, pi) else NONE
			| (_, _) => NONE
	end

(* Q. 12 *)
fun first_match v ps = 
	SOME( first_answer (fn p => match(v, p)) ps )
	handle NoAnswer => NONE


(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
