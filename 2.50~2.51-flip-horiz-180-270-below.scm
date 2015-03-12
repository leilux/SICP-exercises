; 2.50
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
	(let ((m (frame-coord-map frame)))
	  (let ((new-origin (m origin)))
		(painter
		  (make-frame new-origin
					  (sub-vect (m corner1) new-origin)
					  (sub-vect (m corner2) new-origin)))))))
(define (flip-vert painter)
  (transform-painter painter	
					 (make-vect 0.0 1.0)	; new origin
					 (make-vect 1.0 1.0)	; new end of edge1
					 (make-vect 0.0 0.0)))	; new end of edge2
(define (shrink-to-upper-right painter)
  (transform-painter painter 
					 (make-vect 0.5 0.5)
					 (make-vect 1.0 0.5)
					 (make-vect 0.5 1.0)))
(define (rotate90 painter)
  (transform-painter painter
					 (make-vect 1.0 0.0)
					 (make-vect 1.0 1.0)
					 (make-vect 0.0 0.0)))
(define (squash-inwards painter)
  (transform-painter painter
					 (make-vect 0.0 0.0)
					 (make-vect 0.65 0.35)
					 (make-vect 0.35 0.65)))
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
	(let ((paint-left
			(transform-painter painter1
							   (make-vect 0.0 0.0)
							   split-point
							   (make-vect 0.0 1.00)))
		  (paint-right
			(transform-painter painter2
							   split-point
							   (make-vect 1.0 0.0)
							   (make-vect 0.5 1.0))))
	  (lambda (frame)
		(paint-left frame)
		(paint-right frame)))))
; flip horiz
(define (flip-horiz painter)
  (transform-painter painter	
					 (make-vect 1.0 0.0)	; new origin
					 (make-vect 0.0 0.0)	; new end of edge1
					 (make-vect 1.0 1.0)))	; new end of edge2
; 180
(define (rotate180 painter)
  (transform-painter painter
					 (make-vect 1.0 1.0)
					 (make-vect 0.0 1.0)
					 (make-vect 1.0 0.0)))
(define (rotate270 painter)
  (transform-painter painter
					 (make-vect 0.0 1.0)
					 (make-vect 0.0 0.0)
					 (make-vect 1.0 1.0)))
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
	(let ((paint-up
			(transform-painter painter1
							   split-point
							   (make-vect 1.0 0.5)
							   (make-vect 0.0 1.0)))
		  (paint-down
			(transform-painter painter2
							   (make-vect 0.0 0.0)
							   (make-vect 1.0 0.0)
							   split-point))))
	(lambda (frame)
	  (paint-up frame)
	  (paint-down frame))))
; (270 (beside (90 p1) (90 p2)))


