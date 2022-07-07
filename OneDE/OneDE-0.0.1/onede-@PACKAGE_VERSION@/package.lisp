;; package.lisp -- 
;; Copyright (C) 2022 Logan Alldredge
;;
;;  This file is part of onede.
;;
;; onede is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; onede is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this software; see the file COPYING.  If not, see
;; <http://www.gnu.org/licenses/>.

(defpackage :onede
  (:use :cl)
  (:shadow #:yes-or-no-p #:y-or-n-p)
  (:export
   #:call-in-main-thread))

(defpackage :onede-user
  (:use :cl :onede))
