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
; 2.44
(define (right-split painter n)
  (if (= n 0)
	painter
	(let ((smaller (right-split painter (- n 1))))
	  (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
	painter
	(let ((smaller (up-split (- n 1))))
	  (below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
	painter
	(let ((up (up-split painter (- n 1)))
		 (right (right-split painter (- n 1))))
	(let ((top-left (beside up up))
		  (bottom-right (below right right))
		  (corner (corner-split painter (- n 1))))
	  (beside (below painter top-left)
			  (below bottom-right corner))))))

(define (square-limt painter n)
  (let ((quarter (corner-split painter n)))
	(let ((half (beside (fliped-horiz quarter) quarter)))
	  (below (flip-vert half) half))))

