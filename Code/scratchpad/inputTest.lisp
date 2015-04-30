(in-package :gdl-user)

(defparameter *dataFolder*
  (make-pathname :name nil
:type nil
:defaults (merge-pathnames "../data/"
#+allegro excl:*source-pathname*
#+lispworks dspec:*source-pathname*
;; in future: (glisp:source-pathname)
)))

(defun readStringData (fileName)
  (with-open-file (in fileName)
    (let (result)
      (do ((line (read-line in nil nil) (read-line in nil nil)))
	  ((or (null line)(string-equal line ""))(nreverse result))
	(unless (char-equal (char line 0) #\;) (push line result)))
)))

(defun readData (fileName)
  (with-open-file (in fileName)
    (let (result)
      (do ((line (read-line in nil nil) (read-line in nil nil)))
	  ((or (null line)(string-equal line ""))(nreverse result))
	(push line result))
)))

(defun splitData (dataList)
 (mapcar 'split dataList))

(defun transData (inputList)
  (list (make-keyword (first inputList)) (parser (first (last inputList)))
))

<<<<<<< HEAD
(defun parseData (inputList)
  (list (parser (first inputList)) (parser (first (last inputList)))
))

=======
>>>>>>> origin/master
(defun plistCreator (dataList)
  (mapcan 'transData dataList)
)

(define-object inputTest ()

  :input-slots
  ((dataFolder *dataFolder*)
   (dataFileName "inputData.dat")
   (fuselageFileName "fuselage.dat")
  )

  :computed-slots
  ((dataFilePath (merge-pathnames (the dataFileName)
				  (the dataFolder)))
<<<<<<< HEAD
   (fuselageFilePath (merge-pathnames (the fuselageFileName)
				      (the dataFolder)))
  (data (readStringData (the dataFilePath)))
   (dataFus (basicNumberReader (the fuselageFilePath)))
   (dataOld (readData (the dataFilePath)))
  (dataSplit (splitData(the data)))
   (dataFirstCharacter (char (first (the data)) 0))
   (dataCompareTest (char-equal (the dataFirstCharacter) #\;))
   (dataUnlessTest (unless (the dataCompareTest) "No comment"))
=======
  (data (readData(the dataFilePath)))
  (dataSplit (splitData(the data)))
>>>>>>> origin/master
   (dataTest (first (the dataSplit)))
   (dataTest2 (first (the dataTest)))
   (dataTest3 (first (rest (the dataTest))))
   (dataKeyTest (make-keyword (the dataTest2)))
   (dataReadTest (parser (the dataTest3)))
  (dataTrans (plistCreator(the dataSplit)))
  (wingspan (getf (the dataTrans) :wingspan)))

)

(defun parser (string) 
 (let ((*read-eval* nil)) (with-input-from-string (stream string) (read stream)))
)
<<<<<<< HEAD

;; basicNumberReader - input file location - output list of numbers (parses only one number per line)
(defun basicNumberReader (filename)
	(mapcar 'parser (mapcan 'split (readStringData filename)))
)

;; basicDataReader - input file location - output property list plist of data file 
(defun basicDataReader (filename)
  (mapcan 'transData (splitData (readStringData filename)))
)
=======
>>>>>>> origin/master
