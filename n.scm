; 3.50
;define (delay-me exps) (lambda () exps))
; delay
(define (memo-proc proc)
  (let ((already-run? #f) (result #f))
	(lambda ()
	  (if (not already-run?)
		(begin (display "first run\n")
			   (set! result (proc))
			   (set! already-run? #t)
			   result)
		result))))
(define (delay-me exps) (memo-proc (lambda () exps)))
; force
(define (force delay-me-obj) (delay-me-obj))
; cons
(define (cons-stream a b) (cons a (delay-me b)))
; car cdr
(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))
;; map
(define (stream-map-me proc stream)
  (if (null? stream)
	'()
	(cons-stream
	  (proc (stream-car stream))
	  (stream-map-me proc (stream-cdr stream)))))
;(define (stream-map-me proc . argstrams)
;  (if (null? (car argstrams))
;	'()
;	(cons-stream
;	  (apply proc (map (lambda (s) (stream-car s)) argstrams))
;	  (apply stream-map-me
;			 (cons proc (map (lambda (s) (stream-cdr s)) argstrams))))))
;; test
(define scons cons-stream)
(define smap stream-map-me)
(define a (scons 1 (scons 2 (scons 3 '()))))
(define b (scons 1 (scons 2 (scons 3 '()))))
(define r (smap + a))

; 3.51
; insterval
(define (stream-enumerate-insterval low high)
  (if (> low high)
	'()
	(cons-stream
	  low
	  (stream-enumerate-insterval (+ low 1) high))))

(define sei stream-enumerate-insterval)
; filter
(define (stream-filter pred stream)
  (cond ((null? stream) '())
		((pred (stream-car stream))
		 (cons-stream (stream-car stream)
					  (stream-filter pred
									 (stream-cdr stream))))
		(else (stream-filter pred (stream-cdr stream)))))
; ref
(define (stream-ref s n)
  (if (= n 0)
	(stream-car s)
	(stream-ref (stream-cdr s) (- n 1))))


(define (show x) (display x)(display "\n.") x)
(display "\n----\n")
(define x (stream-map-me show (stream-enumerate-insterval 0 10)))
(display "\n----\n")
(display (stream-ref x 5))
(display (stream-ref x 7))
 ; 3.52
(define sum 0)
(define (accum x) 
  (set! sum (+ x sum))
  sum)
;(define seq (stream-map-me accum (sei 1 20)))
(define (l) (load "n.scm"))
