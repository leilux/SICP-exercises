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
; 1.39 

(define (tan-cf x k)
  (define (fenmu x n k)
	(let ((d (- (* 2 n) 1)))
	  (if (= n k)
		(- d (/ (* x x) (+ d 2)))
		(- d
		   (/ (* x x)
			  (fenmu x (+ n 1) k))))))
  (/ x 
	 (fenmu x 1 k)))

(tan-cf 0.785 5)
