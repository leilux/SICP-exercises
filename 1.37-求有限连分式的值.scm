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
; 1.37
; = 1.6180339887498947
; 递归
(define (cont-frac-r n d k)
  (if (= k 1)
	(/ n (+ d (/ n d)))
	(/ n
	   (+ d 
		  (cont-frac-r n d (- k 1))))))
; 迭代
(define (cont-frac-i n d k)
  (define (iter n d k a)
	(if (= k 1)
	  (/ n (+ d a))
	  (iter n 
			d 
			(- k 1)
			(/ n (+ d a)))))
  (iter n d k 1))
; 取得达到精确度需要的次数 k
(define (get-k n d k)
  (if (< (abs (- (cont-frac-i n d k) 0.618039)) 0.00001)
	(begin
	  (display (cont-frac-i n d k))
	  (newline)
	  (display k))
	(get-k n d (+ k 1))))

(get-k 1.0 1.0 2)
;; 12 times
