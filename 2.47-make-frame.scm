; 2.47
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame frame) (list-ref frame 1))
(define (edg1-frame frame) (list-ref frame  2))
(define (edg2-frame frame) (list-ref frame  3))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame frame) (car frame))
(define (edg1-frame frame) (cadr frame))
(define (edg2-frame frmae) (cddr frame))
