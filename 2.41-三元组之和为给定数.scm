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
; 2.41
; 信号 -> 过滤 -> 累加
(define (enumurate-interval low high)
  (if (> low high) ()
	(cons low (enumurate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (fold-right append () (map proc seq)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item))) sequence))

(define (make-3-p n)
  (flatmap (lambda (i)
			 (flatmap (lambda (j)
						(map (lambda (k) 
							   (list i j k))
							 (remove i (remove j (enumurate-interval 1 n)))))
					  (remove i (enumurate-interval 1 n))))
		   (enumurate-interval 1 n)))

(define (sum-3-p p3)
  (+ (car p3) (cadr p3) (caddr p3)))

(define (pair-3-sum-s n s)
  (filter (lambda (p) (if (= (sum-3-p p) s) #t #f)) (make-3-p n)))
;; test

(newline) (display (pair-3-sum-s 4 6))
(newline) (display (pair-3-sum-s 4 7))
(newline) (display (pair-3-sum-s 8 8))
