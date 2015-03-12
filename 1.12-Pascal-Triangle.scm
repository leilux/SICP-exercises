;; 1.12
(define (p-triangle row col)
  (if (or (= col 1) (= col row))
	1
	(+ (p-triangle (- row 1) (- col 1))
	   (p-triangle (- row 1) col))))
