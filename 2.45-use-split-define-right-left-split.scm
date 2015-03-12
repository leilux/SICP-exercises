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
;
(define (square-of-four tl tr bl br)
  (lambda (painter)
	(let ((top (beside (tl painter) (tr painter)))
		  (bottom (beside (bl painter) (br painter))))
	  (below bottom top))))
(define (filpped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
								  identity flip-vert)))
	(combine4 painter)))
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
								  rotate180 flip-vert)))
	(combine4 (corner-split painter n))))
; 2.45
(define (sqlit p1 p2)
  (lambda (painter n)
	(if (= n 0)
	  painter
	  (let ((smaller ((split p1 p2) painter (- n 1))))
		(p1 painter (p2 (smaller smaller)))))))
(define right-split (split beside below))
(define up-split	(split below  beside))

