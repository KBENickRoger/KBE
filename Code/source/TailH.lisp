(in-package :gdl-user)

(define-object TailH (tailGeneral)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
 
  :computed-slots
 (
  (CLalpha (the horizontalTail CLalpha))
  (taper (the horizontalTail taper))
  (weight (+ (the leftTailUp weight) (the leftTailDown weight) (the rightTailUp weight) (the rightTailDown weight) (the horizontalTail weight)))
  )
  
  
  :objects
  ((""
    leftTailUp :type 'TailSurface
	:symmetry nil
	:area (* 0.25 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
	:center (translate (the center) :left (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
	:weightParams (the weightParams)
	)
	
	(""
    leftTailDown :type 'TailSurface
	:symmetry nil
	:area (* 0.25 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral -90
	:center (translate (the center) :left (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
	:weightParams (the weightParams)
	)
   
   (""
    rightTailUp :type 'TailSurface
	:symmetry nil
	:area (* 0.25 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
	:center (translate (the center) :right (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
	:weightParams (the weightParams)
	)
	
	(""
    rightTailDown :type 'TailSurface
	:symmetry nil
	:area (* 0.25 (the surfaceVertical))
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral -90
	:center (translate (the center) :right (half (the horizontalTail span)):rear (the horizontalTail sweepOffset))
	:airfoil (the airfoil)
	:tailSurfaceType 2
	:weightParams (the weightParams)
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
	:weightParams (the weightParams)
	)
  
  )
  
  :functions
  ())

