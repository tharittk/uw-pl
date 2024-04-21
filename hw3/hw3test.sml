(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3.sml";

(* Q. 1 *)
val t1_1 = only_capitals ["A","B","C"] = ["A","B","C"]
val t1_2 = only_capitals ["A","bB","C"] = ["A","C"]
val t1_3 = only_capitals [] = []
val t1_4 = only_capitals ["aBc", "lkA"] = []

(* Q. 2 *)
val t2_1 = longest_string1 ["A","bc","C"] = "bc"
val t2_2 = longest_string1 ["Aa","bc","C"] = "Aa"
val t2_last = longest_string1 ["A","bc","Cde", "fghk"] = "fghk"
val t2_emp = longest_string1 [] = ""
val t2_3 = longest_string1 ["bc"] = "bc"
val t2_tie3 = longest_string1 ["A","bcde","Cde", "fghk"] = "bcde"

(* Q.3 *)
val t3_1 = longest_string2 ["A","bc","C"] = "bc"
val t3_2 = longest_string2 ["Aa","bc","C"] = "bc"
val t3_last = longest_string2 ["A","bc","Cde", "fghk"] = "fghk"
val t3_emp = longest_string2 [] = ""
val t3_3 = longest_string2 ["bc"] = "bc"
val t3_tie3 = longest_string2 ["A","bcde","Cde", "fghk"] = "fghk"

(* Q.4 *)
val t4a_1 = longest_string3 ["A","bc","C"] = "bc"
val t4a_2 = longest_string3 ["Aa","bc","C"] = "Aa"
val t4a_last = longest_string3 ["A","bc","Cde", "fghk"] = "fghk"
val t4a_emp = longest_string3 [] = ""
val t4a_3 = longest_string3 ["bc"] = "bc"
val t4a_tie3 = longest_string3 ["A","bcde","Cde", "fghk"] = "bcde"

val t4b_1 = longest_string4 ["A","bc","C"] = "bc"
val t4b_2 = longest_string4 ["Aa","bc","C"] = "bc"
val t4b_last = longest_string4 ["A","bc","Cde", "fghk"] = "fghk"
val t4b_emp = longest_string4 [] = ""
val t4b_3 = longest_string4 ["bc"] = "bc"
val t4b_tie3 = longest_string4 ["A","bcde","Cde", "fghk"] = "fghk"

(* Q.5  *)
val t5_emp = longest_capitalized [] = ""
val t5_1 = longest_capitalized ["A","bc","C"] = "A"
val t5_2 = longest_capitalized ["aa","bDc","efg"] = ""
val t5_3 = longest_capitalized ["aad","AbDc","Defg"] = "AbDc"
val t5_4 = longest_capitalized ["Abcdefg","ABCDEF","asdeasdcxx"] = "Abcdefg"

(* Q. 6 *)
val t6_1 = rev_string "abc" = "cba"
val t6_2 = rev_string "aBC" = "CBa"
val t6_3 = rev_string "aBcDe" = "eDcBa"
val t6_4 = rev_string "ABCD" = "DCBA"
val t6_emp = rev_string "" = ""

(* Q.7 *)
val t7_1 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val t7_2 = first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5] handle NoAnswer => 99
val t7_single = first_answer (fn x => if x > 0 then SOME x else NONE) [1] = 1
val t7_single2 = first_answer (fn x => if x > 1 then SOME x else NONE) [1] handle NoAnswer => 99
val t7_emp = first_answer (fn x => if x > 1 then SOME x else NONE) [] handle NoAnswer => 99

(* Q. 8 *)
val t8_emp = all_answers (fn x => if x > 1 then SOME [x] else NONE) [] = SOME []
val t8_1 = all_answers (fn x => if x > 1 then SOME [x] else NONE) [2] = SOME [2]
val t8_3 = all_answers (fn x => if x > 1 then SOME [x] else NONE) [2,3,4] = SOME [2,3,4]
val t8_n = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

(* 

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1

val test10 = check_pat (Variable("x")) = true

val test11 = match (Const(1), UnitP) = NONE

val test12 = first_match Unit [UnitP] = SOME [] *)

