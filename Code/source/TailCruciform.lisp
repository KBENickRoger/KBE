(in-package :gdl-user)

(define-object TailCruciform (tailGeneral)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
 
  :computed-slots
	((""
	  horizontalPlacement (getf (the tailParameters) :horizontalPlacement))
	  
	(CLalpha (the horizontalTail CLalpha))
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
	:center (translate (the center) :up (* (the horizontalPlacement) (the verticalTail span)))
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

