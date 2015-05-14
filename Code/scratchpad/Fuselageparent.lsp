(define-object cylinder-fuselage (cylinder)
  :input-slots (d l cross-section-percents)

  :computed-slots ((radius (half (the d)))
(length (the l))

(section-offset-percentages (plist-keys (the cross-section-percents)))
(section-centers (let ((nose-point (translate (the center) :front (half (the length)))))
(mapcar #'(lambda (percentage)
(translate nose-point :rear
(* 1/100 percentage (the length))))
(the section-offset-percentages))))

(section-diameter-percentages (plist-values (the cross-section-percents)))

(section-radii (mapcar #'(lambda (percentage)
(* 1/100 percentage (the radius)))
(the section-diameter-percentages))))
  
  :objects ((regioned :type 'regioned-solid
:display-controls (list :transparency 0.5)
:brep (the merged))

  :hidden-objects ((section-curves :type 'arc-curve
:sequence (:size (length (the section-centers)))
:center (nth (the-child index) (the section-centers))
:radius (nth (the-child index) (the section-radii))
:orientation (alignment :top (the (face-normal-vector :front))))

(merged :type 'merged-solid
:brep (the loft brep)
:other-brep (the floor-plane brep)
:make-manifold? t)

(loft :type 'lofted-surface
:end-caps-on-brep? t
:curves (list-elements (the section-curves)))))