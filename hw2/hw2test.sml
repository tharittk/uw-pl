(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw2.sml";
(* 
(* all_except_option *)
val t1_none = all_except_option ("strings", ["string"]) = NONE
val t1_none2 = all_except_option ("string", []) = NONE
val t1_emp= all_except_option ("string", ["string"]) = SOME []
val t1_1 = all_except_option ("string", ["string", "a"]) = SOME ["a"]
val t1_2 = all_except_option ("string", ["string", "a", "b"]) = SOME ["a","b"]


(* get_substitution1 *)
val t2_emp = get_substitutions1 ([["foo"],["there"]], "foo") = []
val t2_emp2 = get_substitutions1 ([["foo2"],["there"], ["dumb"]], "foo") = []
val t2_1 = get_substitutions1 ([["foo", "foo2"],["there"]], "foo") = ["foo2"]
val t2_2 = get_substitutions1 ([["foo", "foo2"],["foo","foo3"]], "foo") = ["foo2", "foo3"]
val t2_3 = get_substitutions1 ([["foo", "foo2"],["foo","foo3", "foo4"]], "foo") = ["foo2", "foo3", "foo4"]
val t2_4 = get_substitutions1 ([["foo", "foo2"],["foo","foo3", "foo4", "foo2"]], "foo") = ["foo2", "foo3", "foo4", "foo2"]

(* get_substitution2 *)
val t3_emp = get_substitutions2 ([["foo"],["there"]], "foo") = []
val t3_emp2 = get_substitutions2 ([["foo2"],["there"], ["dumb"]], "foo") = []
val t3_1 = get_substitutions2 ([["foo", "foo2"],["there"]], "foo") = ["foo2"]
val t3_2 = get_substitutions2 ([["foo", "foo2"],["foo","foo3"]], "foo") = ["foo2", "foo3"]
val t3_3 = get_substitutions2 ([["foo", "foo2"],["foo","foo3", "foo4"]], "foo") = ["foo2", "foo3", "foo4"]
val t3_4 = get_substitutions2 ([["foo", "foo2"],["foo","foo3", "foo4", "foo2"]], "foo") = ["foo2", "foo3", "foo4", "foo2"]


val t4_0 = similar_names ([["Fredrick"],["Elizabeth","Betty"],["Freddie","F"]], 
        {first="Fred", middle="W", last="Smith"}) 
        =
	    [{first="Fred", last="Smith", middle="W"}]

val t4_1= similar_names ([["Fred"],["Elizabeth","Betty"],["Fred"]], 
        {first="Fred", middle="W", last="Smith"}) 
        =
	    [{first="Fred", last="Smith", middle="W"}]

val t4_2 = similar_names ([["Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], 
        {first="Fred", middle="W", last="Smith"}) 
        =
	    [{first="Fred", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val t4_3 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], 
        {first="Fred", middle="W", last="Smith"}) 
        =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}] *)

(* card_color *)
val t5_1 = card_color (Clubs, Num 2) = Black
val t5_2 = card_color (Hearts, Jack) = Red
val t5_3 = card_color (Diamonds, Num 10) = Red
val t5_4 = card_color (Spades, Queen) = Black

(* card_value *)
val t6_1 = card_value (Clubs, Num 2) = 2
val t6_2 = card_value (Hearts, Jack) = 10
val t6_3 = card_value (Diamonds, Ace) = 11
val t6_4 = card_value (Spades, Num 10) = 10

(* remove_card *)

val t7_0 = remove_card ([(Clubs, Num 2)], 
                (Clubs, Num 2), IllegalMove) 
                = 
                []
val t7_emp = remove_card ([], 
                (Clubs, Num 2), IllegalMove) handle IllegalMove => [(Spades, Num 99)]

val t7_noexist = remove_card ([(Hearts, Jack)], 
                (Clubs, Num 2), IllegalMove)  handle IllegalMove => [(Spades, Num 99)]

val t7_1 = remove_card ([(Clubs, Num 2), (Hearts, Jack), (Clubs, Num 2)], 
                (Clubs, Num 2), IllegalMove) 
                = 
                [(Hearts, Jack), (Clubs, Num 2)]
val t7_2 = remove_card ([(Clubs, Num 3), (Hearts, Jack), (Clubs, Num 2)], 
                (Clubs, Num 2), IllegalMove) 
                = 
                [(Clubs, Num 3),(Hearts, Jack)]


val t8_dup = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val t8_red = all_same_color [(Hearts, Ace), (Diamonds, Num 2)] = true
val t8_redblack = all_same_color [(Hearts, Ace), (Diamonds, Num 2), (Spades, King)] = false
val t8_black = all_same_color [(Clubs, Ace), (Spades, King)] = true
val t8_emp = all_same_color [] = true


val t9_emp = sum_cards [] = 0
val t9_1 = sum_cards [(Clubs, Num 2)] = 2
val t9_num = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val t9_all = sum_cards [(Clubs, Jack),(Clubs, Queen), (Hearts, Ace), (Spades, King), (Clubs, Num 2)] = 43


val t10_emp = score ([],6) = 3
val t10_lt_df = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val t10_gt_df = score ([(Hearts, Num 2),(Clubs, Num 4)],3) = 9
val t10_eq_df = score ([(Hearts, Num 2),(Clubs, Num 4)],6) = 0
val t10_lt_sm = score ([(Hearts, Num 2),(Hearts, Num 4)],10) = 2
val t10_gt_sm = score ([(Hearts, Num 2),(Diamonds, Num 4)],3) = 4
val t10_eq_sm = score ([(Spades, Num 2),(Clubs, Num 4)],6) = 0



val cardList = [(Clubs, Num 1), (Diamonds, Num 2), (Hearts, Num 3), (Spades, Num 4),
                (Clubs, Jack), (Diamonds, Queen), (Hearts, King), (Spades, Ace)]

val t11_all_emp = officiate ([], [], 6) = 3
val t11_noMove = officiate (cardList, [], 2) = 1
val t11_noCard = officiate ([], [Draw], 4) = 2
val t11_draw1stop = officiate ([(Clubs,Num 8)], [Draw], 6) = 3
val t11_draw1 =  officiate (cardList, [Draw], 2) = 0
val t11_draw2 =  officiate (cardList, [Draw, Draw], 2) = 3

val t11_drawExceed =  officiate (cardList, [Draw, Draw, Draw, Draw], 4) = 6
val t11_drawAll_lt = officiate( cardList, [Draw, Draw, Draw, Draw,Draw, Draw, Draw, Draw], 52) = 1
val t11_drawAll_gt = officiate( cardList, [Draw, Draw, Draw, Draw,Draw, Draw, Draw, Draw], 50) = 3

(* Discard implementation *)
val t11_drawDiscCont = officiate (cardList, [Draw, Draw, Discard(Diamonds, Num 2), Draw, Draw], 9 ) = 1
val t11_draw2disc =  officiate (cardList, [Draw, Draw, Discard(Clubs, Num 1)], 10) = 4
val t11_draw2discErr =  officiate (cardList, [Draw, Draw, Discard(Clubs, Num 3)], 10) handle IllegalMove => 99

(* 

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
             
              *)
