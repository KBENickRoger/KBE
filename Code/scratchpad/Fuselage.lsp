(in-package: gdl-user)

(define-object fuselagetail (cylinder)
:input-slots
((diameter)
(divergence)
(lengthTail)
(section-center-percentages (list 0 0.5 0.9)

)
:computed-slots
((section-centers mapcar ()))

(section-radii mapcar (* (the diameter) 0.5 (the section-center-percentages)))
)
:objects 


((section-curves :type 'arc-curve
:sequence (:size (length (the section-centers)))
:center (nth (the-child index) (the section-centers))
:radius (nth (the-child index) (the section-radii))
:orientation (alignment :top (the (face-normal-vector :front))))


)