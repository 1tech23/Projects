(in-package #:cl-user)

#-(or sbcl clisp ccl ecl lispworks6)
(error "This lisp implementation is not supported, unfortunately :(")

(require 'asdf)

#+lispworks
(progn
  (setf *compile-print* 1)
  (toggle-source-debugging t)
  (lw:set-default-character-element-type 'lw:simple-char)

  (unless
      (dolist (install-path
               '("quicklisp" ".quicklisp"))
        (let ((quicklisp-init
                (merge-pathnames (make-pathname :directory `(:relative ,install-path)
                                                :name "setup.lisp")
                                 (user-homedir-pathname))))
          (when (probe-file quicklisp-init)
            (load quicklisp-init)
            (return t))))

    (error "Quicklisp must be installed in order to build OneDE with ~S."
           (lisp-implementation-type))))

(asdf:initialize-source-registry
 '(:source-registry
   (:directory "/home/logan/git/Projects/OneDE/OneDE-0.0.1")
   :inherit-configuration))

(asdf:oos 'asdf:load-op 'onede)
