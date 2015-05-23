(define-object cst-curve (fitted-curve)
  :input-slots
  (
  (cst '(0.2337  
		 0.0800
	     0.2674
		 0.0899
		 0.2779
		 0.3816
		-0.2253
		-0.1637
		-0.0464
		-0.4778
		 0.0741
		 0.3252))
   (npoints 50) 
   (N1 0.5)
   (N2 1.0)
 )
  
  :computed-slots 
  (
  (center (make-point 0 0 0))
  (orientation nil)
  
  (Au (subseq (the cst) 0 (half (length (the cst)))))
  (Al (subseq (the cst) (half (length (the cst))) (length (the cst))))
  
  (nU (- (length (the Au)) 1))
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
  
  (x-coords (append (the xCoordinates) (rest (reverse (the xCoordinates)))))
  (y-coords (append (the yUpper) (rest (reverse (the ylower)))))
  
  (points (mapcar #'(lambda(x y) (make-point x y 0))
											(the x-coords)
											(the y-coords)))
											

(max-x (most 'get-x (the points)))
(min-x (least 'get-x (the points)))
(max-y (most 'get-y (the points)))
(min-y (least 'get-y (the points)))

(chord (- (get-x (the max-x)) (get-x (the min-x))))

(max-thickness (- (get-y (the max-y)) (get-y (the min-y))))
)

)