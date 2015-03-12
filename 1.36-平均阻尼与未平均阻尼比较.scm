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
; 1.36
; fixed-point
(define tolerance 0.001)
(define (fixed-point f first-guess)
  (define (closs-enough? v1 v2)
	(< (abs (- v1 v2)) tolerance))
  (define (try guess count)
	(let ((next (f guess)))
	  (if (closs-enough? guess next)
		next
		(begin 
		  (display "\nguess ")(display count)(display " : ")
		  (display guess)
		  (try next (+ 1 count))))))
  (try first-guess 0))
; 未平均阻尼
(define log-n-r
  (begin
	(display "\n log-n-r")
	(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)))
; 平均阻尼
(define log-r
  (begin
	(display "\n log-r")
	(fixed-point (lambda (x) (/ (+ (/ (log 1000) (log x)) x) 2)) 2.0)))

;; 结论
;; log-n-r 21 step
;; log-r   5  step
