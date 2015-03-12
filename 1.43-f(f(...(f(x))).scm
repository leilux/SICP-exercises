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
; 1.43
; f(f(...(f(x)))) 等于复合了n次。
(define (compose f g)
  (lambda (x) (f (g x))))
(define (repeated f n)
	(if (= n 1)
	  (lambda (x) (f x))
	  (compose f (repeated f (- n 1)))))
;; test 
(define (inc x) (+ x 1))
(define (square x) (* x x))
((repeated inc 4) 5)
((repeated square 2) 5)
