;; 1.19
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
		((even? count)
		 (fib-iter a
				   b
				   (+ (* p p) (* q q))			; compute p'
				   (+ (* q q) (* 2 p q ))		; compute q'
				   (/ count 2)))
		(else (fib-iter (+ (* b q) (* a q) (* a p))
						(+ (* b p) (* a q))
						p
						q
						(- count 1)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;|
;	;1                                                                             ;|
;	a = by + ay + ax                                                               ;|
;	b = bx + ay                                                                    ;|
;	;2                                                                             ;|
;	a' = (bx + ay)y + (by + ay + ax)y + (by + ay + ax)x                            ;|
;	b' = (bx + ay)x + (by + ay + ax)y                                              ;|
;	;3                                                                             ;|
;	b' = b(x^2 + y^2) + a(xy + y^2 + xy)                                           ;|
;	a' = b(xy + y^2 + xy) + a(xy + y^2 + xy) + a(x^2 + y^2)                        ;|
;	;4                                                                             ;|
;	x' = (x^2 + y^2)                                                               ;|
;	y' = (xy + xy + y^2)                                                           ;|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;|
