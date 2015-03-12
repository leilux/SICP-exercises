; 3.39
(define x 10)
(define s (make-serializer))
(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
				  (s (lambda () (set! x (+ x 1)))))
;; 
;; p1-1 p1-2 p2 11 
;; p1-1 p2 p1-2 101
;; p2 p1-1 p1-2 121

