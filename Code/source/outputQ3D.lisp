(in-package :gdl-user)

(define-object outputQ3D ()

:input-slots
(
(file "Q3D_output.m")
(outputFolder *outputFolder*)
(wing)
(wingAssy)
(condition)
 )


:computed-slots
(
(filePath (merge-pathnames (the file) (the outputFolder)))
(innerWing (the wing innerWing))
(outerWing (the wing outerWing))

(c1 (the wing chordRoot))

(x2 (* (cos (the wing sweepLERad)) (the wing spanInner)))
(y2 (the innerWing sweepOffset))
(z2 (* (sin (degtorad (the wingAssy dihedral))) (the wing spanInner)))
(c2 (the wing chordKink))

(x3 (* (cos (the wing sweepLERad)) (the wing span)) )
(y3 (+ (the y2) (the outerWing sweepOffset)))
(z3 (* (sin (degtorad (the wingAssy dihedral))) (the wing span)))
(c3 (the wing chordTip))

(cst (the innerWing profile cst))

(kinkPos (the wing kinkPos))

(viscous (getf (the condition) :viscous))
(V (getf (the condition)  :V))
(rho (getf (the condition)  :rho))
(altitude (getf (the condition)  :altitude))
(mach (getf (the condition)  :mach))
(weight (getf (the condition)  :weight))

(reynoldsNumber (/ (* (the  V) (the wing Cmac)) (* 1.46 (expt 10 -5))))
(CL (/ (* 2 (the weight)) (* (the rho) (expt (the V) 2) (the wingAssy surface))))

)


:objects
()

:functions
(
(Q3D_writer ()
	(with-open-file (stream (the filePath) 
							:direction :output
							:if-exists :supersede)
	(format stream "%Q3D input file ~%")
	
	(format stream "AC.Wing.Geom = [ 0 0 0 ~5$ 0 ; ~%" 
	(the c1))
	(format stream "~5$ ~5$ ~5$ ~5$ 0 ; ~%" 
	(the x2)
	(the y2)
	(the z2)
	(the c2))
	(format stream "~5$ ~5$ ~5$ ~5$ 0 ]; ~% ~%"
	(the x3)
	(the y3)
	(the z3)
	(the c3))
	
	(format stream "% Wing incidence angle (degree) ~%")
	(format stream "AC.Wing.inc  = 0;  ~% ~%")
	
	(format stream "% Airfoil CST coefficients ~%")
	(format stream "AC.Wing.Airfoils = [ ~{~5$ ~} ; ~% ~{~5$ ~} ; ~% ~{~5$ ~} ]; ~% ~%" 
	(the cst)
	(the cst)
	(the cst))
	
	(format stream "% Spanwise location of the airfoil sections ~%")
	(format stream "AC.Wing.eta = [0 ; ~a ; 1]; ~%" (the kinkPos))
	
	(format stream "% flight conditions ~%")
	(format stream "AC.Visc = ~a; ~%" (the viscous))
	(format stream "AC.Aero.V = ~a; ~%" (the V))
	(format stream "AC.Aero.rho = ~a; ~%" (the rho))
	(format stream "AC.Aero.alt = ~a; ~%" (the altitude))
	(format stream "AC.Aero.M = ~a; ~%" (the mach))
	(format stream "AC.Aero.Re = ~a; ~% ~%" (the reynoldsNumber))
	
	(format stream "% Required CL ~%")
	(format stream "AC.Aero.CL = ~5$; ~% ~%" (the CL))
	
	(format stream "% Run Q3D ~%")
	(format stream "results = Q3D_solver(AC);")
	
	
	)
	
)
)

)
