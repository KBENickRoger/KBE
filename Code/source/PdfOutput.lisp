(in-package :gdl-user)

(define-object OutputPDF (base-drawing)

:input-slots
(
 (outputFolder *outputFolder*)
 (wing) 
 (tail)
 (Locations)
 (AeroGradients)
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
							 :AC_and_CG " "
							 :Xcg (the Locations Xcg)
							 :Xac (the Locations XacTot)
							 :Cg/MAC (/ (- (the Locations Xcg) (get-y (the wing (wings 0) MAC center))) (the wing Cmac))
							 :AC/MAC (/ (- (the Locations XacTot) (get-y (the wing (wings 0) MAC center))) (the wing Cmac))
							 :Lift_gradients " "
							 :dCL_dAlpha_wing (the AeroGradients CLalpha)
							 :dCL_dAlpha_wing+fuselage (the AeroGradients CLalphaWF)
							 :dCL_dAlpha_Horizontal_Tail (the tail CLalpha)
							 :Downwash_gradient_at_tail (the AeroGradients dEpsdAlph)
							 :Tailparameters " "
							 :Tailsurface_Horizontal_Tail (the tailSizing tailSurfaceHorizontal)
							 :Tailsurface_Vertical_Tail (the tailSizing tailSurfaceVertical)
							 :Weight ""
							 ;:Tail_Weight 
							 ))
)
:objects
(
(text-view :type 'base-view
			:objects (list (the text-block))
			:length (the length)
			:width (the width)
			:projection-vector (getf *standard-views* :top)
			:center (the center) 
			:hidden? t)
)			
							 
:functions
((output! 
  ()
  (with-format (pdf (merge-pathnames "Output.pdf" (the outputFolder))
		    :page-length (the page-length) :page-width (the page-width))
    (write-the cad-output)))))