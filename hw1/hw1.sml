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



(* Challenge problem *)
fun check_existance (num_list: int list, n: int) = 
    if num_list = []
    then false
    else 
        if (hd num_list) = n
        then true
        else check_existance (tl num_list, n)

fun remove_duplicate_month (months: int list, current_months: int list) =
    if months = []
    then []
    else 
        if check_existance(current_months, (hd months))
        then
            (* already exist, continue recursion *)
            remove_duplicate_month (tl months, current_months)        
        else 
            (* newly exist, append to the current month *)
            hd months::remove_duplicate_month (tl months, current_months @ [hd months])        

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

fun reasonable_date (date: int*int*int) =
    let
        fun is_year_ok (yr: int) =
            if yr <= 0
            then false
            else true
        
        fun is_month_ok (month: int) =
            if (month < 1) orelse (month > 12)
            then false
            else true

        fun max_day_in_month(month: int) =
            let
                val month31 = [1,3,5,7,8,10,12]
                val month30 = [4,6,9,11]
            in
                if check_existance(month31, month)
                then 31
                else
                    if check_existance (month30, month)
                    then 30
                    else 29
            end

        fun is_day_ok_month (day:int, month: int) =
            if (day <= 0) orelse (day > max_day_in_month (month))
            then false
            else true
            
        fun is_leap_year (yr: int) =
            if ( (yr mod 400) = 0 orelse (yr mod 4) = 0) andalso not (yr mod 100 = 0)
            then true
            else false
    in
        if (not (is_year_ok (#1 date)) ) orelse (not (is_month_ok (#2 date)))
        then false
        else
            (* number of days valid with its specified month *)
            if not (is_day_ok_month (#3 date, #2 date))
            then false
            else
                if (#2 date) = 2
                (* check leap year *)
                then 
                    if (#3 date = 29)
                    (* only valid if a leap year *)
                    then is_leap_year (#1 date)
                    (* less than 29 *)
                    else true
                (* not February *)
                else true
    end
