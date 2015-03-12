; 3.38
peter : (set! balance (+ balance 10))
paul  : (set! balance (- balance 20))
mary  : (set! balance (- balance (/ balance 2)))
a)
1 peter -> paul -> mary  = 45
2 peter -> mary -> paul  = 32
3 paul  -> mary -> peter = 50
4 mary  -> paul -> peter = 30

b)    
            bank=100
|    peter      paul      mary
|      |          |        |
|      +-         +-       +- 
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      |          |        |  
|      110        80       50        
|                             
|
V
time
