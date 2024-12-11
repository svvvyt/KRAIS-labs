 (deffacts initial-facts
  (a)
  (b)
  (c)
  (d)
  (e))

(defrule rule-1
  (declare (salience 5000))
  (a)
  (b)
  =>
  (assert (m)))

(defrule rule-2
  (declare (salience 6000))
  (a)
  (c)
  =>
  (assert (n)))

(defrule rule-3
  (declare (salience 5000))
  (b)
  (c)
  (d)
  =>
  (assert (p)))

(defrule rule-4
  (declare (salience 6000))
  (a)
  (d)
  (c)
  =>
  (assert (r)))

(defrule rule-5
  (declare (salience 6000))
  (m)
  (n)
  =>
  (assert (s)))

(defrule rule-6
  (declare (salience 5000))
  (n)
  (p)
  (r)
  =>
  (assert (t)))
  