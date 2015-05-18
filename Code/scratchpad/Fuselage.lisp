(in-package :gdl-user)

(define-object fuselagetail (base-object)
:input-slots
((diameter 2)
(divergence 15)
(lengthTail 15)
(cross-section-percentages (list 0 0.5 0.9))
(tailPoint (make-point 0 0 0))
(lengthCenter 25)
(lengthNose 5)
)
:computed-slots
((section-offset-length  (mapcar #'(lambda (x) (* x (the lengthTail))) (the cross-section-percentages)))

(section-radii (mapcar #'(lambda (z) (* (half (the diameter)) (- 1 z))) (the cross-section-percentages)))

(section-offset-divergence (mapcar #'(lambda (y1) (* (sin(the divergenceRAD)) y1)) (the section-offset-length)))

(divergenceRAD (DEGREES-TO-RADIANS (the divergence)))
)

;:objects 
((section-curves :type 'arc-curve
:sequence (:size (length (the section-offset-length)))
:center (translate (the tailPoint)
					:rear (+ (the lengthNose) (the lengthCenter) (nth (the-child index) (the section-offset-length)))
			;		:down (- (first (the section-radii)) (nth (the-child index) (the section-radii)))
					:up (nth (the-child index) (the section-offset-divergence)))
:radius (nth (the-child index) (the section-radii))
:orientation (alignment :top (the (face-normal-vector :front))))
)
)
;(merged :type 'merged-solid
;:brep (the loft brep)
;:make-manifold? t)

;(loft :type 'lofted-surface
;:end-caps-on-brep? t
;:curves (list-elements (the section-curves)))
;))
