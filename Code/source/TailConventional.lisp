(in-package :gdl-user)

(define-object TailConventional (TailGeneral)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
 
  :computed-slots
  (
  (horizontalPlacement 0)
  (horizontalBack 0)
  (CLalpha (the horizontalTail CLalpha))
  (taper (the horizontalTail taper))
  (weight (+ (the verticalTail weight) (the horizontalTail weight)))
  )
  
  :objects
  (
  (""
    verticalTail :type 'TailSurface
	:symmetry nil
	:area (the surfaceVertical)
	:AR (getf (the tailParameters) :verticalAR)
	:taper (getf (the tailParameters) :verticalTaper)
	:dihedral 90
	:airfoil (the airfoil)
	:tailSurfaceType 2
	:MACHidden? nil
	:weightParams (the weightParams)
	)
   
   (""
    horizontalTail :type 'TailSurface
	:symmetry t
	:area (the surfaceHorizontal)
	:AR (getf (the tailParameters) :horizontalAR)
	:taper (getf (the tailParameters) :horizontalTaper)
	:center (translate (the center) :up (* (the horizontalPlacement) (the verticalTail span))
									:rear (the horizontalBack))
	:airfoil (the airfoil)
	:horizontalSweepLE (the horizontalSweepLE)
	:tailSurfaceType 1
	:MACHidden? nil
	:Vh_V (getf (the tailParameters) :Vh_V)
	:mach (the mach)
	:weightParams (the weightParams)
	)
  
  )
  
  :functions
  ())

