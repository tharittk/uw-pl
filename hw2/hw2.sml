(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* helper function for all_except_option *)
fun is_str_in_strList (str, strList) =
   case strList of
      [] => false
      |  s::strList' => if same_string(str, s) 
                        then true
                        else false orelse is_str_in_strList (str, strList')

fun all_except_option_list (str, strList) = 
   case strList of
      [] => []
      | s::strList' => if same_string (str, s) 
                     then all_except_option_list (str, strList')
                     else s::all_except_option_list (str, strList')

fun all_except_option (str, strList) = 
   if is_str_in_strList (str, strList)
   then SOME (all_except_option_list (str, strList))
   else NONE

      (* case all_except_option_list (str, strList) of
         [] => NONE *)
         (* | _ => *)




(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

