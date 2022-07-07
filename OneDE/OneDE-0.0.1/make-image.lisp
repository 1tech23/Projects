(in-package #:cl-user)

(load "load-onede.lisp")

#-ecl (onede:set-module-dir "/home/logan/.onede.d/modules")

(when (uiop:version<= "3.1.5" (asdf:asdf-version))
  ;; We register OneDE and its dependencies as immutable, to stop ASDF from
  ;; looking for their source code when loading modules.
  (uiop:symbol-call '#:asdf '#:register-immutable-system :onede)
  (dolist (system-name (asdf:system-depends-on (asdf:find-system :onede)))
    (uiop:symbol-call '#:asdf '#:register-immutable-system system-name)))

#+sbcl
(sb-ext:save-lisp-and-die "onede" :toplevel (lambda ()
                                                ;; asdf requires sbcl_home to be set, so set it to the value when the image was built
                                                (sb-posix:putenv (format nil "SBCL_HOME=~A" #.(sb-ext:posix-getenv "SBCL_HOME")))
                                                (onede:onede)
                                                0)
                                    :executable t
                                    :purify t)

#+clisp
(ext:saveinitmem "onede" :init-function (lambda ()
                                            (onede:onede)
                                            (ext:quit))
                 :executable t :keep-global-handlers t :norc t :documentation "The OneDE Executable")

#+ccl
(ccl:save-application "onede" :prepend-kernel t :toplevel-function #'onede:onede)

#+ecl
(asdf:make-build 'onnede :type :program :monolithic t
                 :move-here "."
                 :name-suffix ""
                 :epilogue-code '(progn
                                  (onede:set-module-dir "/home/logan/.onede.d/modules")
                                  (onede:onede)))

;;; if you want to save an image
#+(and lispworks (not lispworks-personal-edition))
(hcl:save-image "onede"
                :multiprocessing t
                :environment nil
                :load-init-files t
                :restart-function (compile nil
                                           #'(lambda ()
                                               (onede:onede)
                                               (lw:quit :status 0))))
;;; if you want to save a standalone executable
#+(and nil lispworks (not lispworks-personal-edition))
(lw:deliver #'onede:onede "onede" 0
            :interface nil
            :multiprocessing t
            :keep-pretty-printer t)
#+(and lispworks lispworks-personal-edition)
(warn "OneDE can be saved as an image only in LispWorks Pro/Enterprise editions. Believe me when I say that I don't like it either.")
