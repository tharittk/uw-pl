(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* 1.a *)
(* helper function for all_except_option *)
fun is_str_in_strList (str, strList) =
   case strList of
      [] => false
      |  s::strList' => if same_string(str, s) 
                        then true
                        else false orelse is_str_in_strList (str, strList')
                        
(* output the list or empty list *)
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

(* 1.b *)
fun get_substitutions1 (substitutions, s) =
   case substitutions of
      [] => []
      | strList::substitutions' => case all_except_option (s, strList) of
                                 NONE => get_substitutions1 (substitutions', s)
                                 | SOME lst =>  lst @ get_substitutions1 (substitutions', s)
                              


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

