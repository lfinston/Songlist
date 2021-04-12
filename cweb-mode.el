;;;; cweb-mode.el. Written by Laurence D. Finston

;; * Copyright and License.

;; This file is part of songlist, a package for keeping track of songs. 
;; Copyright (C) 2021 Laurence D. Finston 

;; songlist is free software; you can redistribute it and/or modify 
;; it under the terms of the GNU General Public License as published by 
;; the Free Software Foundation; either version 3 of the License, or 
;; (at your option) any later version. 

;; songlist is distributed in the hope that it will be useful, 
;; but WITHOUT ANY WARRANTY; without even the implied warranty of 
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
;; GNU General Public License for more details. 

;; You should have received a copy of the GNU General Public License 
;; along with songlist; if not, write to the Free Software 
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA 

;; Please send bug reports to Laurence.Finston@gmx.de 

(setq cweb-mode t)

;; c-mode-map

;; cc-mode.elc is in /usr/share/emacs/26.3/lisp/progmodes

(if (not (boundp 'c-mode-map)) (load "cc-mode.elc"))
  
(defvar cweb-mode-syntax-table nil
  "Syntax table used while in CWEB mode.")

(if cweb-mode-syntax-table
    ()
  (setq cweb-mode-syntax-table (make-syntax-table))
;  (modify-syntax-entry ?\" ".   " cweb-mode-syntax-table)
;  (modify-syntax-entry ?\\ ".   " cweb-mode-syntax-table)
;  (modify-syntax-entry ?' "w   " cweb-mode-syntax-table)
;  (modify-syntax-entry ?% "<   " cweb-mode-syntax-table)
)

(defvar cweb-mode-abbrev-table nil
  "Abbrev table used while in CWEB mode.")

(define-abbrev-table 'cweb-mode-abbrev-table '(
    ))

(defvar cweb-mode-map nil
  "Keymap for CWEB mode.")

;(if (not (boundp 'c-mode-map))
;  (load-file "/usr/share/emacs/26.3/lisp/progmodes/cc-mode.elc"))

(if cweb-mode-map ()
  (setq cweb-mode-map (nconc (make-sparse-keymap) text-mode-map))
  (define-key cweb-mode-map "\"" 'self-insert-command)
  (define-key cweb-mode-map "\t" 'c-indent-command)
  (define-key cweb-mode-map [?\r] 'electric-newline-and-maybe-indent)

  (define-key cweb-mode-map [?\r] 'electric-newline-and-maybe-indent)
  ;; This is ä (a-umlaut).

  (define-key cweb-mode-map "	" 'tab-to-tab-stop) ;; TAB

  (define-key cweb-mode-map [67108899] 'insert-single-quotes) ;; Control-#

  (define-key cweb-mode-map [C-f1] 'outline-next-heading)
  (define-key cweb-mode-map [C-f2] 'outline-next-visible-heading)
  (define-key cweb-mode-map [C-f3] 'outline-forward-same-level)	 
  (define-key cweb-mode-map [C-f4] 'outline-previous-visible-heading)	 
  (define-key cweb-mode-map [C-f5] 'outline-backward-same-level)	 
  (define-key cweb-mode-map [C-f6] 'outline-up-heading)	      


  (define-key cweb-mode-map [228] '(lambda () (interactive)(insert "@"))) 

  (define-key cweb-mode-map [f1] 'font-lock-mode)
  (define-key cweb-mode-map [S-f1] 'facemenu-remove-all)
 
  (define-key cweb-mode-map [f2] 'write-tex)	 



  (define-key cweb-mode-map [S-f2] 'italics)	 
  (define-key cweb-mode-map [f3] 'goto-line)	 
  (define-key cweb-mode-map [S-f3] 'query-replace-regexp)


  (define-key cweb-mode-map [S-print] 'italics)	 


;; (lambda () (interactive)(insert "@")))

  (define-key cweb-mode-map [kp-f3] 'temp)	
  ;;(define-key cweb-mode-map [f4] 'run-cmpl) 
  (define-key cweb-mode-map [S-f4] 'bold-face)
  (define-key cweb-mode-map [f5] 'revert-buffer-y-or-n) 

  (define-key cweb-mode-map [S-f5] 'tt)
  (define-key cweb-mode-map [S-f6] 'get-shell-windows)

  (define-key cweb-mode-map [67111140] '(lambda () (interactive) (insert "\\")))  ;; Cntrl-ä (a-umlaut)


  (define-key cweb-mode-map [C-f7] 'tags-query-replace)	 
  (define-key cweb-mode-map [S-f8] 'unexpand-abbrev)	 
  (define-key cweb-mode-map [C-f8] 'vc-next-action)
  (define-key cweb-mode-map [f9] 'make-verticals)	 
  (define-key cweb-mode-map [S-f9] 'square-brackets)	 
  (define-key cweb-mode-map [C-f9] 'insert-braces-c)	 
  (define-key cweb-mode-map [f10] 'copy-region-as-kill)
  (define-key cweb-mode-map [S-f10] 'curly-braces) 
  (define-key cweb-mode-map [C-f10] 'occur)	 
  (define-key cweb-mode-map [S-f11] 'set-style-registers)
  (define-key cweb-mode-map [f11] 'filename)
  (define-key cweb-mode-map [C-f11] 'copy-to-register)
  (define-key cweb-mode-map [f12] 'insert-register)
  (define-key cweb-mode-map [C-f12] '(lambda ()
				       (interactive)
				       (let (a)
					 (setq a (read-char "Enter a register:"))
					 (insert-register a t))))

  (define-key cweb-mode-map [S-f12] 'syntax-item)

  (define-key cweb-mode-map "" 'tt) ;; C-Alt-t
  (define-key cweb-mode-map "" 'syntax-item)  ;; C-Alt-y


  ;; (define-key cweb-mode-map [C-pause] 'revert-buffer-no-query)

  
  ;; LDF 2002.12.13.  These are for recompiling and running 3DLDF for
  ;; the various platforms.

  ;; Control-Keypad-1
;;   (define-key cweb-mode-map [C-kp-end] '(lambda () (interactive)
;; 					  (run-cmpl 0))) ;; DEC

  (define-key cweb-mode-map [C-kp-1] 'cweb-literal-c)
  (define-key cweb-mode-map [C-kp-2] 'cweb-bison-symbol)
  (define-key cweb-mode-map [C-kp-down] 'cweb-bison-symbol)


  (define-key cweb-mode-map [C-kp-end] 'cweb-literal-c)

;;   ;; Control-Keypad-2
;;   (define-key cweb-mode-map [C-kp-down] '(lambda () (interactive)
;; 					  (run-cmpl 1)))   ;; LINUX

;;   (define-key cweb-mode-map [C-kp-2] '(lambda () (interactive)
;; 					  (run-cmpl 1)))   ;; LINUX
;;   ;; Control-Keypad-3
;;   (define-key cweb-mode-map [C-kp-next] '(lambda () (interactive)
;; 					  (run-cmpl 2)));  FREEBSD

;;   (define-key cweb-mode-map [C-kp-3] '(lambda () (interactive)
;; 					  (run-cmpl 2)));  FREEBSD

  (define-key cweb-mode-map [C-kp-multiply] 'insert-buffer)

  (define-key cweb-mode-map [C-kp-divide] 'erase-buffer)

;; Control-Keypad-4

  (define-key cweb-mode-map [C-kp-left] 'ediff-buffers)
  (define-key cweb-mode-map [C-kp-begin] 'ediff-buffers)					 


;; Control-Keypad-5
			
(define-key cweb-mode-map [C-kp-5] 'ediff-directories)
(define-key cweb-mode-map [C-kp-begin] 'ediff-directories)

;; Control-Keypad-6

(define-key cweb-mode-map [C-kp-6] 'query-replace-regexp)
(define-key cweb-mode-map [C-kp-end] 'query-replace-regexp)
	  
;; Control-Keypad-7
  (define-key cweb-mode-map [C-kp-home] 'cweb-include)
  (define-key cweb-mode-map [C-kp-7] 'cweb-include)

;; Control-Keypad-8
  (define-key cweb-mode-map [C-kp-up] 'cweb-uninclude)
  (define-key cweb-mode-map [C-kp-8] 'cweb-uninclude)

;;   ;; Control-Keypad-9
;;   (define-key cweb-mode-map [C-kp-prior] '(lambda () (interactive)
;; 					  (mp-file 2))) ;;  FREEBSD

;;   (define-key cweb-mode-map [C-kp-9] '(lambda () (interactive)
;; 					  (mp-file 2))) ;;  FREEBSD
  



  ;; LDF 2002.12.13.  These are for recompiling 3dldf.


;; These are temporary.


				 
;; (define-key cweb-mode-map [f14] '(lambda () (interactive)
;; 				     (search-forward "//")    
;; 				     (backward-char 2)
;; 				     (delete-char 2)
;; 				     (insert "/* ")
;; 				     ))

  ;; Key definitions using C (Control)
  (define-key cweb-mode-map [67108905] 'blink-matching-open)

  ;; Key definitions using C-c
  
;; LDF 2002.4.7.
;; For some reason, C-c" doesn't work, at least not when I'm
;; on the gwdu70 by means of ssh from the Linux terminal.
;; Therefore, I'm using C-c' to put in double quotes.  But I'm not 
;; happy about it.
(define-key cweb-mode-map "\C-c\'" 'put-in-normal-quotes)

(define-key cweb-mode-map "\C-c$" 'dollars)
(define-key cweb-mode-map "\C-c<" 'angle-braces)
(define-key cweb-mode-map "\C-c=" 'equal-sign)
  

   (define-key cweb-mode-map "\C-cb" 'begin-comment)
  
  ;; These are for the terminals in the Skandinavian dept., where the
  ;; umlauted letters on the keyboard don't work.
  (define-key cweb-mode-map "\C-ca" 'a-umlaut)
  (define-key cweb-mode-map "\C-co" 'o-umlaut)
  (define-key cweb-mode-map "\C-cu" 'u-umlaut)
  (define-key cweb-mode-map "\C-cA" 'A-umlaut)
  (define-key cweb-mode-map "\C-cO" 'O-umlaut)
  (define-key cweb-mode-map "\C-cU" 'U-umlaut)
  (define-key cweb-mode-map "\C-cs" 'scharf-s)

  ;; Key definitions with C-c   Be careful that I don't redefine keys for the
  ;; German letters above!
  (define-key cweb-mode-map "\C-cf" 'file-section-cweb)	 
  (define-key cweb-mode-map "\C-ct" 'ctangle)	 
  (define-key cweb-mode-map "\C-cw" 'cweave)

  (define-key cweb-mode-map "\C-cp" 'c++-cerr)
				     ;; 'c-make-printf))	 
  (define-key cweb-mode-map "\C-cq"  'put-in-tex-quotes)
  (define-key cweb-mode-map "\C-c." 'ldots)
  (define-key cweb-mode-map "\C-c," 'tt-cweb)
  (define-key cweb-mode-map "\C-c(" 'make-parentheses)
  (define-key cweb-mode-map "\C-c[" 'square-brackets)
  (define-key cweb-mode-map "\C-c{" 'curly-braces)


  ;; sets C-c TAB to indent-region.
  (define-key cweb-mode-map [3 9] 'indent-region)

  ;; Key definitions using C-x
  ;; C-xa definitions below.
  (define-key cweb-mode-map "\C-xm" 'my-compile)
  ;; C-xn definitions below.
  ;; 
  (define-key cweb-mode-map "\C-xp" 'c++-cerr-this-is)
				      ;; 'printf-this-is))
  (define-key cweb-mode-map "\C-xq" 'comment-cweb)
  (define-key cweb-mode-map "\C-x<" 'section-title-cweb)

  ;; Key definitions using C-x C-<something>
  (define-key cweb-mode-map "\C-x\C-a" 'capitalize-region)

  ;; Key definitions using C-xa
  (define-key cweb-mode-map "\C-xac" 'copyright-symbol)
  (define-key cweb-mode-map "\C-xaf" 'filename)

  ;; Key definitions using C-xn
  (define-key cweb-mode-map "\C-xnf" 'footnote)
  (define-key cweb-mode-map "\C-xnm" 'simple-tex-macro) ; For Skand. Sem.
  ;;
  ;; These rebind the umlauted characters to self-insert-command.
  ;;
  ;; ä
  (define-key cweb-mode-map [228] 'self-insert-command)
  ;; Ä
  (define-key cweb-mode-map [196] 'self-insert-command)
  ;; ö		
  (define-key cweb-mode-map [246] 'self-insert-command)
  ;; Ö
  (define-key cweb-mode-map [214] 'self-insert-command)
  ;; ü
  (define-key cweb-mode-map [252] 'self-insert-command)
  ;; Ü (U-umlaut)
  (define-key cweb-mode-map [220] 'self-insert-command)
  ;; ß
  (define-key cweb-mode-map [223] 'self-insert-command)

  (define-key cweb-mode-map [40] 'self-insert-command)
  (define-key cweb-mode-map [41] 'self-insert-command)

  (define-key cweb-mode-map [59] 'self-insert-command)

  (define-key cweb-mode-map [menu] 'transient-mark-mode)
  
  ;; (define-key cweb-mode-map [S-kp-end] 'write-function)  ;; Num. pad 1
  ;; (define-key cweb-mode-map [S-kp-1] 'write-function)
  ;; (define-key cweb-mode-map [S-kp-down] 'write-variable)  ;; Num. pad 2
  ;; (define-key cweb-mode-map [S-kp-2] 'write-variable)

  ;;
  ;; These are for my menu-bar.
  ;;
  (define-key cweb-mode-map [menu-bar] (make-sparse-keymap))
  (define-key cweb-mode-map [menu-bar cweb]
  (cons "CWEB" (make-sparse-keymap "CWEB")))
  (define-key cweb-mode-map [menu-bar cweb comment]
    '("Comment" . comment-cweb))
  (define-key cweb-mode-map [menu-bar cweb ctangle]
    '("ctangle" . ctangle))
  (define-key cweb-mode-map [menu-bar cweb cweave]
    '("cweave" . cweave))
  )

(defun cweb-mode ()
  "Major mode for editing CWEB programs.
Special commands:
\\{cweb-mode-map}
Turning on CWEB mode calls the value of the variable `cweb-mode-hook',
if that value is non-nil."
  (interactive)
  (kill-all-local-variables)
  (use-local-map cweb-mode-map)
  (setq mode-name "CWEB")
  (setq major-mode 'cweb-mode)
  (setq local-abbrev-table cweb-mode-abbrev-table)
  (set-syntax-table cweb-mode-syntax-table)
  (make-local-variable 'comment-start)
  (make-local-variable 'comment-end)
  (setq comment-start "/* ")
  (setq comment-end " */")
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'c-indent-line-or-region)
  (run-hooks 'cweb-mode-hook)
  ;;(setq outline-regexp "\@q *\\*+\\|\@\\*[0-9]*")
  (setq outline-regexp "\@q *\\*+")
  (setq indent-tabs-mode nil)
  )  ;; Matches defun cweb-mode.






;;; cweb-mode.el ends here






;; Local Variables:
;; mode:Emacs-Lisp
;; End:
