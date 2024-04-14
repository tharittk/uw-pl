fun is_older (date1: int*int*int, date2: int*int*int) =
    (#1 date1 < #1 date2) orelse (#1 date1 = #1 date2 andalso #2 date1 < #2 date2) 
    orelse (#1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2)

fun number_in_month (dates: (int*int*int) list, month: int) =
    if dates = []
    then 0
    else 
        if #2 (hd dates) = month
        then 1 + number_in_month(tl dates, month)
        else number_in_month(tl dates, month)

fun number_in_months (dates: (int*int*int) list, months: int list) =
    if months = []
    then 0
    else number_in_month(dates, hd months) + number_in_months (dates, tl months)

fun dates_in_month (dates: (int*int*int) list, month:int) =
    if dates = []
    then []
    else 
        if #2 (hd dates) = month
        then hd dates :: dates_in_month (tl dates, month)
        else dates_in_month (tl dates, month)

fun dates_in_months (dates: (int*int*int) list, months: int list) =
    if months = []
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

fun get_nth (strings: string list , n:int) =
    if n = 1
    then hd strings
    else get_nth (tl strings, n - 1)

fun date_to_string (date:int*int*int) =
    let
        val num2month = ["January", "February", "March", "April","May", "June", "July",
                     "August", "September", "October", "November", "December"]
        val day = #3 date
        val month = get_nth (num2month, #2 date)
        val year = #1 date    
    in
        month ^ " " ^ Int.toString(day) ^ ", " ^ Int.toString(year)
    end
    
fun number_before_reaching_sum (sum:int, nums: int list) =
    if sum <= (hd nums)
    then 0
    else 1 + number_before_reaching_sum (sum - (hd nums), tl nums)

fun what_month (day: int) =
    let
        val month2days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]      
    in
        number_before_reaching_sum (day, month2days) + 1
    end

fun month_range (day1:int, day2:int) = 
    if (day1 > day2)
    then []
    else what_month (day1) :: month_range (day1 + 1, day2)

fun oldest (dates: (int*int*int) list) =
    if null dates
    then NONE
    else
        let fun oldest_not_empty (dates: (int*int*int) list) =
            if null (tl dates)
            then hd dates
            else 
                let 
                    val oldest_ans = oldest_not_empty (tl dates)
                in
                   if is_older (hd dates, oldest_ans ) 
                   then hd dates
                   else oldest_ans
                end
        in 
            SOME (oldest_not_empty dates)
        end



(* fun number_in_months_challenge (dates: (int*int*int) list, months: int list) = *)
fun remove_duplicate_month (months: int list, current_months: int list) =
    let
        fun check_existance (nums: int list, n: int) = 
            if nums = []
            then false
            else 
                if (hd nums) = n
                then true
                else check_existance (tl nums, n)

    in
        if months = []
        then []
        else 
            if check_existance(current_months, (hd months))
            then      
                remove_duplicate_month (tl months, current_months)        
            else 
                hd months::remove_duplicate_month (tl months, current_months @ [hd months])        
    end



fun number_in_months_challenge (dates: (int*int*int) list, months: int list) =
    let 
        val month_unique = remove_duplicate_month (months, [0])
    in
        number_in_months (dates, month_unique)
    end


fun dates_in_months_challenge (dates: (int*int*int) list, months: int list) =
    let 
        val month_unique = remove_duplicate_month (months, [0])
    in
        dates_in_months (dates, month_unique)
    end