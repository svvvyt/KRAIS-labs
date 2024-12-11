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

; Rule for task 4 (table 4)
(defrule student-finishing-before-24
   (student (name ?name) (age ?age) (year ?year))
   (test (<= (+ ?age (- 5 ?year)) 24))
   =>
   (printout t "Student " ?name " graduates from the university at the age of 24 or under" crlf)
)