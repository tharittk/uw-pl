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

(* 1.c *)
fun get_substitutions2 (substitutions, s) =
   let fun get_substitutions_acc (substitutions ,s,acc) =
      case substitutions of
      [] => acc
      | strList::substitutions' => case all_except_option (s, strList) of
                                 NONE => get_substitutions_acc (substitutions', s, acc)
                                 | SOME lst => get_substitutions_acc (substitutions', s, acc@lst)
   in
      get_substitutions_acc (substitutions, s, [])
   end

(* 1.d *)
fun similar_names (substitutions, fullName: {first:string, middle:string, last:string}) =
   let val {first = f, middle = m, last=l} = fullName
      fun substitute_all_names (nameList, m, l) =
         case nameList of
            [] => []
            | name::nameList' =>{first=name, middle=m, last=l}:: substitute_all_names (nameList', m, l)
   in
      case get_substitutions2 (substitutions, f) of
         [] => [fullName]
         | lst => fullName::substitute_all_names (lst, m, l)
   end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* 2.a *)
fun card_color (card) = 
   case card of
      (Spades, _) => Black
      | (Clubs, _) => Black
      | (Diamonds, _) => Red
      | (Hearts, _) => Red

(* 2.b *)
fun card_value (card) =
   case card of 
    (_, Num i) => i
    | (_, Ace) => 11
    | (_, _) => 10
   
(* 2.c *)
fun remove_card (cardList, c, e) =
   (* helper function *)
   let
      fun is_c_in_cardList (c, cardList) =
      case cardList of
         [] => false
         |  card::cardList' => if card = c
                           then true
                           else false orelse is_c_in_cardList (c, cardList')
   in
      if is_c_in_cardList (c, cardList)
      then
         case cardList of
            [] => []
            | card::cardList' => if card = c then cardList' else card::remove_card(cardList', c, e)
      else
         raise e
   end

(* 2.d *)
fun all_same_color (cardList) = 
   case cardList of
   [] => true
   | head::[] => true
   | head::(neck::rest) => (card_color(head) = card_color (neck)) andalso all_same_color (neck::rest)

(* 2.e *)
fun sum_cards (cardList) =
   let fun sum_cards_acc (cardList, acc) =
         case cardList of
            [] => acc
            | card::cardList' => sum_cards_acc(cardList', acc + card_value (card))
   in
      sum_cards_acc (cardList, 0)
   end

(* 2.f *)
fun score (cardList, goal) =
   let val sum = sum_cards (cardList)
      fun pre_lim_score (sum, goal) = if sum > goal then 3 * (sum - goal) else (goal - sum)
   in
      if all_same_color (cardList) 
      then pre_lim_score(sum, goal) div 2 
      else pre_lim_score (sum, goal)
   end