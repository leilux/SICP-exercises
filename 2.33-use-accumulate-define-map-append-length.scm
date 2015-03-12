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
; 2.33
(define (accumulate op init sequence)
  (if (null? sequence) 
	init
	(op (car sequence)
		(accumulate op init (cdr sequence)))))
; map
(define (map-m p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) () sequence))
; test-map
(define (square x) (* x x))
(newline) (display (map-m square (list 1 2 3 4)))

; append 
(define (append-m seq1 seq2)
  (accumulate cons seq2 seq1))
; test-append
(newline) (display (append-m (list 1 2 3) (list 4 5 6)))

; length
(define (length-m sequence)
  (accumulate (lambda (x y) (+ (if (null? x) 0 1) y)) 0 sequence))
; test-length
(newline) (display (length-m (list 1 2 3)))
