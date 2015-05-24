(in-package :gdl-user)

(define-object CSTconverter ()

:input-slots
((Au '(0.2337  
       0.0800
       0.2674
       0.0899
       0.2779
       0.3816))

 (Al '(-0.2253
       -0.1637
       -0.0464
       -0.4778
       0.0741
       0.3252))

 (nPoints 100)
 (N1 0.5)
 (N2 1.0)
 )
 
:computed-slots
((nU (- (length (the Au)) 1))
 (nL (- (length (the Al)) 1))
 (xCoordinates (iterate:iter (iterate:for i from 0 to (the nPoints))
			     (iterate:collect (* i (/ 1 (the nPoints))))))
 (cFunction (iterate:iter (iterate:for i in (the xCoordinates))
			  (iterate:collect (* (expt i (the N1)) (expt (- 1 i) (the N2)) ))))
 (shapeUpper (iterate:iter (iterate:for x in (the xCoordinates))
			   (iterate:collect (iterate:iter (iterate:for j from 0 to (the nU))
							  (iterate:for krnU next (/ (!(the nU)) (* (! j) (! (- (the nU) j)) ) ))
							  (iterate:for A next (nth j (the Au)))
							  (iterate:sum (* A krnU (expt (- 1 x) (- (the nU) j)) (expt x j)))))))
 
 (shapeLower (iterate:iter (iterate:for x in (the xCoordinates))
			   (iterate:collect (iterate:iter (iterate:for j from 0 to (the nL))
							  (iterate:for krnL next (/ (!(the nL)) (* (! j) (! (- (the nL) j)) ) ))
							  (iterate:for A next (nth j (the AL)))
							  (iterate:sum (* A krnL (expt (- 1 x) (- (the nL) j)) (expt x j)))))))
 (yUpper (iterate:iter (iterate:for c in (the cFunction))
		       (iterate:for s in (the shapeUpper))
		       (iterate:collect (* c s ))))

 (ylower (iterate:iter (iterate:for c in (the cFunction))
		       (iterate:for s in (the shapeLower))
		       (iterate:collect (* c s))))

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

