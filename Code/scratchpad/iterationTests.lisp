(in-package :gdl-user)

(define-object iterationTests ()

:input-slots
()

:computed-slots
(
(x1 (list 1 2 3 4 5))
(count (list 5 5))
(x2 (iterate:iter (iterate:for x in (the x1))
		  (iterate:collect (* x 2))))
(x3 (iterate:iter (iterate:for x in (the x1))
		  (iterate:collect (iterate:iter (iterate:for y in (the count))
						 (iterate:sum (+ x y))))))
(x4 (! 5 ))
(x5 (iterate:iter (iterate:for x in (the x1))
		  (iterate:collect (iterate:iter (iterate:for y in (the count))
						 (iterate:for z next (* 2 y))
						 (iterate:sum (+ x y z))))))
(x6 (length (the x1)))
(x7 (nth 4 (the x1)))
)

:functions
((! (n)
    (labels
        ((fact1 (n m)
             (if (zerop n)
                 m
                 (fact1 (1- n) (* m n)))))
    (fact1 n 1)))
)

)

