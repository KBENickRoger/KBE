(in-package :gdl-user)

(define-object TailT (base-object)
  
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
    verticalTail :type 'TailSurface
	:symmetry nil
	:area (the surfaceVertical)
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
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
	:center (translate (the center) :up (the verticalTail span))
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

