(in-package :gdl-user)

(define-object EngineAssy (base-object)
  
  :documentation
  (:author "Nick"
   :description "")
  
  :input-slots
  (engineNumber position offsetSweep offsetDihedral offsetSpan offsetWingFront offsetWingBottom offsetEngineDiameter offsetFuselage length diameter ACy)
  
  
  :computed-slots
  ((center (make-point 0 0 0))
  
  ("distance engine centers to Ac of aircraft"
	l_n (+ (sum-elements (the leftEngines) (the-element l_n))
			(sum-elements (the rightEngines) (the-element l_n))))
	
	)
  
  :objects
  ((leftEngines
	:type 'Engine
	:sequence (:size (half (the engineNumber)))
	:length (half (the length))
	:radius (half (the diameter))
	:center (translate (the position)
			   :left (+ (the offsetFuselage) (* (+ (the-child index) 1) (the offsetSpan)) (the offsetEngineDiameter))
			   :rear (* (the offsetSweep) (+ (the-child index) 1))
			   :front (the offsetWingFront)
				:down (the offsetWingBottom)
				:up (* (+ (the-child index) 1) (the offsetDihedral)))
	:ACy (the ACy))
				
		
	(rightEngines
	:type 'Engine
	:sequence (:size (half (the engineNumber)))
	:length (half (the length))
	:radius (half (the diameter))
	:center (translate (the position)
			   :right (+ (the offsetFuselage) (* (+ (the-child index) 1) (the offsetSpan)) (the offsetEngineDiameter))
			   :rear (* (the offsetSweep) (+ (the-child index) 1))
			   :front (the offsetWingFront)
			   :down (the offsetWingBottom)
			   :up (* (+ (the-child index) 1) (the offsetDihedral)))
	:ACy (the ACy))			   
	)
  
  :functions
  ()
  
  )

