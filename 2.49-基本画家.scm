; 2.49
(define (segments->painter segment-list)
  (lambda (frame)
	(for-each
	  (lambda (segment)
		(draw-line
		  ((frame-coord-map frame) (start-segment segment))
		  ((frame-coord-map frame) (end-segment segment))))
	  segment-list)))

;     p1 +-----+ p3
;        |     |
;     p0 +-----+ p2
(define (get-frame-vertexs frame)
  (lambda (op)
	(let ((origin (origin-frame frame))
		  (edge1 (edge1-frame frame))
		  (edge2 (edge2-frame frame)))
	  (op origin
		  (add-vect origin edge1)
		  (add-vect origin edge2)
		  (add-vect origin (add-vect edge1 edge2))))))
(define (draw frame op)
  ((segments->painter ((get-frame-vertexs frame) op)) frame))
; a)
(define (a-pointer frame)
  (define (op p0 p1 p2 p3)
	(list (make-segment p0 p1)
		  (make-segment p1 p2)
		  (make-segment p2 p3)
		  (make-segment p3 p0)))
  (draw frame op))
; b)
(define (b-pointer frame)
  (define (op p0 p1 p2 p3)
	(list (make-segment p0 p3)
		  (make-segment p1 p2)))
  (draw frame op))
; c)
(define (c-pointer frame)
  (define (avg x y) (/ (+ x y) 2))
  (define (middle-pointer p1 p2)
	(make-vect (avg (xcor-vect p1)
					(xcor-vect p2))
			   (avg (ycor-vect p1)
					(ycor-vect p2))))
  (define (op p0 p1 p2 p3)
	(let ((mp0 (middle-pointer p0 p1))
		  (mp1 (middle-pointer p1 p2))
		  (mp2 (middle-pointer p2 p3))
		  (mp3 (middle-pointer p3 p0)))
	  (list (make-segment mp0 mp1)
			(make-segment mp1 mp2)
			(make-segment mp2 mp3)
			(make-segment mp3 mp0))))
  (draw frame op))
