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
	
	(horizontalSweepLE)
	
		(""
	airfoil "naca0012_cst.dat")
	
	(mach)
 )
 
  :computed-slots
((CLalpha (the horizontalTail CLalpha))
  (taper (the horizontalTail taper)))
  
  
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
	:tailSurfaceType 2
	:MACHidden? nil
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
	:tailSurfaceType 2
	:MACHidden? nil
	)
   
   
   (""
    horizontalTail :type 'TailSurface
	:symmetry t
	:area (the surfaceHorizontal)
	:AR (getf (the tailParameters) :horizontalAR)
	:taper (getf (the tailParameters) :horizontalTaper)
	:airfoil (the airfoil)
	:horizontalSweepLE (the horizontalSweepLE)
	:tailSurfaceType 1
	:Vh_V (getf (the tailParameters) :Vh_V)
	:mach (the mach)
	:MACHidden? nil
	)
  
  )
  
  :functions
  ())

