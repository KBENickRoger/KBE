(in-package :gdl-user)

(define-object locations ()
:input-slots
((dEpsdAlph)
	(CLalphaWF)
	(CLalpha)
	(tailCLalpha)
	(Vh_V)
	(tailArm)
	(tailArea)
	(wingCmac)	
	(wingTaper)
	(tailTaper)
	(wingArea)
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
	(XacW)
	
	)

:computed-slots
((""
wingSweepQCrad (asin (/ (+ (half (- (the tipChord) (the rootChord))) (* (the span) (sin (degrees-to-radians (the wingSweepLE))))) (the span))))

("Length of fuselage in front of wing"
fuselageLenghtForward (+ (get-y (the wingCenter)) (half (the rootChord)) (- (* (the fuselageRadius) (sin (degrees-to-radians (the wingSweepLE)))))))

(stabilityMargin (* 0.05 (the wingCmac)))

(fuselageDiameter (twice (the fuselageRadius)))

("Mean geomteric chord"
chordGeometric (/ (the wingArea) (the span)))

("Most aft allowed center of gravity"
Xcg (+ (the XacTot) (- (the stabilityMargin))))

("Aerodynamic Center of total aircraft"
XacTot (+ (the Xac) 
		(* (/ (the tailCLalpha) (the CLalpha)) 
			(- 1 (the dEpsdAlph)) 
			(/ (* (the tailArm) (the tailArea)) (* (the wingArea) (the wingCmac)))
			(expt (the Vh_V) 2))))
			
("Aerodynamic center of wing, fuselage and engines"
Xac (+ (the XacWF) (the XacNac)))  ;(the XacT)

("Aerodynamic center of wing, fuselage"
XacWF (* (the wingCmac) (+ (/ (the XacW) (the wingCmac)) 
							(- (/ (* 1.8 (the fuselageDiameter) (the fuselageLenghtForward) (the fuselageDiameter))
									(* (the CLalphaWF) (the wingArea) (the wingCmac))))
							(* (/ (* 0.273 (the fuselageDiameter) (the chordGeometric) (the spanNet))
								(* (+ 1 (the wingTaper)) (expt (the wingCmac) 2) (+ (the span) (* 2.15 (the fuselageDiameter)))))
								(tan (the wingSweepQCRad)))))
								)

("Nacelle aerodynamic center"
XacNac (/ (* (the Kn) (expt (the Bn) 2) (the l_n)) (* (the wingArea) (the wingCmac) (the CLalphaWF))))

;(""
;XacT)


)
)