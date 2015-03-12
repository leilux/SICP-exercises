; 3.40
(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
				  (lambda () (set! x (* x x x))))
;; p1-1 p1-2 p1-3 p2-1 p2-2 p2-3 p2-4 1,000,000
;;
(define x 10)
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x))))
				  (s (lambda () (set! x (* x x x)))))
;; p1 p2 1,000,000
;; p2 p1 1,000,000
