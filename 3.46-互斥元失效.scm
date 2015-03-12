; 3.46
(load "book\p235-make-mutex.scm")

假设当前cell为#f，p1为获得acquire执行test-and-set!，得到cell为#f
同时p2为获得acquire也执行test-and-set!，得到cell为#f，互斥元失效
此时两个同时进入了串行组运行，串行组失效
