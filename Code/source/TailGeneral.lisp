(in-package :gdl-user)

(define-object TailGeneral (base-object)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  (	
	(""
    surfaceHorizontal 10)
   
	(""
    surfaceVertical 10)
	
	(""
	tailParameters nil)
	
	(""
	airfoil "naca0012_cst.dat")
	
	(""
	horizontalSweepLE 5)
	
	(""
	mach 1.0)
	
	(""
	weightParams nil)
)
 
)

