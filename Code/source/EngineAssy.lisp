(in-package :gdl-user)

(define-object EngineAssy (base-object)
  
  :documentation
  (:author "Nick"
   :description "")
  
  :input-slots
  (engineNumber position offsetSweep offsetDihedral offsetSpan offsetFuselage length diameter)
  
  
  :computed-slots
  ((center (make-point 0 0 0)))
  
  
  :objects
  ((leftEnginesCyl
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (the length)
	:radius (half (the diameter))
	:center (translate (the position)
				:left (+ (the offsetFuselage)(* (+ (the-child index) 1) (the offsetSpan))))
				:rear (the offsetSweep)
				:down (the diameter)
				:up (the offsetDihedral))
				
	
	(leftEnginesCone
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (the length)
	:radius-1 (half (the diameter))
	:radius-2 (half (half (the diameter)))
	:center (translate (the position)
				:left (+ (the offsetFuselage)(* (+ (the-child index) 1) (the offsetSpan)))
				:rear (+ (the offsetSweep) (half (the length)))
				:down (the diameter)
				:up (the offsetDihedral)))
		
	(rightEnginesCyl
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (the length)
	:radius (half (the diameter))
	:center (translate (the position)
			   :right (+ (the offsetFuselage)(* (+ (the-child index) 1) (the offsetSpan)))
			   :rear (the offsetSweep)
			   :down (the diameter)
			   :up (the offsetDihedral)))			   
  
	(rightEnginesCone
	:type 'cylinder
	:sequence (:size (half (the engineNumber)))
	:length (the length)
	:radius-1 (half (the diameter))
	:radius-2 (half (half (the diameter)))
	:center (translate (the position)
			   :right (+ (the offsetFuselage)(* (+ (the-child index) 1) (the offsetSpan)))
			   :rear (+ (the offsetSweep) (half (the length)))
				:down (the diameter)
				:up (the offsetDihedral)))
	)
  
  :functions
  ()
  
  )

