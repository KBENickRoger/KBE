;;; 
;;; This file contains utility functions used in the entire package.
;;;

(in-package :gdl-user)

;; angle manipulation

; converts radians to degrees
(defun radtodeg (r) (* 180.0 (/ r pi)))

; converts degrees to radians
(defun degtorad (d) (* pi (/ d 180.0)))

;; Input data reading functions

;; read string data - input file location - output list of strings read line by line from file
(defun readStringData (fileName)
  (with-open-file (in fileName)
    (let (result)
      (do ((line (read-line in nil nil) (read-line in nil nil)))
	  ((or (null line)(string-equal line ""))(nreverse result))
	(unless (char-equal (char line 0) #\;) (push line result)))
)))

;; split data - input string data list from readStringData - output same list, but with lines split in two strings
(defun splitData (dataList)
 (mapcar 'split dataList))

;; transData - transcribes a list of two strings into a keyword property pair e.g.: "wingspan" "10" to :wingspan 10
(defun transData (inputList)
  (list (make-keyword (first inputList)) (parser (first (last inputList)))
))

;; parser - reads from string while suppressing evaluation
(defun parser (string) 
 (let ((*read-eval* nil)) (with-input-from-string (stream string) (read stream)))
)

;; basicDataReader - input file location - output property list plist of data file 
(defun basicDataReader (filename)
  (mapcan 'transData (splitData (readStringData filename)))
)

;; basicNumberReader - input file location - output list of parsed numbers
(defun basicNumberReader (filename)
	(mapcar 'parser (mapcan 'split (readStringData filename)))
)