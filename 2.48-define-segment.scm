; 2.48
; make
(define (make-vect x y) (cons x y))
(define (make-segemnt v1 v2) (cons v1 v2))
(define (start-segment L) (car L))
(define (end-segment L) (cdr L))

(define (segments->painter segment-list)
  (lambda (frame)
	(for-each
	  (lambda (segment)
		(draw-line
		  ((frame-coord-map frame) (start-segment segment))
		  ((frame-coord-map frame) (end-segment segment))))
	  segment-list)))

