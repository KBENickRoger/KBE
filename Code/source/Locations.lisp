(in-package :gdl-user)

(define-object locations ()
:input-slots
((dEpsdAlph)
	(CLalphaWF)
	(CLalpha)
	(tailCLalpha)
	(Vh_V) 
	(wingHArea)
	(tailArm)
	(wingCmac)	
	(wingTaper)
	(tailTaper)
	(span)
	(wingSweepLE)
	(fuselageRadius)
	(wingCenter)
	(Kn)
	(Bn)
	(spanNet)
	(l_n)
	(rootChord)
	(tipChord)
	
	)

:computed-slots
((""
wingSweepQCrad (asin (/ (+ (half (- (the tipChord) (the rootChord))) (* (the span) (sin (degrees-to-radians (the wingSweepLE))))) (the span))))

("Length of fuselage in front of wing"
fuselageLenghtForward (+ (get-y (the wingCenter)) (half (the rootChord)) (- (* (the fuselageRadius) (sin (degrees-to-radians (the wingSweepLE)))))))

(stabilityMargin (* 0.05 (the wingCmac)))

(""
chordGeometric (/ (the wingArea) (the wingSpan)))

(""
Xcg (+ (the Xac) 
		(* (/ (the tailCLalpha) (the CLalpha)) 
			(- 1 (the dEpsdAlph)) 
			(/ (* (the tailArm) (the tailArea)) (* (the wingArea) (the wingCmac)))
			(expt (the Vh_V) 2))
			(- (the stabilityMargin))))

(""
Xac (+ (the XacWF) (the XacNac)))  ;(the XacT)

(""
XacWF (* (the wingCmac) (+ (/ (the XacW) (the wingCmac)) 
							(- (/ (* 1.8 (twice (the fuselageRadius)) (the fuselageLenghtForward) (twice (the fuselageRadius)))
									(* (the wingArea) (the wingCmac))))
							(* (/ (* 0.273 (twice (the fuselageRadius)) (the chordGeometric) (the spanNet))
								(* (+ 1 (the wingTaper)) (expt (the wingCmac) 2) (+ (the wingSpan) (* 2.15 (twice (the fuselageRadius))))))
								(tan (the wingSweepQCRad)))))
								)

(""
XacNac (/ (* (the Kn) (expt (the Bn) 2) (the l_n)) (* (the wingArea) (the wingCmac) (the CLalphaWF))))

;(""
;XacT)


)
)