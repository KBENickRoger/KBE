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
 )
 
  :computed-slots
()
  
  
  :objects
  ((""
    verticalTail :type 'TailSurface
	:symmetry nil
	:area (the surfaceVertical)
	:AR 1.9
	:taper 0.3
	:orientation (alignment :top (the (face-normal-vector :left))
			:rear (the (face-normal-vector :rear))
			:right (the (face-normal-vector :top)))
	)
   
   (""
    horizontalTail :type 'TailSurface
	:symmetry t
	:area (the surfaceVertical)
	:AR 5
	:taper 0.3
	)
  
  )
  
  :functions
  ())

