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

(* Q. 9 abc *)
val t9a_1 = count_wildcards Wildcard = 1
val t9a_0 = count_wildcards (Variable ("a")) = 0
val t9a_2 = count_wildcards ( TupleP [Wildcard, Wildcard, Variable("b")]  )= 2
val t9a_2type = count_wildcards ( ConstructorP("h", TupleP [Wildcard, Wildcard, Variable("b") ]) )= 2
val t9a_nest = count_wildcards ( ConstructorP("h", ConstructorP("k", TupleP [Wildcard, Wildcard, Variable("b") ]) ) )=2
val t9a_unit = count_wildcards ( UnitP) = 0


val t9b_1 = count_wildcards_and_variable_length Wildcard = 1
val t9b_0 = count_wildcards_and_variable_length (Variable("aDef")) = 4
val t9b_2 = count_wildcards_and_variable_length ( TupleP [Wildcard, Wildcard, Variable("b2d")]  )= 5
val t9b_2type = count_wildcards_and_variable_length ( ConstructorP("h", TupleP [Wildcard, Wildcard, Variable("b") ]) )= 3
val t9b_nest = count_wildcards_and_variable_length ( ConstructorP("h", ConstructorP("k", TupleP [Wildcard, Wildcard, Variable("De") ]) ) )=4
val t9b_unit = count_wildcards_and_variable_length (UnitP ) = 0


val t9c_1 = count_some_var ("x", Variable("x") ) = 1
val t9c_nest = count_some_var ("De", ConstructorP("h", ConstructorP("De", TupleP [Wildcard, Wildcard, Variable("De") ]) ) ) = 1
val t9c_2type = count_some_var ("h", ConstructorP("h", TupleP [Wildcard, Wildcard, Variable("b") ]) )= 0
val t9c_0 = count_some_var ("h", Wildcard ) = 0
val t9c_2 = count_some_var ("De", ConstructorP("h", ConstructorP("De", TupleP [Variable("De"),Wildcard, Wildcard, Variable("De") ]) ) ) = 2
val t9c_unit = count_some_var ("h", UnitP ) = 0

val t10_1 = check_pat (Variable("x")) = true
val t10_n2f = check_pat (ConstructorP("h", ConstructorP("De", TupleP [Variable("De"),Wildcard, Wildcard, Variable("De") ]) ) ) = false
val t10_n2t = check_pat (ConstructorP("h", ConstructorP("De", TupleP [Variable("De"),Wildcard, Wildcard, Variable("Dex") ]) ) ) = true
val t10_unit = check_pat (UnitP ) = true
val t10_2type = check_pat (ConstructorP("h", TupleP [Wildcard, Wildcard, Variable("b") ]) )= true
val t10_wc = check_pat (Wildcard) = true

val t11_0 = match (Const(1), UnitP) = NONE
val t11_cnst1 = match (Const(1), ConstP(2)) = NONE
val t11_cnst2 = match (Const(1), ConstP(1)) = SOME []
val t11_var = match (Const(1), Variable("c")) = SOME [("c", Const(1))]

val t11_cons = match (
    Constructor("h", Constructor("De", Const(2)) ), 
    ConstructorP("h", ConstructorP("De", Variable("k")) ) ) = SOME ([("k", Const(2))]) 

val t11_cons1var = match (
    Constructor("h", Constructor("De", Tuple[Const(9), Const(5), Const(2) ]) ), 
    ConstructorP("h", ConstructorP("De", TupleP [Variable("De2"),Wildcard, ConstP(2) ]) ) ) = SOME [("De2", Const(9))]

val t11_cons2var = match (
    Constructor("h", Constructor("De", Tuple[Const(9), Const(5), Const(2) ]) ), 
    ConstructorP("h", ConstructorP("De", TupleP [Variable("De2"),Wildcard, Variable("tt") ]) ) ) 
    = SOME [("De2", Const(9)), ("tt", Const(2))]


val t12_1 = first_match Unit [UnitP] = SOME []
val t12_2 = first_match (Const 9) [Variable("s")] = SOME [("s", Const(9))]
val t12_3 = first_match (Const 9) [ConstP 4,Variable("s")] = SOME [("s", Const(9))]
val t12_4 = first_match (Const 9) [ConstP 9, Variable("s")] = SOME []
val t12_5 = first_match (Const 9) [ConstP 4, ConstP 5] = NONE 
(* val t12_6 = first_match (Const 9) [ConstP 1,  ConstructorP("De", TupleP[ConstP(9), ConstP(5), ConstP(2) ])] 
val t12_7 = first_match (Const 9) [ConstP 4, ConstructorP("De", TupleP[ConstP(5), Variable "k",ConstP(2) ])]  *)
