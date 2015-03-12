; 3.44
; 转移只依赖于balance的当前值，只要保证对当前账户balance的访问串行化就可以
; 交换依赖于两个balance的差值，需要保证对两个账户balance访问的串行化
