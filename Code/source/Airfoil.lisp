(in-package :gdl-user)

(define-object Airfoil ()
:input-slots
(
	(C1 0.5)
	(C2 1)
	(X 25 :setttable)
	(filename))
:computed-slots
 ( 
 (CST (CSTreader (the filename)))
 
 (XYcoord (CST2XY (the CST)))
 ) 
)

