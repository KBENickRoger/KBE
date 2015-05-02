(in-package :gdl-user)

(define-object Fuselage (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  ((""
    lengthTotal 10)
   
   (""
    finenessRatio 2)
	
   (""
	lengthCenter 5)
	
	(""
	lengthNose 2)
  )
  
  :computed-slots
  ((diameter (/ (the lengthTotal) (the finenessRatio)))
   (lengthTail (- (the lengthTotal) (the lengthCenter)))
  
  )
  

  :objects 
  ((fuselageCenter 	:type 'cylinder
					:length (the lengthCenter)
					:radius (half (the diameter))
					:center (translate (the center)
						:rear (- (+ (the lengthNose) (half (the lengthCenter)))))
	)

  )

  :functions
  ())



