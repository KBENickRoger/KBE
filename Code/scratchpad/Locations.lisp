(in-package :gdl-user)

(define-object locations ()
:input-slots
((dEpsdAlph	CLalphaWF CLalpha Vh_V wingArea	wingHArea tailArm wingCmac tailCmac	
wingTaper tailTaper	wingSpan tailSpan wingSweepLE tailSweepLE fuselageRadius wingCenter Kn spanNet
l_n)

(stabilityMargin 0.05))
	
:computed-slots
(
(""
wingSweepQCRad (asin (/ (half (+ (- (the tipChord) (the rootChord))) (* (the span) (sin (the sweepLERAD)))) (the span))) )

(""
tailSweepQCRad)

("Length of fuselage in front of wing"
fuselageLenghtForward (+ (get-y (the wingCenter)) (half (the rootChord)) (- (* (the fuselageRadius) (sin (the wingSweepLE))))))


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
Xac (+ (the XacWF) (the XacNac) (the XacT)))

(""
XacWF (* (the wingCmac) (+ (/ (the XacW) (the wingCmac)) 
							(- (/ (* 1.8 (twice (the fuselageRadius)) (the fuselageLenghtForward) (twice (the fuselageRadius)))
									(* (the wingArea) (the wingCmac))))
							(* (/ (* 0.273 (twice (the fuselageRadius)) (the chordGeometric) (the spanNet))
								(* (+ 1 (the wingTaper)) (expt (the wingCmac) 2) (+ (the wingSpan) (* 2.15 (twice (the fuselageRadius))))))
								(tan (the wingSweepQCRad)))))
								)

(""
XacNac (/ (* (the Kn) (expt (the Bn) 2) (the l_nR)) (* (the wingArea) (the wingCmac) (the CLalphaWF))))

(""
XacT)


)
)