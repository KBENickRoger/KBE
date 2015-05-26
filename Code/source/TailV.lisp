(in-package :gdl-user)

(define-object TailV (tailGeneral)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
 
  :computed-slots
((surfaceTotal (+ (the surfaceHorizontal) (the surfaceVertical)))
 (dihedral (radtodeg (atan (/ (the surfaceVertical) (the surfaceHorizontal)))))
 (CLalpha (the vTail CLalpha))
 (taper (the vTail taper)))

  
  
  :objects
  (
   
   (""
    vTail :type 'TailSurface
	:symmetry t
	:area (the surfaceTotal)
	:AR (getf (the tailParameters) :AR)
	:taper (getf (the tailParameters) :Taper)
	:dihedral (the dihedral)
	:airfoil (the airfoil)
	:horizontalSweepLE (the horizontalSweepLE)
	:Vh_V (getf (the tailParameters) :Vh_V)
	:mach (the mach)
	:MACHidden? nil
	)
  
  )
  
  :functions
  ())

