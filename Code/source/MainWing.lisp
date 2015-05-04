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
	(sweepLE 10)
	(airfoil))
  
  
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
	:type 'WingTrunk
	:chordRoot (the chordRoot)
	:chordTip (the chordKink)
	:span (the spanInner)
	:height 1
	:orientation (the orientation)
	:center (translate-along-vector (the rootPoint)
			(the (face-normal-vector :right))
			(half (the spanInner)))
	:airfoil (the airfoil))
			
	(outerWing
	:type 'WingTrunk
	:chordRoot (the chordKink)
	:chordTip (the chordTip)
	:span (the spanOuter)
	:height 1
	:orientation (the orientation)
	:center (translate-along-vector(the innerWing center)
			(the (face-normal-vector :right))
			(+ (half (the spanInner))(half (the spanOuter))))
	:airfoil (the airfoil))
	
	)
  
  
  :functions
  ())

