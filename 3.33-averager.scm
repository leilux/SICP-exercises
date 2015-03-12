(load "book/p216-constraint-propagate.scm")
; 3.33

(define (averager a b avg)
  (let ((sum (make-connector))
		(c   (make-connector)))
	(adder a b sum)
	(multiplier avg c sum)
	(constant 2 c)
	'ok))
;; test
(define a (make-connector))
(define b (make-connector))
(define avg (make-connector))
(averager a b avg)
(probe "a temp\t" a)
(probe "b temp\t" b)
(probe "avg temp\t" avg)

(set-value! a 2 'u)
(set-value! b 2 'u)
