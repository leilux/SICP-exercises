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
; 2.40
(define (enumerate-interval low high)
  (if (> low high) ()
	(cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (fold-right append () (map proc seq)))

(define (unique-pairs n)
  (flatmap
	(lambda (i)
	  (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
	(enumerate-interval 1 n)))
;; test
(newline) (display (unique-pairs 3))
