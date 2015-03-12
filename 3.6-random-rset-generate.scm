; 3.6
(define (rand)
  (begin
	(define value 2)
	(lambda (op)
	  (cond ((eq? op 'g)
			 (random value))
			((eq? op 'r)
			 (lambda (new-value)
			   (set! value new-value)))
			(else "have't such option")))))

;; test
(define r (rand))
(newline) (display (r 'g))
(newline) (display (r 'g))
(newline) (display (r 'g))
(newline) (display "reset value")
(newline) (display ((r 'r) 19))
(newline) (display (r 'g))
(newline) (display (r 'g))
(newline) (display (r 'g))
(newline) (display (r 'g))
(newline) (display (r 'g))
