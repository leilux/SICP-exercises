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
; 1.40
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
;; 求导
(define dx 0.00001)
(define (deriv g)
  (lambda (x)
	(/ (- (g (+ x dx)) (g x))
	   dx)))
;; 牛顿变换
(define (newton-transform g)
  (lambda (x)
	(- x (/ (g x) ((deriv g) x)))))
;; 牛顿逼近
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

;; x^3 + ax^2 + bx + c
(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))
;; test
(newtons-method (cubic 0 0 0) 2.0)
