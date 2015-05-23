(in-package :gdl-user)

(define-object EngineAssy (base-object)
  
  :documentation
  (:author "Nick"
   :description "")
  
  :input-slots
  (engineNumber position offsetSweep offsetDihedral offsetSpan offsetWingFront offsetWingBottom offsetEngineDiameter offsetFuselage length diameter)
  
  
  :computed-slots
  ((center (make-point 0 0 0)))
  
  
  :objects
  ((leftEnginesCyl
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (half (the length))
	:radius (half (the diameter))
	:center (translate (the position)
				:left (+ (the offsetFuselage) (* (+ (the-child index) 1) (the offsetSpan)) (the offsetEngineDiameter))
				:rear (* (the offsetSweep) (+ (the-child index) 1)) 
				:front (the offsetWingFront)
				:down (the offsetWingBottom)
				:up (* (+ (the-child index) 1) (the offsetDihedral))))
				
	
	(leftEnginesCone
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (half (the length))
	:radius-1 (half (the diameter))
	:radius-2 (half (half (the diameter)))
	:center (translate (the position)
				:left (+ (the offsetFuselage) (* (+ (the-child index) 1) (the offsetSpan)) (the offsetEngineDiameter))
				:rear (+ (half (the length)) (* (the offsetSweep) (+ (the-child index) 1)) )
				:front (the offsetWingFront)
				:down (the offsetWingBottom)
				:up   (* (+ (the-child index) 1) (the offsetDihedral))))
		
	(rightEnginesCyl
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (half (the length))
	:radius (half (the diameter))
	:center (translate (the position)
			   :right (+ (the offsetFuselage) (* (+ (the-child index) 1) (the offsetSpan)) (the offsetEngineDiameter))
			   :rear (* (the offsetSweep) (+ (the-child index) 1))
			   :front (the offsetWingFront)
			   :down (the offsetWingBottom)
			   :up (* (+ (the-child index) 1) (the offsetDihedral))))			   
  
	(rightEnginesCone
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (half (the length))
	:radius-1 (half (the diameter))
	:radius-2 (half (half (the diameter)))
	:center (translate (the position)
			   :right (+ (the offsetFuselage) (* (+ (the-child index) 1) (the offsetSpan)) (the offsetEngineDiameter))
			   :rear (+ (half (the length)) (* (the offsetSweep) (+ (the-child index) 1)) )
			   :front (the offsetWingFront)
				:down (the offsetWingBottom)
				:up (* (+ (the-child index) 1) (the offsetDihedral))))
	)
  
  :functions
  ()
  
  )

