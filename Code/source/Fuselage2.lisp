(in-package :gdl-user)

;to do:
; Test in current form
; Build in divergence
; Build in noseoffset
; Recreate FuselageCenter
; Rewrite input.dat with fuselagelength and computed slots nose and tail.
;
;
(define-object Fuselage (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  (
  (""
  *datafolder*)
  
  (""
  inputFuselageFileName "fuselage.dat" )
  
   (""
    finenessRatio 5)
	
   (""
    lengthCenter 8)
	
   (""
    lengthNose 2 :settable)

   (""
    lengthTail 2 :settable)
	
   (""
   divergence 15 :settable)
   
   (""
   section-offset-percentages (list 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1))
   
  (""
  center (make-point 0 0 0))
  )
  
  :computed-slots
  ((inputDataFilePath (merge-pathnames (the inputFuselageFilename) (the dataFolder)))
  (cross-section-percentages (basicNumberReader (the inputDataFilePath)))
  
  (diameter (/ (the lengthTotal) (the finenessRatio)))
  
   (lengthTotal (+ (the lengthCenter) (the lengthNose) (the lengthTail)))

	(section-radii (mapcar #'(lambda (z) (* (half (the diameter)) z)) (the cross-section-percentages)))
	
	(divergenceRAD (DEGREES-TO-RADIANS (the divergence)))
  )
  

  :objects   
   ((fuselage
    :type 'merged-solid
	:brep (the loft brep)
	:other-brep ()
	:make-manifold? t
	:hidden? t)
	
	(section-curves 
	:type 'arc-curve
	:sequence (:size (length (the section-offset-percentages)))
	:center (translate (the center)
			:rear (* (nth (the section-offset-percentages)) (the lenghtTotal)))
	;		:down (- (first (the tail-section-radii)) (nth (the-child index) (the tail-section-radii)))
	;		:up (nth (the-child index) (the tail-section-offset-divergence)))
	:radius (nth (the-child index) (the section-radii))
	:orientation (alignment :top (the (face-normal-vector :front)))
	:hidden? t)
	
	(loft :type 'lofted-surface
	:end-caps-on-brep? t
	:curves (list-elements (the section-curves)))
    )

  :functions
  ())



