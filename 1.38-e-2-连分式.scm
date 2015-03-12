;;-------------------------------- T E S T ---------------------;+
(define (title n)												;|
  (begin                                                        ;|
	(display "\n - - - - ")	(display n) (display " - - - -\n")));|
(define (test f a b)                                            ;|
  (newline)                                                     ;|
  (if (> a b)                                                   ;|
	(display "test over !\n")                                   ;|
	  (test f (+ a 1) b)))                                      ;|
; --------------------------------------------------------------;+
; 1.38
; e - 2 = 0.718281828
(define (c-d k) 
  (if (= (remainder k 3) 2)
	(* 2 (+ (floor (/ k 3)) 1))
	1))

(define (cont-frac-r n d k total)
  (if (= k total) 
	(/ n (+ d (/ n d)))
	(let ((d (c-d k)))
	  (display "\n")(display d)(display "\n")
	  (/ n
		 (+ d
			(cont-frac-r n 
						 d
						 (+ k 1)
						 total))))))

(cont-frac-r 1.0 1.0 1 10)
