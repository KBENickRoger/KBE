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
   )
  
  
  :computed-slots
  ((length (the chordRoot))
	(width (the span))
	(height 1)
	)
  
  
  :objects
  ((box
	:type 'box))
  
  
  :functions
  ())

