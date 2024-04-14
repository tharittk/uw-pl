(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

(* is_older *)
val t_yr = is_older ((1,2,3),(2,3,4)) = true
val t_m = is_older ((3,2,3),(3,3,4)) = true
val t_d = is_older ((3,2,5), (3,2,6)) = true
val t_yr2 = is_older ((2,2,3),(1,3,4)) = false
val t_m2 = is_older ((3,2,3),(3,1,3)) = false
val t_d2 = is_older ((3,2,5), (3,2,3)) = false
val t_eq = is_older ((1,2,3), (1,2,3)) = false

(* number_in_month *)
val t2_emp = number_in_month ([],11) = 0
val t2_0 = number_in_month ([(2015,2,28),(2013,12,1)],3) = 0
val t2_1 = number_in_month ([(2015,2,28),(2013,12,1)],2) = 1
val t2_2 = number_in_month ([(1999,11,28),(2013,11,1)],11) = 2

(* number_in_months *)
val t3_emp = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0
val t3_emp2 = number_in_months ([],[]) = 0
val t3_emp3 = number_in_months ([],[1,2]) = 0
val t3_0 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,5,11]) = 0
val t3_3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

(* dates_in_month *)
val t4_emp = dates_in_month([], 3) = []
val t4_0 = dates_in_month ([(2012,2,28),(2013,12,1)],3) = []
val t4_1 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val t4_all = dates_in_month([(2011,5,11), (2015, 5, 12), (2019, 5, 11)], 5) = [(2011,5,11), (2015, 5, 12), (2019, 5, 11)]

(* dates_in_months *)
val t5_empd = dates_in_months([], [1,2])  = []
val t5_empm = dates_in_months([(2023,1,2), (2011, 4, 5)], [])  = []
val t5_emp_emp = dates_in_months([],[]) = []
val t5_0 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[8,9]) = []
val t5_1 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[3]) = [(2011,3,31)]
val t5_3 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

(* get_nth string *)
val t6_0 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there" 
val t6_1 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi" 
(* val t6_emp = get_nth ([], 1) = []
val t6_9 = get_nth (["hi", "there", "how", "are", "you"], 9) = [] *)

(* date_to_string *)
val t7 = date_to_string (2013, 6, 1) = "June 1, 2013" 

(* number_before_reaching_sum *)
val t8_0 = number_before_reaching_sum (1, [2,3,4,5]) = 0
val t8_1 = number_before_reaching_sum (2, [2,3,4,5]) = 0
val t8_2 = number_before_reaching_sum (5, [2,3,4,5]) = 1
val t8_3 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val t8_4 = number_before_reaching_sum (11, [1,2,3,4,5]) = 4

(* what_month *)
val t9 = what_month 70 = 3
val t9_1 = what_month 31 = 1
val t9_2 = what_month 59 = 2
val t9_3 = what_month 60 = 3

val t10 = month_range (31, 34) = [1,2,2,2]
val t10_2 = month_range (31, 31) = [1]
val t10_emp = month_range (31, 30) = []
val t10_3 = month_range (29, 31) = [1,1,1]

(* oldest *)
val t11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val t11_emp = oldest([]) = NONE
val t11_1 = oldest([(1999,4,28)]) = SOME (1999,4,28)
val t11_2 = oldest([(2011,3,31),(1999,4,28)]) = SOME (1999,4,28)

(* challenge *)

val t12 = remove_duplicate_month ([1,2,1,4,5,5,5,8,12], [0]) = [1,2,4,5,8,12]

(* number_in_months_challenge *)
val t13_emp = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0
val t13_emp2 = number_in_months_challenge ([],[]) = 0
val t13_emp3 = number_in_months_challenge ([],[1,1,2]) = 0
val t13_0 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,5,1,5,11,11]) = 0
val t13_3 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,3,4]) = 3

(* dates_in_months_challenge *)
val t15_empd = dates_in_months_challenge([], [1,2,1])  = []
val t15_empm = dates_in_months_challenge([(2023,1,2), (2011, 4, 5)], [])  = []
val t15_emp_emp = dates_in_months_challenge([],[]) = []
val t15_0 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[8,8,9,8,8,9]) = []
val t15_1 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[3,3,3]) = [(2011,3,31)]
val t15_3 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,3,2]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
