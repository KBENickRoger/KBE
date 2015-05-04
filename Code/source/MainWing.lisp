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
	(rootPoint (make-point 0 0 0))
	(sweepLE 10))
  
  
  :computed-slots
  ((center (translate-along-vector (the rootPoint)
			(the (face-normal-vector :right))
			(half (the span))))
	(spanInner (* (the span)(the kinkPos)))
	(spanOuter (- (the span)(the spanInner)))
	(sweepLERad (degtorad (the sweepLE)))
	(chordKink (- (the chordRoot)(* (the spanInner)(tan (the sweepLERad)))))
	)
  
  
  :objects
  ((innerWing
	:type 'box
	:length (the chordRoot)
	:width (the spanInner)
	:height 1
	:orientation (the orientation)
	:center (translate-along-vector (the rootPoint)
			(the (face-normal-vector :right))
			(half (the spanInner))))
			
	(outerWing
	:type 'box
	:length (the chordKink)
	:width (the spanOuter)
	:height 1
	:orientation (the orientation)
	:center (translate-along-vector(the innerWing center)
			(the (face-normal-vector :right))
			(+ (half (the spanInner))(half (the spanOuter)))))
	
	)
  
  
  :functions
  ())

