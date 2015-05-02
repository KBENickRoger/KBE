(in-package :gdl-user)

(define-object Fuselage (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  ((""
    lengthTotal 10)
   
   (""
    finenessRatio 4)
	
   (""
	lengthCenter 8)
	
	(""
	lengthNose 2)
  )
  
  :computed-slots
  ((diameter (/ (the lengthTotal) (the finenessRatio)))
   (lengthTail (- (the lengthTotal) (the lengthCenter)))
  
  )
  

  :objects 
  ((fuselageNose
    :type 'cylinder
    :length (the lengthNose)
    :radius (half (the diameter))
    :center (translate (the center)
		       :rear (half (the lengthNose)))
    )
   
   (fuselageCenter 	
    :type 'cylinder
    :length (the lengthCenter)
    :radius (half (the diameter))
    :center (translate (the center)
			:rear (+ (the lengthNose) (half (the lengthCenter))))
	)
   
   (fuselageTail
    :type 'cylinder
    :length (the lengthTail)
    :radius (half (the diameter))
    :center (translate (the center)
		       :rear (+ (the lengthNose)(the lengthCenter)(half (the lengthTail))))
    )

  )

  :functions
  ())



