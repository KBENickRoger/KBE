(in-package :gdl-user)

(define-object CSTtest ()

:input-slots

 :computed-slots
 ()

)

(define-object CSTconverter ()

:input-slots
(Au Al)

:computed-slots
((nu (- (length (the Au)) 1))
 (nl (- (length (the Al)) 1))
 )
 
 

)


(defun CST2XYupper (nu nl)

(nu (length (the cstu)))
(nl (length (the cstl)))

(iterate:iter(iterate:for i from 0 to (- (the X)))
			(iterate:for C = (* (expt (nth (the x)) (the N1)) (expt (- 1 (nth (the x))) (the N2)) ))
			
			(iterate:for answer1 = 0)
			(iterate:for answer2 = 0)
			
			(iterate:iter(iterate:for j from 0 to (the nu))
						(iterate:for KNRu = (/ (factorial(the nu)) (* (factorial(j) (factorial((- (the nu) j)))))))
						(iterate:for KNRl = (/ (factorial(the nl)) (* (factorial(j) (factorial((- (the nl) j)))))))
			
						(iterate:for Su = (+ (nth (the answer1)) (* (nth (the cstu)) (the KNRu) (expt (- 1 (nth (the x))) (- ((the nu) j))) (expt (nth (the x)) j))))
						(iterate:for Sl = (+ (nth (the answer2)) (* (nth (the cstl)) (the KNRl) (expt (- 1 (nth (the x))) (- ((the nl) j))) (expt (nth (the x)) j))))
				
						(iterate:collect Su into answer1)
						(iterate:collect Sl	into answer2)
			)
				
			(iterate:for Yu = (* (the C) (last (the Su))))
			(iterate:for Yl = (* (the C) (last (the Sl))))
			
			(iterate:collect Yu into YuTot)
			(iterate:collect Yl into YlTot)
)

(defun CST2XYlower (nu nl)

(nu (length (the cstu)))
(nl (length (the cstl)))

(iterate:iter(iterate:for i from 0 to (- (the X)))
			(iterate:for C = (* (expt (nth (the x)) (the N1)) (expt (- 1 (nth (the x))) (the N2)) ))
			
			(iterate:for answer1 = 0)
			(iterate:for answer2 = 0)
			
			(iterate:iter(iterate:for j from 0 to (the nu))
						(iterate:for KNRu = (/ (factorial(the nu)) (* (factorial(j) (factorial((- (the nu) j)))))))
						(iterate:for KNRl = (/ (factorial(the nl)) (* (factorial(j) (factorial((- (the nl) j)))))))
			
						(iterate:for Su = (+ (nth (the answer1)) (* (nth (the cstu)) (the KNRu) (expt (- 1 (nth (the x))) (- ((the nu) j))) (expt (nth (the x)) j))))
						(iterate:for Sl = (+ (nth (the answer2)) (* (nth (the cstl)) (the KNRl) (expt (- 1 (nth (the x))) (- ((the nl) j))) (expt (nth (the x)) j))))
				
						(iterate:collect Su into answer1)
						(iterate:collect Sl	into answer2)
			)
				
			(iterate:for Yu = (* (the C) (last (the Su))))
			(iterate:for Yl = (* (the C) (last (the Sl))))
			
			(iterate:collect Yu into YuTot)
			(iterate:collect Yl into YlTot)
)