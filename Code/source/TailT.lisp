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
	)
   
   (""
    horizontalTail :type 'TailSurface
	:symmetry t
	:area (the surfaceVertical)
	:AR (getf (the tailParameters) :horizontalAR)
	:taper (getf (the tailParameters) :horizontalTaper)
	:center (translate (the center) :up (the verticalTail span))
	)
  
  )
  
  :functions
  ())

