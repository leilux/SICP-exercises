;;-------------------------------- T E S T ---------------------;+
(define (title n)												;|
  (begin                                                        ;|
	(display "\n - - - - ")	(display n) (display " - - - -\n")));|
(define (test f a b)                                            ;|
  (newline)                                                     ;|
  (if (> a b)                                                   ;|
	(display "test over !\n")                                   ;|
	(begin                                                      ;|
	  (display a) (display " : ") (display (f a))               ;|
	  (test f (+ a 1) b))))                                     ;|
; --------------------------------------------------------------;+
; 2.1
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (no-more? x) (null? x))
(define (except-first-denomination x) (cdr x))
(define (first-denomination x) (car x))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
		((or (< amount 0) (no-more? coin-values)) 0)
		(else
		  (+ (cc amount
				 (except-first-denomination coin-values))
			 (cc (- amount
					(first-denomination coin-values))
				 coin-values)))))

;; test
(newline) (display (cc 100 us-coins))
(newline) (display (cc 10 uk-coins))

;; 排列顺序无影响
