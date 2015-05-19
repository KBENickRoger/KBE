(in-package :gdl-user)

(define-object Fuselage (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  (
   (""
    finenessRatio 5)
	
   (""
    lengthCenter 8)
	
   (""
    lengthNose 2)

   (""
    lengthTail 2 :settable)
	
   (""
   divergence 15 :settable)
   
   (""
   cross-section-percentages (list 0 0.5 0.9))
   
  (""
  tailPoint (make-point 0 0 0))
  )
  
  :computed-slots
  ((diameter (/ (the lengthTotal) (the finenessRatio)))
   (lengthTotal (+ (the lengthCenter) (the lengthNose) (the lengthTail)))
   
   (section-offset-length  (mapcar #'(lambda (x) (* x (the lengthTail))) (the cross-section-percentages)))

	(section-radii (mapcar #'(lambda (z) (* (half (the diameter)) (- 1 z))) (the cross-section-percentages)))

	(section-offset-divergence (mapcar #'(lambda (y1) (* (sin(the divergenceRAD)) y1)) (the section-offset-length)))

	(divergenceRAD (DEGREES-TO-RADIANS (the divergence)))
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
    :type 'merged-solid
	:brep (the loft brep)
	:other-brep ()
	:make-manifold? t
	:hidden? t)
 

	(section-curves 
	:type 'arc-curve
	:sequence (:size (length (the section-offset-length)))
	:center (translate (the tailPoint)
			:rear (+ (the lengthNose) (the lengthCenter) (nth (the-child index) (the section-offset-length)))
			:down (- (first (the section-radii)) (nth (the-child index) (the section-radii)))
			:up (nth (the-child index) (the section-offset-divergence)))
	:radius (nth (the-child index) (the section-radii))
	:orientation (alignment :top (the (face-normal-vector :front)))
	:hidden? t)

	(loft :type 'lofted-surface
	:end-caps-on-brep? t
	:curves (list-elements (the section-curves)))
	
    )

  :functions
  ())



