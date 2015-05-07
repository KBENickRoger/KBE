(in-package :gdl-user)

(define-object Fuselage (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  (
   (""
    finenessRatio 4)
	
   (""
    lengthCenter 8)
	
   (""
    lengthNose 2)

   (""
    lenghtTail 2)
  )
  
  :computed-slots
  ((diameter (/ (the lengthTotal) (the finenessRatio)))
   (lengthTotal (+ (the lengthCenter) (the lengthNose) (the lengthTail)))
  )
  

  :objects 
  ((fuselageNose
    :type 'cone
    :length (the lengthNose)
    :radius-1 (* 0.75 (half (the diameter)))
	:radius-2 (half (the diameter))
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
    :type 'cone
    :length (the lengthTail)
	:radius-1 (half (the diameter))
    :radius-2 (half (half (the diameter)))
    :center (translate (the center)
		       :rear (+ (the lengthNose)(the lengthCenter)(half (the lengthTail))))
    )

  )

  :functions
  ())



