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
; 2.43
(define (flatmap proc seq)
  (fold-right append () (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
	()
	(cons low (enumerate-interval (+ low 1) high))))
; filter
(define (safe? k positions)
  (let ((end-pos (- k 1))
		(end (list-ref positions (- k 1))))
	(define (iter pos positions)
	  (define now (list-ref positions pos))
	  (if (= pos end-pos) #t
		(if (or (= now end)
				(= (abs (- end now)) (- end-pos pos)))
		  #f
		  (iter (+ pos 1) positions))))
	(iter 0 positions)))

(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list new-row)))

(define empty-board ())
(define (queens board-size)
  (define (queen-cols k)
	(if (= k 0)
	  (list empty-board)
	  (filter 
		(lambda (position) (safe? k position)) ; pre
;		(flatmap								; seq
;		  (lambda (rest-of-queens) ; proc
;			(map (lambda (new-row) (adjoin-position new-row k rest-of-queens)) 
;				 (enumerate-interval 1 board-size)))
;		  (queen-cols (- k 1)))))) ; seq									
		(flatmap 
		  (lambda (new-row)
			(map (lambda (rest-of-queens)
				   (adjoin-position new-row k rest-of-queens))
				 (queen-cols (- k 1))))
		  (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

; display the answer
(define (display-board board)
  (define (display-*-* n) (if (> n 0) (begin (display " - ") (display-*-* (- n 1))) ))
  (display board)(newline)
  (let ((board-size (length board)))
	(map (lambda (n) 
		   (begin (display-*-* (- n 1))
				  (display " O ")
				  (display-*-* (- board-size n))
				  (newline)))
		 board)))

;; test 
(define c (queens 8))
;(newline) (display c)
;(newline) (display (length c))
(map display-board c)
;(newline) (display-board (car c))
