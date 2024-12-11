; Input product necessity
(defrule product_necessity_input
	(initial-fact)
	=>
	(printout t "Rate the necessity for purchase from 1 to 10" crlf)
	(bind ?necessity (read))
	(while (not (and (numberp ?necessity) (< ?necessity 11) (> ?necessity 0))) do 
		(printout t "Input for necessity should be an integer [1:10]" crlf)
		(bind ?necessity (read))
	)
	
	(assert (necessity ?necessity))
)

; Input alternative existence
(defrule alternative_existence_input
	(initial-fact)
	=>
	(printout t "Are there any alternatives?" crlf)
	(bind ?alternatives (lowcase (read)))
	(while (not (member ?alternatives (create$ y n yes no))) do 
		(printout t "Input for alternatives should be either 'y/yes' or 'n/no' in any case" crlf)
		(bind ?alternatives (lowcase (read)))
	)
	
	(assert (raw_alternatives ?alternatives))
)

; Unify alternative result
(defrule alternative_existence_unify
	(raw_alternatives ?raw_alternatives)
	=>
	(if (or (eq ?raw_alternatives yes) (eq ?raw_alternatives y))
		then (assert (alternatives TRUE))
		else (assert (alternatives FALSE))
	)	
)

; Input cost
(defrule cost_input
	(necessity_category MEDIUM)
	=>	
	(printout t "Input cost as an integer:" crlf)
	(bind ?cost (read))
	(while (not (and (numberp ?cost) (> ?cost 0))) do 
		(printout t "Input for cost should be a positive integer" crlf)
		(bind ?cost (read))
	)
	
	(assert (cost ?cost))
)

; Input balance
(defrule balance_input
	(necessity_category MEDIUM)
	=>
	(printout t "Input balance as an integer:" crlf)
	(bind ?balance (read))
	(while (not (and (numberp ?balance) (> ?balance 0))) do 
		(printout t "Input for balance should be a positive integer" crlf)
		(bind ?balance (read))
	)
	
	(assert (balance ?balance))
)

; Input days until payday
(defrule days_until_payday_input
	(cost_balance_category MEDIUM)
	=>
	(printout t "Input days until next payday as an integer:" crlf)
	(bind ?days_until_payday (read))
	(while (not (numberp ?days_until_payday)) do 
		(printout t "Input for days should be an integer" crlf)
		(bind ?days_until_payday (read))
	)
	(assert (days_until_payday ?days_until_payday))
)

; Calculate actual_necessity
(defrule actual_necessity_calc_alts
	(necessity ?necessity)
	(alternatives TRUE)
	=>
	(assert (actual_necessity (/ ?necessity 2)))
)
(defrule actual_necessity_calc_no_alts
	(necessity ?necessity)
	(alternatives FALSE)
	=>
	(assert (actual_necessity ?necessity))
)

; Calculate necessity category
(defrule necessity_category_high
	(actual_necessity ?actual_necessity)
	(test (>= ?actual_necessity 8))
	=>
	(assert (necessity_category HIGH))
)
(defrule necessity_category_medium
	(actual_necessity ?actual_necessity)
	(test (and (>= ?actual_necessity 4) (< ?actual_necessity 8)))
	=>
	(assert (necessity_category MEDIUM))
)
(defrule necessity_category_low
	(actual_necessity ?actual_necessity)
	(test (< ?actual_necessity 4))
	=>
	(assert (necessity_category LOW))
)

; Calculate cost_balance_percentage
(defrule cost_balance_percentage_calc
	(cost ?cost)
	(balance ?balance)
	=>
	(assert (cost_balance_percentage (/ ?cost ?balance)))
)

; Calculate cost_balance_category
(defrule low_cost_balance_percentage
	(cost_balance_percentage ?cost_balance_percentage)
	(test (< ?cost_balance_percentage 0.2))
	=>
	(assert (cost_balance_category LOW))
)
(defrule medium_cost_balance_percentage
	(cost_balance_percentage ?cost_balance_percentage)
	(test (and (>= ?cost_balance_percentage 0.2) (<= ?cost_balance_percentage 0.7)))
	=>
	(assert (cost_balance_category MEDIUM))
)
(defrule high_cost_balance_percentage
	(cost_balance_percentage ?cost_balance_percentage)
	(test (> ?cost_balance_percentage 0.7))
	=>
	(assert (cost_balance_category HIGH))
)

; Affordable
(defrule affordable_due_to_low_cost_balance_percentage
	(cost_balance_category LOW)
	=>
	(assert (can_afford TRUE))
)
(defrule affordable_due_to_soon_payday
	(cost_balance_category MEDIUM)
	(days_until_payday ?days_until_payday)
	(test (<= ?days_until_payday 7))
	=>
	(assert (can_afford TRUE))
)

; Non-affordable
(defrule non_affordable_due_to_high_cost_balance_percentage
	(cost_balance_category HIGH)
	=>
	(assert (can_afford FALSE))
)
(defrule non_affordable_due_to_late_payday
	(or (cost_balance_category MEDIUM))
	(days_until_payday ?days_until_payday)
	(test (> ?days_until_payday 7))
	=>
	(assert (can_afford FALSE))
)

; Positive result
(defrule positive_result1
	(necessity_category HIGH)
	=>
	(assert (result TRUE))
)
(defrule positive_result2
	(can_afford TRUE)
	=>
	(assert (result TRUE))
)

; Negative result
(defrule negative_result1
	(can_afford FALSE)
	=>
	(assert (result FALSE))
)
(defrule negative_result2
	(necessity_category LOW)
	=>
	(assert (result FALSE))
)

; RESULTS
(defrule inform_user_about_positive_result
	(result TRUE)
	=>
	(printout t "Yeap, you should definitely buy the product :)" crlf)
)
(defrule inform_user_about_negative_result
	(result FALSE)
	=>
	(printout t "Nope, you shouldn't buy the product :(" crlf)
)