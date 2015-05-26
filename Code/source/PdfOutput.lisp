(in-package :gdl-user)

(define-object OutputPDF (base-drawing)

:input-slots
(
 (outputFolder *outputFolder*)
 (fuselage) 
 (engines) 
 (wing) 
 (tail)
 (Locations)
 (AeroGradients)
 (input)
 (MAC)
)

:computed-slots
(
(outputPDF! (the (output!)))
)

:hidden-objects
(
			(text-block :type 'Output-text-block
							 :margins (twice (twice (the text-view left-margin)))
							 :width (the text-view width)
							 :length (the text-view length)
							 :inputList (list 
							 
							 ))
)
:objects
(
(text-view :type 'base-view
			:objects (list (the text-block))
			:length (the length)
			:width (the width)
			:projection-vector (getf *standard-views* :top)
			:center (the center) )
)			
							 
:functions
((output! 
  ()
  (with-format (pdf (merge-pathnames "Output.pdf" (the outputFolder))
		    :page-length (the page-length) :page-width (the page-width))
    (write-the cad-output)))))