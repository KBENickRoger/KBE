(in-package :gdl-user)

(define-object WingTrunk (geom-base:box)
  
  :documentation
  (:author "Nick"
   :description "")
  
  :input-slots
  ((""
  chordRoot 1) 
  
  (""
  chordTip 1) 
  
  (""
  span 1)
  
  (""
  airfoil)
  
  (dataFolder *dataFolder*)
   )
  
  
  :computed-slots
  ((length (the chordRoot))
	(width (the span))
	(height 1)
	(airfoilFile (merge-pathnames (the airfoil) (the dataFolder)))
	(pointsData (with-open-file (in (the airfoilFile)) (read in)))
	)
  
  
  :objects
  ((box
	:type 'box))
  
  
  :functions
  ())

