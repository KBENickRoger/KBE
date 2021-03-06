(in-package :gdl-user)

(define-object Fuselage (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  (
  ("dataFolder for inputs"
  dataFolder *dataFolder*)
  
  ("Inpud data file"
  inputFuselageFileName "fuselage.dat" )
  
   ("Divergence angle of the tail section"
   divergence 15 :settable)
   
   ("Definition of the offset-percentages"
   section-offset-percentages (list 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1))
  
  ("Total length of the fuselage"
  lengthTotal 100 :settable)
  
 ("Fineness ratio"
 finenessRatio 8 :settable)
  
  )
  
  :computed-slots
  ((inputDataFilePath (merge-pathnames (the inputFuselageFilename) (the dataFolder)))
	(cross-section-percentages (basicNumberReader (the inputDataFilePath)))
  
	(diameter (/ (the lengthTotal) (the finenessRatio)))

	(section-radii (mapcar #'(lambda (z) (* (half (the diameter)) z)) (the cross-section-percentages)))
	
	(divergenceRAD (degrees-to-radians (the divergence)))
	
	(section-offset-divergence (* (sin(the divergenceRAD)) (the lengthTotal) 0.1))
  
	(lengthCenter (* (the lengthTotal) 0.5))

	(lengthNose (* (the lengthTotal) 0.2))
	
	(lengthTail (* (the lengthTotal) 0.3))
	
  )
  

 :objects   
 ; ((fuselage :type 'regioned-solid
	;:display-controls (list :transparency 0.5)
	;:brep (the merged))
   
   ;(merged
    ;:type 'merged-solid
	;:brep (the loft brep)
;	:other-brep ()
;	:make-manifold? t
;	:hidden? t)
	
	((section-curves 
	:type 'arc-curve
	:sequence (:size (length (the section-offset-percentages)))
	:center (translate (the center)
			:rear (* (nth (the-child index) (the section-offset-percentages)) (the lengthTotal))
			:down (cond ((= (the-child index) 0) (half (half (the diameter)))) 
						((= (the-child index) 1) (* 0.33 (half (half (the diameter)))))
						(t 0))	
			:up (cond ((= (the-child index) 7) (- (half (the diameter)) (nth (the-child index) (the section-radii))))
					  ((> (the-child index) 7) (- (* (- (the-child index) 7) (the section-offset-divergence))
												  (* (- 1 (nth (the-child index) (the cross-section-percentages))) (half (the diameter)))))
					  (t 0))
			)
	:radius (nth (the-child index) (the section-radii))
	:orientation (alignment :top (the (face-normal-vector :front)))
	:hidden? t)
	
	(loft :type 'lofted-surface
	:end-caps-on-brep? t
	:curves (list-elements (the section-curves))
    )
	)
	)
