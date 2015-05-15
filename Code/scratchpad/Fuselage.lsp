(in-package: gdl-user)

(define-object fuselagetail (cylinder)
:input-slots
((diameter 2)
(divergence 15)
(lengthTail 5)
(cross-section-percentages (list 0 0.5 0.9)

)
:computed-slots
((length (the lengthTail))

(section-offset-length  mapcar (* (the cross-section-percentages) (the lengthTail)))

(section-offset-divergence mapcar (- (* sin(the divergence) (the lengthTail) (the cross-section-percentages)) 
									(* (the cross-section-percentages) (the section-radii))))


(section-radii mapcar (* (the diameter) 0.5 (- 1 (the cross-section-percentages)))
)
)
:objects 

((section-curves :type 'arc-curve
:sequence (:size (length (the section-centers)))
:center (translate (the center)
					:rear (+ (the lengthNose) (the lengthCenter) (nth (the section-offset-length))
					:up (nth (the section-offset-divergence)))
:radius (nth (the-child index) (the section-radii))
:orientation (alignment :top (the (face-normal-vector :front))))

()
)