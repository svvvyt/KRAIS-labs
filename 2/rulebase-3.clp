; Input student pattern 
(deftemplate student
   (slot name)       ; student name (symbol)
   (slot age)        ; age (integer, 17-22)
   (slot year)       ; year of study (integer, 2-5)
   (slot spec)       ; speciality (string: "hard", "soft", "ai")
   (slot aver_mark)  ; average mark (float, [3-5])
)

(deffacts students
   (student (name John) (age 20) (year 3) (spec "hard") (aver_mark 4.5))
   (student (name Alice) (age 18) (year 2) (spec "ai") (aver_mark 4.8))
   (student (name Bob) (age 19) (year 4) (spec "soft") (aver_mark 4.2))
   (student (name Jack) (age 22) (year 5) (spec "hard") (aver_mark 3.9))
   (student (name Diana) (age 21) (year 4) (spec "ai") (aver_mark 4.0))
   (student (name Peter) (age 17) (year 2) (spec "soft") (aver_mark 3.7))
   (student (name Fiona) (age 20) (year 3) (spec "hard") (aver_mark 4.1))
   (student (name George) (age 22) (year 5) (spec "soft") (aver_mark 4.6))
   (student (name Helen) (age 19) (year 2) (spec "ai") (aver_mark 4.9))
   (student (name Lola) (age 18) (year 3) (spec "soft") (aver_mark 3.8))
)

; Rule for task 3 (table 3)
(defrule student-2nd-year-high-mark-typed
   (student (name ?name) (year ?year) (spec ?spec) (aver_mark ?mark))
   (test (and (integerp ?year) (floatp ?mark) (>= ?mark 4.5)))
   =>
   (printout t "2nd year student" ?name " studies by specialization " ?spec " with an average mark " ?mark crlf)
)