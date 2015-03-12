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
; 2.3
; point
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))
; segment
(define (make-segment p1 p2) (cons p1 p2))
(define (str-segemnt L) (car L))
(define (end-segemnt L) (cdr L))
(define (midpoint-segment L)
  (make-point (/ (+ (x-point (str-segemnt L)) 
					(x-point (end-segemnt L)))
				 2)
			  (/ (+ (y-point (str-segemnt L))
					(y-point (end-segemnt L)))
				 2)))
;         Rectangle
; ====================== ;
;	   p4 +------+ p1
;		  |     /|
;		  |    / |
;		  |  b/  | L1
;		  |  /   |a
;		  | /    |
;		  |/ L2  |
;	   p3 +------+ p2
;	         c
; ====================== ;	         
;; point mode
(define (make-rect-p p1 p2 p3)
  (cons (cons p1 p2) (cons p2 p3)))
;; Line mode
(define (make-rect-L L1 L2)
  (cons L1 L2))

(define (square x) (* x x))
(define (p2p-distance p1 p2)
  (let ((x1 (car p1))
		(y1 (cdr p1))
		(x2 (car p2))
		(y2 (cdr p2)))
	(sqrt (+ (square (- x1 x2)) (square (- y1 y2))))))
;; perimeter
(define (rect-perimeter r)
  (let ((p1 (car (car r)))
		(p2 (cdr (car r)))
		(p3 (cdr (cdr r))))
	(* 2
	   (+ (p2p-distance p1 p2)
		  (p2p-distance p2 p3)))))
;; test perimeter
(display "\n r-p :")
(define r-p (make-rect-p (make-point 1 1)
						 (make-point 1 0)
						 (make-point 0 0)))
(display (rect-perimeter r-p))
(display "\n r-L :")
(define r-L (make-rect-L (make-segment (make-point 1 1)
									   (make-point 1 0))
						 (make-segment (make-point 1 0)
									   (make-point 0 0))))
(display (rect-perimeter r-L))

;; area 
;; (define p (/ (+ a b c) 2))
;; (define area (* (- p a) (- p b) (- p c)))
 

