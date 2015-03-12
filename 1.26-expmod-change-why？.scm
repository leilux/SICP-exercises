(define (expmod base exps m)
  (cond ((= exps 0) 1)
		((even? exps)
		 (remainder (* (expmod base (/ exps 2) m) ;; use * instead square
					   (expmod base (/ exps 2) m)
					m))
		(else 
		  (remainder (* base (expmod base (- exps 1) m))
					 m)))))
;; 如 expmod( 2 8 3) 展开为
;;  expmod(2 4 3) * expmod(2 4 3)
;;  expmod(2 2 3) * expmod(2 2 3) * expmod(2 2 3) * expmod(2 2 3)
;;  expmod(2 1 3) * expmod(2 1 3) * expmod(2 1 3) * expmod(2 1 3) * expmod(2 1 3) * expmod(2 1 3) * expmod(2 1 3) * expmod(2 1 3)
;;  变成了线性的 为 O(n)
