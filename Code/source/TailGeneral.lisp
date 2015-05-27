(in-package :gdl-user)

(define-object TailGeneral (base-object)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  (	
	(""
    surfaceHorizontal 10 :settable)
   
	(""
    surfaceVertical 10 :settable)
	
	(""
	tailParameters nil)
	
	(""
	airfoil "naca0012_cst.dat" :settable)
	
	(""
	horizontalSweepLE 5 :settable)
	
	(""
	mach 1.0)
	
	(""
	weightParams nil)
	)
 
)

