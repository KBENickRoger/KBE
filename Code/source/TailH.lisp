(in-package :gdl-user)

(define-object TailH (tailGeneral)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
 
  :computed-slots
((CLalpha (the horizontalTail CLalpha))
  (taper (the horizontalTail taper)))
  
  
  :objects
  ((""
    leftTailUp :type 'TailSurface
	:symmetry nil
	:area (* 0.3 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
	:center (translate (the center) :left (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
	)
	
	(""
    leftTailDown :type 'TailSurface
	:symmetry nil
	:area (* 0.2 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral -90
	:center (translate (the center) :left (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
	)
   
   (""
    rightTailUp :type 'TailSurface
	:symmetry nil
	:area (* 0.3 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
	:center (translate (the center) :right (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
	)
	
	(""
    rightTailDown :type 'TailSurface
	:symmetry nil
	:area (* 0.2 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral -90
	:center (translate (the center) :right (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
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

