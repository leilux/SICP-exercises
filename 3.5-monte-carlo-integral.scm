; (x1,y1)=(2,4)  
; (x2,y2)=(8,10)
(define (estimate-integral P x1 x2 y1 y2 trials)
  (* (abs (* (- x1 x2) (- y1 y2)))
	 (monte-carlo trials P)))
(define (random-in-range low high)
  (let ((range (- high low)))
	(+ low (random range))))
; (x,y)=(5,7) r=3
(define (in-circle?)
  (<= (+ (expt (- 5 (random-in-range 2.0  8.0)) 2)
		 (expt (- 7 (random-in-range 4.0 10.0)) 2))
	  (expt 3 2)))
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
	(cond ((= trials-remaining 0)
		   (/ trials-passed trials))
		  ((experiment)
		   (iter (- trials-remaining 1) (+ trials-passed 1)))
		  (else
			(iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (pi trials) (/ (estimate-integral in-circle? 2 8 4 10 trials)
					   9.0))
;; test
(newline) (display (pi 10))
(newline) (display (pi 100))
(newline) (display (pi 1000))
(newline) (display (pi 10000))
