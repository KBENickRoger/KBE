(in-package :gdl-user)

(define-object TailC (base-object)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ((""
    surfaceHorizontal 1)
   
   (""
    surfaceVertical 1)
	
	(""
	tailParameters nil)
	
		(""
	airfoil "naca0012_cst.dat")
 )
 
  :computed-slots
()
  
  
  :objects
  ((""
    leftTail :type 'TailSurface
	:symmetry nil
	:area (half (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
	:center (translate (the center) :left (half (the horizontalTail span))
									:rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	)
   
   (""
    rightTail :type 'TailSurface
	:symmetry nil
	:area (half (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
	:center (translate (the center) :right (half (the horizontalTail span))
									:rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	)
   
   
   (""
    horizontalTail :type 'TailSurface
	:symmetry t
	:area (the surfaceHorizontal)
	:AR (getf (the tailParameters) :horizontalAR)
	:taper (getf (the tailParameters) :horizontalTaper)
	:airfoil (the airfoil)
	)
  
  )
  
  :functions
  ())

