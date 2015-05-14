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
  (("Centerplacement of box for wing"
  center (translate-along-vector (the rootPoint)
			(the (face-normal-vector :right))
			(half (the span))))
	("Span of inboard wing (before kink)"
	spanInner (* (the span)(the kinkPos)))
	
	("Span of outboard wing (after kink)"
	spanOuter (- (the span)(the spanInner)))
	
	("LE sweep in radians"
	sweepLERad (degtorad (the sweepLE)))
	
	("Chord at the kink"
	chordKink (- (the chordRoot)(* (the spanInner)(tan (the sweepLERad)))))
	
	("Surface area of total wing"
	Surface (+ (the innerWing Surface) (the outerWing Surface)) ))
	
	("c_mac of main wing"
	Cmac (+ (* (the innerWing Cmac) (/ (the innerWing Surface) (the SurfaceTot)))
				(* (the outerWing Cmac) (/ (the innerWing Surface) (the SurfaceTot)))))
	
	("spanwise position of c_mac"
	YCmac (+ (* (the innerWing YCmac) (/ (the innerWing Surface) (the SurfaceTot)))
				(* (+ (the spanInner) (the outerWing YCmac)) (/ (the innerWing Surface) (the SurfaceTot)))))
	)
  :objects
  ((innerWing
	:type 'WingTrunk
	:chordRoot (the chordRoot)
	:chordTip (the chordKink)
	:span (the spanInner)
	:orientation (the orientation)
	:rootPoint (the rootPoint)
	:airfoil (the airfoil)
	:sweepLE (the sweepLE)
	)
			
	(outerWing
	:type 'WingTrunk
	:chordRoot (the chordKink)
	:chordTip (the chordTip)
	:span (the spanOuter)
	:orientation (the orientation)
	:rootPoint (translate (the rootPoint)
			:right (the spanInner)
			:rear (half (the innerWing sweepOffset)))
	:airfoil (the airfoil)
	:sweepLE (the sweepLE)
	)
	
	)
  
  
  :functions
  ())

