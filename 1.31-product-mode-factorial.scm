;;-------------------------------- T E S T ---------------------------------;+
(define (title n)                                                           ;|
  (begin                                                                    ;|
	(display "\n - - - - ")	(display n) (display " - - - -\n")))            ;|
(define (test f a b)                                                        ;|
  (newline)                                                                 ;|
  (if (> a b)                                                               ;|
	(display "test over !\n")                                               ;|
	(begin                                                                  ;|
	  (display a) (display " : ") (display (f a))                           ;|
	  (test f (+ a 1) b))))                                                 ;|
; --------------------------------------------------------------------------;+
                                                                             
;; 1.31
;; a) 递归
; ==================== M O D E ================
(define (product-r term a next b)
  (if (> a b)
	1
	(* (term a )
	   (product-r term (next a) next b))))
; b) 迭代
; ==================== M O D E ================
(define (product-i term a next b)
  (define (iter a result)
	(if (> a b)
	  result
	  (iter (next a) (* result 
						(term a)))))
  (iter a 1))

; =============================================
;; factorial 
(define (factorial b)
  (define (identity x) x)
  (define (next x) (+ x 1))
  (product-i identity 1 next b)) ; here to change MODE!
;; test
(title "factorial(n)")
(test factorial 1 4)
; --------------------------------------------
;; pi
(define (pi n)
  (define (inc a) (+ a 1))
  (define (nume-o-deno i j n)
	(define (add-1-or-2 x) 
	  (if (even? x)	(+ x i) (+ x j)))
	(product-r add-1-or-2 1 inc n))
  (* 4 (/ (nume-o-deno 2.0 1.0 n)
		  (nume-o-deno 1.0 2.0 n))))
;; test
(title "pi-r")
(test pi 100 104)
