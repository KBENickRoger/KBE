;;; 
;;; This file contains parameters for the entire package.
;;; 

(in-package :kbe)

;; Define project-independent package parameters
(defun ./ (pathname)
 "pathname. Returns the directory one level up.
  @implementation-detail not relevant for the design"
   (make-pathname :directory (butlast (pathname-directory (pathname pathname)))
                  :device (pathname-device (pathname pathname))))
(defparameter *package-root-directory* (./ excl:*source-pathname*) "root directory of this package")
(defparameter *package-bin-directory* (merge-pathnames "bin/" *package-root-directory*) "bin directory of this package")
(defparameter *package-input-directory* (merge-pathnames "input/" *package-root-directory*) "input directory of this package")
(defparameter *package-output-directory* (merge-pathnames "output/" *package-root-directory*) "output directory of this package")
(defparameter *package-temp-directory* (merge-pathnames "temp/" *package-root-directory*) "temp directory of this package")
(defparameter *package-test-directory* (merge-pathnames "test/" *package-root-directory*) "test directory of this package")

;; Define project specific package-wide parameters
;; TODO: add your project-specific package-wide parameters here