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
   tail-cross-section-percentages (list 0 0.5 0.9))
   
   (""
   nose-cross-section-percentages (list 0 0.5 1))
   
  (""
  center (make-point 0 0 0))
  )
  
  :computed-slots
  ((diameter (/ (the lengthTotal) (the finenessRatio)))
  
   (lengthTotal (+ (the lengthCenter) (the lengthNose) (the lengthTail)))
   
   (tail-section-offset-length  (mapcar #'(lambda (x) (* x (the lengthTail))) (the tail-cross-section-percentages)))

	(tail-section-radii (mapcar #'(lambda (z) (* (half (the diameter)) (- 1 z))) (the tail-cross-section-percentages)))

	(tail-section-offset-divergence (mapcar #'(lambda (y1) (* (sin(the divergenceRAD)) y1)) (the taile-section-offset-length)))
	
	(nose-section-offset-length  (mapcar #'(lambda (x) (* (the nose-loft-length) x)) (the nose-cross-section-percentages)))

	(nose-section-radii (mapcar #'(lambda (z) (+ (half (the diameter)) (* x (half (the diameter))))) (the nose-cross-section-percentages)))
	
	(nose-Radius (/ (the diameter) 4))
	
	(nose-loft-length (- (the lengthNose) (the nose-Radius)))

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
	:brep (the loftTail brep)
	:other-brep ()
	:make-manifold? t
	:hidden? t)
	
	(fuselageNose 
    :type 'merged-solid
	:brep (the loftNose brep)
	:other-brep ()
	:make-manifold? t
	:hidden? t)
	
	(fuselageNoseDome
	:type 'spherical-cap
	:axis-length (the nose-Radius)
	:cap-thickness (nil)
	:closed? t

	(tail-section-curves 
	:type 'arc-curve
	:sequence (:size (length (the tail-section-offset-length)))
	:center (translate (the center)
			:rear (+ (the lengthNose) (the lengthCenter) (nth (the-child index) (the tail-section-offset-length)))
			:down (- (first (the tail-section-radii)) (nth (the-child index) (the tail-section-radii)))
			:up (nth (the-child index) (the tail-section-offset-divergence)))
	:radius (nth (the-child index) (the section-radii))
	:orientation (alignment :top (the (face-normal-vector :front)))
	:hidden? t)
	
	(nose-section-curves 
	:type 'arc-curve
	:sequence (:size (length (the nose-section-offset-length)))
	:center (translate (the center)
			:rear (+ (the nose-Radius) (nth (the-child index) (the nose-section-offset-length)))
			:down (- (first (the nose-section-radii)) (nth (the-child index) (the nose-section-radii)))
	:radius (nth (the-child index) (the nose-section-radii))
	:orientation (alignment :top (the (face-normal-vector :front)))
	:hidden? t)

	(loftTail :type 'lofted-surface
	:end-caps-on-brep? t
	:curves (list-elements (the tail-section-curves)))
	
	(loftnose :type 'lofted-surface
	:end-caps-on-brep? t
	:curves (list-elements (the nose-section-curves)))
	
    )

  :functions
  ())



