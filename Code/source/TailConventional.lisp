(in-package :gdl-user)

(define-object TailConventional (base-object)
  
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
	
	(horizontalSweepLE)
	
	(mach)
	
 )
 
  :computed-slots
()
  
  
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
	:airfoil (the airfoil)
	:horizontalSweepLE (the horizontalSweepLE)
	:tailSurfaceType 1
	:MACHidden? nil
	:Vh_V (getf (the tailParameters) :Vh_V)
	:mach (the mach)
	)
  
  )
  
  :functions
  ())

