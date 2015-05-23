(in-package :gdl-user)

(define-object outputQ3D ()

:input-slots
(
(file "Q3D_output.m")
(outputFolder *outputFolder*)
(wing)
 )


:computed-slots
(
(filePath (merge-pathnames (the file) (the outputFolder)))
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
	(format stream "AC.Wing.Geom = [ 0 0 0 ~S 0 ; " (the wing chordRoot))
	(format stream "~S ~S 0 ~S 0 ;" )
	
	)
	
)
)

)
