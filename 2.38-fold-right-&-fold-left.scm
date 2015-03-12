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
; 2.38
; fold-left-m
(define (fold-left-m op init sequence)
  (define (iter result rest)
	(if (null? rest)
	  result
	  (iter (op result (car rest))
			(cdr rest))))
  (iter init sequence))
; fold-right
; it's like p78-accumulate.scm
(define (fold-right-m op init sequence)
  (if (null? sequence)
	init
	(op (car sequence)
		(fold-right-m op init (cdr sequence)))))

(newline) (display (fold-right / 1 (list 1 2 3)))
(newline) (display (fold-left-m / 1 (list 1 2 3)))
(newline) (display (fold-right list () (list 1 2 3)))
(newline) (display (fold-left-m list () (list 1 2 3)))
(newline) (display (fold-right + 0 (list 1 2 3)))
(newline) (display (fold-left-m + 0 (list 1 2 3)))
(newline) (display (fold-right * 1 (list 1 2 3)))
(newline) (display (fold-left-m * 1 (list 1 2 3)))
(newline) (display (fold-right cons () (list 1 2 3)))
(newline) (display (fold-left-m cons () (list 1 2 3)))

;; op 需要是順序無關的運算
