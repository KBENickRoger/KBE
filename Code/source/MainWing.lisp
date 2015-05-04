(in-package :gdl-user)

(define-object MainWing (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  ( (span 50)
	(side :right)
	(chordRoot 10)
	(chordTip 5)
	(kinkPos 0.3)
	(rootPoint (make-point 0 0 0)))
  
  
  :computed-slots
  ((center (translate-along-vector (the rootPoint)
			(the (face-normal-vector :right))
			(half (the span)))))
  
  
  :objects
  ((box
	:type 'box
	:length (the chordRoot)
	:width (the span)
	:height 1
	:orientation (the orientation)))
  
  
  :functions
  ())

