;; tex-functions.el
;; Created by Laurence D. Finston (LDF).

;; * Copyright and License.

;; This file is part of songlist, a package for keeping track of songs. 
;; Copyright (C) 2021, 2022, 2023 Laurence D. Finston 

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

;; This is the general delimiter function that is called by 
;; tex-insert-braces, and the other specific delimiter functions.
;; It is autoloaded, because functions in el-tex-functions.el call it.

(defun tgdf 
  (beg-delim end-delim prompt-string arg)
  "tgdf is the general delimiter function 
that is called by tex-insert-braces, and the other 
specific delimiter functions.
Also called by el-tex functions. If I type <RET> in order to put in the 
string by hand, it returns the string, otherwise it returns nil.
Changed 11/24/97. Now it's possible to have the arg be a string, for
calling non-interactively. Used in umlaut. The documentation for functions
that use this function have not been changed to reflect this fact."
  (let ((end-delim-length (length end-delim)))
    (cond 
     ;; no argument
     ((eq arg nil) 
      (progn
	(let (a)
	  (setq a (read-string prompt-string))
	  (insert beg-delim a)
	  (push-mark (point) t)
	  (insert end-delim)
	  (if (string= a "")
	      (progn
		(push-mark (point) t)
		(backward-char end-delim-length)
                ;; This is a kludge for the functions italics and 
		;; old-norse
                (if (not (or (string= beg-delim "{\\ON ")
			(string= beg-delim "{\\it ")))
                (progn
		  (message "mark set after closing delimiter")
		  (sit-for 1)
		  (message nil))))
		
	    ;; else
	    (ignore))
	  (identity a)
	  )))
     ;; argument unspecified
     ((listp arg)
      (progn
	(insert beg-delim end-delim)
	(backward-char end-delim-length)
	(yank)
	(forward-char end-delim-length)))
     ;; argument -
     ((symbolp arg)
      (progn
	(insert beg-delim end-delim)
	(backward-char end-delim-length)
	(let (here there a b c)
	  (setq here (point))
	  (setq b nil)
	  (setq c 2)
	  (yank)
	  (setq there (point))
	  (while (eq b nil)
	    (setq a
      (y-or-n-p "Type \"y\" to cycle through kill ring or \"n\" to exit: "))
	    (cond
	     ((eq a t)
	      (progn
		(delete-region here there)
		(yank c)
		(setq there (point))
		(1+ c)))
	     ((eq a nil)
	      (progn
		(setq b t)
		(message nil)
		(forward-char end-delim-length)))
	     (t
	      (progn
		(message "Invalid response.")
		(sit-for 1))))))))
     ;; argument integer
     ((integerp arg)
      (progn
	(insert beg-delim end-delim)
	(backward-char end-delim-length)
	(yank arg)
	(forward-char end-delim-length)
	))
     ((stringp arg)
      (insert beg-delim arg end-delim))
     ;; Any other argument. (not possible).
     (t (message "Invalid argument"))
     ) ;; cond
    ) ;; let
  
  ) ;; defun tgdf
  


;; This is like tex-insert-braces except that it gets the text from the
;; minibuffer and puts the cursor after the closing brace. 
;; It works for both tex files and el files
;; that write tex files:
    
(defun tex-insert-braces (arg)
"tex-insert-braces inserts {} and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "{" "}" "What goes between the braces? " arg))


;; ***********************************

;; LDF 2004.03.17.
;; Added `insert-single_quotes'.  

;; LDF 2005.05.08.  Changed this defun so that '' is used instead of `'.

;; LDF 2005.08.19.
;; Now using `' instead of '' again.  This is due to a decision
;; by the GNU Project.


(defun insert-single-quotes (arg)
  "insert-single-quotes inserts \"`'\" and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "`" "'" "What goes inside the single quotes? " arg))


;; ***********************************

;; Changed to use * * rather than \begincomment and \end~. Just switch
;; the lines that are commented out to change back.
(defun begin-comment (arg)
"begin-comment inserts 
;;\\begincomment{ and }\\n\\endcomment 
* *
and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (tgdf
;;       "\\\\begincomment{" "}\\\\endcomment "
         "*" "*"
       "What's your comment? " arg)
    ;; else
    (tgdf
;;     "\\begincomment{" "}\\endcomment "
         "*" "*"
     "What's your comment? " arg)))


(defun begin-commentary (arg)
"begin-commentary inserts code for commentaries.  
It puts \\BC and \\EC on two separate lines, puts the cursor on a
blank line between them and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
      (tgdf
       "\\BC\n" "\n\\EC\n"
       "What's your commentary? " arg)
)



;;;; This function makes {\sc{}} 
;;;; for small caps for tex files
;;;; and {\\sc{}} for el-tex files.
;;;; and is set to C-c v

(defun small-caps (arg)
"small-caps inserts {\\sc } and prompts for a string to put inside.
It works for tex and el-tex files and inserts \\\\ for the latter.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      
      (tgdf "{\\\\sc " "}"
					 "What should be in small caps? " arg)
    ;;else
    (tgdf "{\\sc " "}"
				     "What should be in small caps? " arg)))


(defun tt (arg)
  "tt inserts {\\tt } and prompts for a string to put inside.
It works for tex and el-tex files and inserts \\\\ for the latter.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (let (tt-string)
    (cond ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
	   (setq tt-string "{\\\\tt ")
	   )
	  ((string= mode-name "CWEB")
	   (setq tt-string "\\.{"))
	  ((string= mode-name "Texinfo")
	   (setq tt-string "@t{"))
	  (t
	   (setq tt-string "{\\tt "))
	  ) ;; Matches cond.

    (tgdf tt-string "}"
	  "What should be in typewriter font? " arg)
    ;; Matches let
    )
  ;; Matches tt
  )


(defun bold-face (arg)
  "bold-face inserts code for bold-face type.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (let (pre-string post-string)
    (cond ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
	   (setq bold-face-string "{\\\\bf ")
	   (setq pre-string "{\\\\bf ")
	   (setq post-string "}")
	   )
	  	  ((string= mode-name "HTML")
	   (setq pre-string "<b>")
	   (setq post-string "</b>"))
	  (t
	   (setq pre-string "{\\bf ")
	   (setq post-string "}")
	   )
	  )
    (tgdf pre-string post-string "What should be in bold face? " arg)
    ;; Matches let
    )
  ;; Matches bold-face
  )


;;;; This works for both el-tex and tex files:
(defun put-in-tex-quotes (arg)
  "put-in-tex-quotes inserts ``'' and prompts for a string to put inside.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "``" "''"
				     "What should be in Tex quotes? " arg))

(defun german-tex-quotes (arg)
  "german-tex-quotes inserts \"`\"' and prompts for a string to put inside.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "\"`" "\"'"
				     "What should be in German quotes? " arg))


;;;; This works for both el-tex and tex files:

(defun square-brackets (arg)
"square-bracets inserts [] and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "[" "]" 
				     "What goes between the square brackets? " 
				     arg))

;; This works for both tex and el-tex:

(defun make-parentheses (arg)
  "make-parentheses-tex inserts \(\) and prompts for a string to put between them.
It works for tex and el-tex files. For the latter, it inserts \\(\\).
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (tgdf "\\(" "\\)"
				     "What goes between the parentheses? "
				     arg)
    ;; else
    (tgdf "\(" "\)"
				       "What goes between the parentheses? "
				       arg)))



;; This works for both tex and el-tex:

(defun dollar-signs (arg)
  "dollar-signs inserts $$ and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "$" "$"
				     "What goes between the dollar signs? "
				     arg))


;;;; This gets text from the minibuffer and puts it
;;;; inside of "{\}", and then put the cursor after the 
;;;; backslash. Set to C-c m in tex-mode:

;;; ******************************
		     
;; This queries the user and enters the appropriate text for a tex-macro.	     
(defun simple-tex-macro ()
  "simple-tex-macro puts in the code for a tex macro inside {}.
It sets the mark at point before doing so. It queries for a string or <RET>.
If <RET> is entered, or the string ends in a <SPACE>, 
point is left between the curly braces and mark is set after the closing curly
brace. Otherwise, point is left after the closing brace."
  (interactive)
  (let (macro-string backslashes mode counter)
    (if (or (string= mode-name "Lisp")
	    (string= mode-name "Emacs-Lisp"))
	(progn
	  (setq mode t)
	  (setq backslashes "\\\\"))
      ;; else
      (progn
	(setq mode nil)
	(setq backslashes "\\")))
    (setq macro-string
	  (read-string "Enter a string or <RET> to enter by hand: "))
    (set-mark-command nil)
    ;; This gets the last char out of macro-string
    (setq counter (length macro-string))
    (if (not (eq counter 0))
	(setq counter (substring macro-string (- counter 1) counter)))
    (insert "{" backslashes macro-string "}")
    (if (or (string= macro-string "") (string= counter " "))
	(progn
	  (set-mark-command nil)
	  (backward-char 1)
	  (message "Mark set after closing }")
	  (sit-for 2)
	  (message nil)
	  )
      )

    ;; Matches let
    )
  ;; Matches defun
  )
    
;;; ******************************

(defun setup-tex-macro ()
  (interactive)
  (message "setup-tex-macro is currently indisposed")
  (sit-for 2)
  (message nil)
)

	
(defun tex-macro-args (&optional empty)
  "tex-macro-args queries for arguments for tex macros."
  (interactive)
  (let (response query-string here)
    (setq query-string
 "Enter an argument \(a string\), - for an empty one, or <RET> to quit: ")
    (setq response (read-string query-string))
    (cond ((string= response "")
	   nil)
	  ((string= response "-")
	   (insert "{")
	   (if (and (not here) (not empty))
	       (setq here (point)))
	   (insert "}")
	   (message "Do you want more arguments?")
	   (sit-for 1.5)
	   (if here
	       (tex-macro-args t)
	     ;; else
	     (tex-macro-args))
	   )
	  (t
	   (insert "{" response "}")
	   (message "Do you want more arguments?")
	   (sit-for 1.5)
	   (tex-macro-args)
	   ;; Matches t
	   )
	  ;; Matches cond
	  )
    (if here
	(progn
	  (message "Do you want to fill the empty argument?")
	  (sit-for 1.5)
	  (setq response (read-string "Enter <RET> for no, any other char for yes: "))
	  (if (not (equal response ""))
	      (goto-char here))))
	  
	  
    ;; Matches let
    )
  ;; Matches defun tex-macro-args
  )

(defun tex-macro-with-args ()
  "tex-macro-with-args puts in a tex-macro without braces and queries for
macro arguments, which it surrounds with braces."
  (interactive)
  (let (response)
    (setq response (read-string "What's your macro? "))
    (insert "\\" response)
    (tex-macro-args)
    ;; Matches let
    )
  ;; Matches defun tex-macro-with-args
  )

(defun putontop ()
"Prompts for letters to be put on top of one another.
Works for tex and el-tex."
  (interactive)
  (let (a b (backslashes
	     (if (or (string= mode-name "Emacs-Lisp")
		     (string= mode-name "Lisp"))
		 "\\\\" "\\"))
	  ;; Matches let-argument
	  )
    (setq a
	  (read-string "What goes underneath? or type <RET> to type in by hand: "))
    (if (equal a "")
	(progn
	  (insert backslashes "putontop{}{}{}{}{}")
	  (backward-char 9)
	  )
      ;; else
      (progn 
	(setq b (read-string "Okay. What goes on top? "))
	(insert backslashes "putontop{" a "}{" b "}{}{}{}")
	)
      ;; Matches if
      )
    ;; Matches let
    )
  ;; Matches defun putontop
  )







(defun overstroke ()
"Prompts for string, puts an overstroke over it.
For tex and el-tex."
  (interactive)
  (let (a)
    (setq a (read-string "What has an overstroke? or type <RET> \
to type in by hand: "))
    (insert "{\\")
    (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
	(insert "\\"))
    (insert "overstroke")
    (if (not (string= a ""))
	(insert (concat "{" a "}}"))
      ;; else
      (progn 
	(insert "{}}")
	(backward-char 2)))))

;;;; **********************************************************************


(defun upcircle (arg)
  "Makes an upcircle."
  (interactive "P")
  (let (a backslashes)
    (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
	(setq backslashes "\\\\")
      (setq backslashes "\\"))
    (tgdf (concat backslashes "upcircle{") 
				    "}{}{}{}"
				    "What needs an upcircle? "
				    arg)
    ;; Matches let
    )
  ;; Matches defun
  )

(defun decor (arg)
  "decor prompts for a string and makes it the argument of the tex macro decor.
It works for tex and el-tex.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (tgdf "{\\\\decor " "}" "What should be decorative? " arg)
    ;; else
    (tgdf "{\\decor " "}" "What should be decorative? " arg)))

(defun italics (arg)
  "italics prompts for a string and makes it the argument of the tex macro it.
It works for tex and el-tex files.
It also queries for adding the italic correction.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the argth item from the kill ring. 
Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (let (a return-value)
    (cond
     ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (setq return-value
	    (tgdf
	     "{\\\\it " "}" "What should be in italics? " arg))
      )
     (t
      (setq return-value
	    (tgdf
	     "{\\it " "}" "What should be in italics? " arg))))
    ;; This queries for the italic correction
    (setq a (y-or-n-p "Do you want the italic correction? "))
    (message nil)
    (if (eq a t)
	(progn
	  ;; This is if I typed return to enter the string by hand,
	  ;; which causes tgdf to
	  ;; do a (backward-char 1), so I don't want to do one here.
	  (if (not (string= return-value ""))
	      (backward-char 1)
	    )
	  (insert (if (or (string= mode-name "Emacs-Lisp")
			  (string= mode-name "Lisp"))
		      "\\\\/"
		    ;; else
		    "\\/"))
	  (if (not (string= return-value ""))
	  (forward-char 1)
	  ;; else
	  (progn
	    (backward-char (if (or (string= mode-name "Emacs-Lisp")
				   (string= mode-name "Lisp"))
			       3 2))
	    (message "mark set after closing delimiter.")
	    (sit-for 1.5)
	    (message nil)
	    ) ;; Matches else progn
	  ) ;; Matches if


	  ) 	  ;; Matches progn

      ;; else
      ;; (message "It's not return, not adding the italic correction.")
      ;; Matches if
      )
    ;; Matches let
    )
  ;; Matches defun italics
  )

;; (local-set-key [f8] 'italics)



(defun umlaut (arg)
  "Prompts for character \(actually a string\) to be umlauted. 
Inserts {\\\"<arg>}.
For tex files.
umlaut behaves differently, depending on the prefix 
argument.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P") 
  (cond
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (tgdf "{\\\\\\\"" "}"
				     "What needs an umlaut? "
				     arg))
   (t
    (tgdf "{\\\"" "}"
				     "What needs an umlaut? "
				     arg))))

(defun circumflex (arg)
  "Prompts for character \(actually a string\) to be circumflexed. 
Inserts {\\\"<arg>}.
For tex files.
circumflex behaves differently, depending on the prefix 
argument.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P") 
  (cond
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (tgdf "{\\\\\\\\^" "}"
				     "What needs an circumflex? "
				     arg))
   (t
    (tgdf "{\\^" "}"
				     "What needs an circumflex? "
				     arg))))
  



(defun make-tex-message (arg)
  "Prompts for a string and inserts \\message{<arg>}.
For tex files.
make-tex-message behaves differently, depending on the prefix 
argument.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P") 
  (tgdf "\\message{" "}"
				     "What's your message? "
				     arg))

(defun make-tex-show (arg)
  "Prompts for a string and inserts \\show{<arg>}.
For tex files.
make-tex-show behaves differently, depending on the prefix 
argument.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P") 
  (tgdf "\\show\\" " "
				     "What should I show? "
				     arg))
(defun make-tex-showthe (arg)
  "Prompts for a string and inserts \\showthe\\<arg>.
For tex files.
make-tex-showthe behaves differently, depending on the prefix 
argument.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P") 
  (tgdf "\\showthe\\" " "
				     "What \\the should I show? "
				     arg))


(defun begin-division (arg)
  "begin-division queries the user and enters the necessary text for
a division, like \\beginchapter{}{}{}, \\beginsection{}{}{} etc.
For tex files."
 (interactive "P") 
 (let (a query-string) 
   (setq a
	 (read-string
	  "What should I begin? Type a string or ? for info. "))
   (cond ((string= a "?")
	  (progn
	    (message "Type c, s, ss, or sss. See help for more info")
	    (sit-for 1)
	    (begin-division nil)))
	 ((string= a (or "c" "C"))
	  (progn
	    (insert "\\beginchapter")
	    (setq a "chapter")))
	 ((string= a (or "s" "S"))
	  (progn
	    (insert "\\beginsection")
	    (setq a "section")))
	 ((string= a (or "ss" "SS")) 
	  (progn
	    (insert "\\beginsubsection")
	    (setq a "subsection")))
	 ((string= a (or "sss" "SSS"))
	  (progn
	    (insert "\\beginsubsubsection")
	    (setq a "subsubsection")))
	 (t (progn
	      (message "Invalid entry")
	      (sit-for 1)
	      (begin-division nil))))
	 (setq query-string (concat "What's the name of your " a "? "))
	 (tgdf "{" "}{}{}" query-string arg)
	 (message "Enter additional arguments by hand.")
	 (sit-for 2)
))


(defun fnote (arg)
  "Prompts for a string and inserts \\fnote{<arg>}.
Changed for use with my miracle translation. It used to insert
\\fnote{*}{<arg>} or \\\\fnote{}{<arg>}. This was for the old Mariu stuff.
Can be changed back, if necessary.
fnote-tex behaves differently, depending on the prefix 
argument.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
    (tgdf "\\fnote{" "}" "What goes in the fnote? " arg)
    )   

(defun ufnote (arg)
  "Prompts for a string and inserts \\ufnote{<int>}{}.
Used for my Marienmirakel. For Unger's footnotes."
  (interactive "P")
  (if (not unger-ctr)
   (setq unger-ctr 0)
   )
  (cond ((eq arg nil)
	 (setq unger-ctr (+ unger-ctr 1)))
	((listp arg)
	 (setq unger-ctr 1))
	((symbolp arg)
	 (setq unger-ctr
	       (string-to-int
		(read-string "What number Unger footnote? "))))
	)
    (insert "\\ufnote{" (int-to-string unger-ctr) "}{}")

    
)


(defun footnote (arg)
  "Prompts for a string and inserts \\footnote{}{<arg>}.
For tex files and el-tex files.
footnote-tex behaves differently, depending on the prefix 
argument.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, 
it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (let ((backslashes 
	 (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
	     "\\\\" "\\")))
    (tgdf (concat backslashes "footnote{}{") "}"
				    "What goes in the footnote? "
				    arg)
    (message "Add other arguments by hand, if needed.")
    (sit-for 1.5)
    )
  ) ;; Matches defun footnote




;(defun fnote (arg)
;  "Prompts for a string and inserts \\fnote{<arg>}{} or \\\\fnote{<arg>}{}.
;For tex files and el-tex files.
;fnote-tex behaves differently, depending on the prefix 
;argument.
;If the user types <RET> without entering a string, it leaves point between the 
;delimiters. Otherwise, it leaves point outside the delimiters.
;With an unspecified prefix, just C-u, it inserts the last kill and then 
;leaves point outside the delimiters. With an integer prefix arg, 
;it inserts the 
;argth item from the kill ring. Negative integers are also allowed. With the
;argument -, \(a dash\), it inserts the last kill, leaves point between the 
;delimiters and prompts the user to cycle through the kill ring or exit."
;  (interactive "P")
;  (let ((backslashes 
;	 (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
;	     "\\\\" "\\")))
;    (tgdf (concat backslashes "fnote{}{") "}{}"
;				    "What goes in the fnote? "
;				    arg)
;    (message "Add other arguments by hand, if needed.")
;    (sit-for 1.5)
;    )
;  )



(defun marginal-note (arg)
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (tgdf "\\\\marginalnote{" "}"
					 "What goes in the marginalnote? "
					 arg)
    ;; else
    (tgdf "\\marginalnote{" "}"
				       "What goes in the marginalnote? "
				       arg)))

(defun index-entry ()
  "index-entry puts in text for \\indexentry{}{}{}{}{}{} or \\\\indexentry{}{}{}{}{}{} and queries for arguments.
For tex and el-tex."
  (interactive)
  (let (a by-hand-flag
	  (backslashes (if (or (string= mode-name "Emacs-Lisp")
			       (string= mode-name "Emacs-Lisp"))
			   "\\\\" "\\")))
    (catch 'get-me-out-of-here
      (message "What name do you want? ")
      (sit-for 1)
      (setq a
	    (read-string "Enter a string or <RET> to enter by hand: "))
      (if (string= a "")
	  (progn
	    (setq by-hand-flag t)
	    (message "Okay, you'll have to enter name by hand.")
	    (sit-for 1)))
      (insert backslashes "indexentry{" a)
      (set-mark-command nil)
      (insert "}")
      (setq a
	    (read-string "Enter Text or <RET> for nil or % to end now: "))
      (if (string= a "%")
	  (progn
	    (message "Okay, the other args are all empty")
	    (insert "{}{}{}{}{}")
	    (if (eq by-hand-flag t)
		(progn
		  (message
		   (concat 
		    "Enter name by hand. Mark is set at end of " backslashes
		    "indexentry"))
	      (exchange-point-and-mark)))
	    (throw 'get-me-out-of-here t)
	    )
	)
      (insert (concat "{" a "}"))
      (setq a
	    (read-string
	     "Enter string to suppress page no or <RET> for nil or % to end now: "))
      (if (string= a "%")
	  (progn
	    (message "Okay, the other args are all empty")
	    (insert "{}{}{}{}")
	    (if (eq by-hand-flag t)
		(progn
		  (message
		   (concat 
		    "Enter name by hand. Mark is set at end of " backslashes
		    "indexentry"))
	      (exchange-point-and-mark)))
	    (throw 'get-me-out-of-here t)
	    )
	)
      (if (not (string= a ""))
	  (setq a "np"))
      (insert (concat "{" a "}"))
      (setq a
	    (read-string "Enter string for crossref or <RET> for nil or % to end now: "))
      (if (string= a "%")
	  (progn
	    (message "Okay, the other args are all empty")
	    (insert "{}{}{}")
	    (if (eq by-hand-flag t)
		(progn
		  (message
		   (concat 
		    "Enter name by hand. Mark is set at end of " backslashes
		    "indexentry"))
	      (exchange-point-and-mark)))
	    (throw 'get-me-out-of-here t)
	    )
	)
      (insert (concat "{" a "}"))
      (setq a
	    (read-string
   "Enter heading, if entry is sub- or subsubheading: or % to end now: "))
      (if (string= a "%")
	  (progn
	    (message "Okay, the other args are all empty")
	    (insert "{}{}")
	    (if (eq by-hand-flag t)
		(progn
		  (exchange-point-and-mark)
		  (message
		   (concat 
		    "Enter name by hand. Mark is set at end of " backslashes
		    "indexentry")))
		  )
	    (throw 'get-me-out-of-here t)
	    )
	)
      (insert (concat "{" a "}"))
      (setq a
	    (read-string "Enter subheading, if entry is subsubheading: "))
      (insert (concat "{" a "}"))
      (if (eq by-hand-flag t)
	  (progn
	    (message
	     (concat 
	      "Enter name by hand. Mark is set at end of " backslashes
	      "indexentry"))
	    (exchange-point-and-mark)))
      ;; Matches catch 'get-me-out-of-here
      )
    ;; Matches let
    )
  ;; Matches defun index-entry
  )

(defun tex-def (arg)
  "tex-def writes the code needed for defining a tex macro.
It only works for tex-mode, since there's no need to write definitions 
in el-tex files. I can change this, if necessary.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it 
inserts the argth item from the kill ring. Negative integers are 
also allowed. With the argument -, \(a dash\), it inserts the last kill, 
leaves point between the delimiters and prompts the user to cycle 
through the kill ring or exit."
  (interactive "P")
  (let (a)
    (insert "\\def\\")
    (setq a (point))
    (tgdf "" ""
				       "What's the name of the def? "
				       arg)
    (if (> (point) a)
	(setq a t)
      ;; else
      (setq a nil)) 
    (insert "{%\n\n}\n")
    (previous-line 2)
    (if (eq a nil)
	(progn
	  (previous-line 1)
	  (forward-char 5)))))

(defun uncial ()
  "uncial makes uncials for tex and el-tex files.
If the argument belongs to the list of letters for which I've programmed
uncial forms, then the macros for these forms are inserted. Otherwise, the
letter with a superscript, italic \"uncial\". Remember to update list of
letters for which I've programmed uncial forms!" 
  (interactive)
  (let (a
	(backslashes
	 (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
	     "\\\\"
	   ;; else
	   "\\"))
	;; Matches let arg list
	)
    (setq a (read-string "What should be an uncial? "))
    (if (or (string= a "a") (string= a "m") )
	(progn
	(insert "{")
	(insert backslashes)
	(insert "uncial")
	(insert a)
	(insert "}"))
      ;; else
      (insert a "$^{" backslashes "it uncial}$" )
      ;; Matches if
      )
    ;; Matches let
    )
  ;; Matches defun uncial
  )

(defun write-tex ()
  "write-tex simply writes the macro {\\TeX} or {\\\\TeX}, depending on mode."
  (interactive)
  (if (or (string= mode-name "Lisp") (string= mode-name "Emacs-Lisp"))
      (insert "{\\\\TeX}")
    ;; else
    (insert "{\\TeX}")))

(defun write-latex ()
  "write-latex simply writes the macro {\\LaTeX} or {\\\\LaTeX}, depending on mode."
  (interactive)
  (if (or (string= mode-name "Lisp") (string= mode-name "Emacs-Lisp"))
      (insert "{\\\\LaTeX}")
    ;; else
    (insert "{\\LaTeX}")))

(defun write-mf ()
  "write-mf simply writes the macro {\\MF} or {\\\\MF}, depending on mode."
  (interactive)
  (if (or (string= mode-name "Lisp") (string= mode-name "Emacs-Lisp"))
      (insert "{\\\\MF}")
    ;; else
    (insert "{\\MF}")))


(defun run-mar ()
  "run-mar is for the files in ~/skand/paleo. It calls the shell script run_mar"
  (interactive)
  (let ((this-buffer (get-buffer (current-buffer))))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "run-mar-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*run-mar-shell*")
    (insert "clear")
    (comint-send-input)
    (insert "run_mar")
    (comint-send-input)
    (insert "\n")
    (comint-send-input)
    (switch-to-buffer-other-window "*run-mar-shell*")
    (switch-to-buffer-other-window this-buffer)
    )
  )

(defun verbatim (arg &optional macro)
"verbatim inserts code for a verbatim display and queries for a string.
It's used for my TUGboat articles.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
    (interactive "P")
    (if (string= mode-name "CWEB")
	(tgdf
	 "©" "©"
	 "What should be verbatim? " arg)
      ;; else
      (tgdf "%\n\\verbatim\n" "\n\\endverbatim\n%\n"
				      "What should be verbatim? " arg)
      ) ;; Matches if
  ;; Matches defun verbatim
  )



;; This is an old version.

;;(defun verbatim (arg &optional macro)
;;  "verbatim queries for arguments and inserts code for verbatim text.
;;It functions differently depending on the prefix argument.
;;With an unspecified prefix, just C-u, it inserts the last kill and then 
;;leaves point outside the delimiters. With an integer prefix arg, it 
;;inserts the argth item from the kill ring. Negative integers are 
;;also allowed. The argument -, \(a dash\) is for verbatim TeX macros.
;;If the buffer-local variable \(in vars.el\) is t, then þ is used as 
;;\\verbatimescapechar, otherwise |. See $PALEO/articles/outline.tex for
;;an example."
;;  (interactive "P")
;;  (let (a b message-string
;;	  (end-verbatim-char "\\")
;;	  ;;(end-verbatim-char "|")
;;	  (backslashes 
;;	   (if (or (string= mode-name "Emacs-Lisp")
;;		   (string= mode-name "Lisp"))
;;	       "\\\\" "\\")))
;;    (cond
;;     ((eq arg nil)
;;      (if macro
;;	  (setq message-string "What macro should be verbatim? ")
;;	;; else
;;	  (setq message-string "What should be verbatim? "))
;;      (setq a (read-string message-string)))
;;     ((listp arg)
;;      (setq a (car kill-ring)))
;;     ((symbolp arg)
;;      (setq message-string "What macro should be verbatim? ")
;;      (setq a (read-string message-string))
;;      (setq macro t)
;;      )
;;     ((integerp arg)
;;      (setq a (nth arg kill-ring)))
;;     ;; This can't happen.
;;     (t (message "Invalid prefix argument to verbatim."))
;;     ;; Matches cond
;;     )
;;    (cond
;;     ((eq a nil)
;;       (ignore)
;;       )
;;     ((string= a "")
;;      (insert backslashes "verbatim")
;;      (if macro (insert backslashes))
;;      (set-mark (point))
;;      (insert end-verbatim-char "endverbatim")
;;      (exchange-point-and-mark)
;;      (setq message-string
;;	    (concat
;;	     "Enter text by hand. Mark is after \""
;;	     end-verbatim-char "endverbatim\""))
;;      (message message-string)
;;      (sit-for 2)
;;      (message nil)
;;      )
;;     (t
;;      (insert backslashes "verbatim")
;;      (if macro
;;	  (insert backslashes)
;;	;; else
;;	(progn
;;	  (setq b (string-to-char (substring a 0 1)))
;;	  (if 
;;	      (or
;;	       (and (>= b ?A) (<= b ?Z))
;;	       (and (>= b ?a) (<= b ?z)))
;;	      (insert " "))))
;;      (insert a end-verbatim-char "endverbatim")
;;      )
;;     ;; Matches cond
;;     )
;;    ;; This returns a as the value of the function verbatim.
;;    (identity a)
;;    ;; Matches let
;;    )
;;  ;; Matches defun verbatim
;;  )


(defun verbatim-macro (arg)
  "verbatim-macro calls verbatim for a TeX macro"
  (interactive "P")
  (verbatim arg t))



(defun verbinline (arg &optional macro)
  "verbinline is like verbatim.
It's for my Tugboat articles.
queries for arguments and inserts code for verbinline text.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it 
inserts the argth item from the kill ring. Negative integers are 
also allowed. The argument -, \(a dash\) is for verbinline TeX macros.
If the buffer-local variable \(in vars.el\) is t, then þ is used as 
\\verbinlineescapechar, otherwise |. See $PALEO/articles/outline.tex for
an example."
  (interactive "P")
  (let (a b message-string
	  (end-verbinline-char "\\")
	  ;;(end-verbinline-char "|")
	  (backslashes 
	   (if (or (string= mode-name "Emacs-Lisp")
		   (string= mode-name "Lisp"))
	       "\\\\" "\\")))
    (cond
     ((eq arg nil)
      (if macro
	  (setq message-string "What macro should be verbinline? ")
	;; else
	  (setq message-string "What should be verbinline? "))
      (setq a (read-string message-string)))
     ((listp arg)
      (setq a (car kill-ring)))
     ((symbolp arg)
      (setq message-string "What macro should be verbinline? ")
      (setq a (read-string message-string))
      (setq macro t)
      )
     ((integerp arg)
      (setq a (nth arg kill-ring)))
     ;; This can't happen.
     (t (message "Invalid prefix argument to verbinline."))
     ;; Matches cond
     )
    (cond
     ((eq a nil)
       (ignore)
       )
     ((string= a "")
      (insert "{" backslashes "verbinline")
      (if macro (insert backslashes))
      (set-mark (point))
      (insert end-verbinline-char "endverbatim}")
      (exchange-point-and-mark)
      (setq message-string
	    (concat
	     "Enter text by hand. Mark is after \""
	     end-verbinline-char "endverbatim\""))
      (message message-string)
      (sit-for 2)
      (message nil)
      )
     (t
      (insert "{" backslashes "verbinline")
      (if macro
	  (insert backslashes)
	;; else
	(progn
	  (setq b (string-to-char (substring a 0 1)))
	  (if 
	      (or
	       (and (>= b ?A) (<= b ?Z))
	       (and (>= b ?a) (<= b ?z)))
	      (insert " "))))
      (insert a end-verbinline-char "endverbatim}")
      )
     ;; Matches cond
     )
    ;; This returns a as the value of the function verbinline.
    (identity a)
    ;; Matches let
    )
  ;; Matches defun verbinline
  )

(defun make-verticals-macro (arg)
  "make-verticals-macro inserts |\\| and prompts for a string to put between them.
It works for tex and el-tex files. 
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "|\\" "|"
				     "What macro goes between the verticals? "
				     arg)
  ;; Matches defun make-verticals-macro
  )

;; Changed 10/29/99 so that I use \<  >, which, of course, must be
;; defined in the TeX macro file.

(defun angle-braces (arg)
  "angle-braces puts text between TeX angle-braces.
It works in Emacs-Lisp, Lisp and TeX modes.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it 
inserts the argth item from the kill ring. Negative integers are 
also allowed. With the argument -, \(a dash\), it inserts the last kill, 
leaves point between the delimiters and prompts the user to cycle 
through the kill ring or exit."
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (tgdf "\\\\<" ">"
				     "What goes in angle braces? " arg)

    ;; else
    (tgdf "\\<" ">"
				       "What goes in angle braces? " arg)

    ))

(defun curly-braces (arg)
  "curly-braces puts text between TeX curly-braces.
It works in Emacs-Lisp, Lisp and TeX modes.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it 
inserts the argth item from the kill ring. Negative integers are 
also allowed. With the argument -, \(a dash\), it inserts the last kill, 
leaves point between the delimiters and prompts the user to cycle 
through the kill ring or exit."
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (tgdf "{" "}"
				     "What goes in curly braces? " arg)

    ;; else
    (tgdf "{" "}"
				       "What goes in curly braces? " arg)

    ))


(defun dbl-square-brackets (arg)
  "dbl-square-brackets puts text between TeX double square brackets.
It works in Emacs-Lisp, Lisp and TeX modes.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it 
inserts the argth item from the kill ring. Negative integers are 
also allowed. With the argument -, \(a dash\), it inserts the last kill, 
leaves point between the delimiters and prompts the user to cycle 
through the kill ring or exit."
  (interactive "P")
  (if (or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
      (tgdf "\\\\[" "]"
				     "What goes in double square brackets? "
        arg) 

    ;; else
    (tgdf "\\[" "]"
				    "What goes in double square brackets? "
				    arg)

    ))






(defun tex-item (arg)
  "tex-item inserts the code for \\item{<arg>}.
It works for tex and el-tex. If there is no prefix argument it,
queries for whether to make a \"bullet item\". If the prefix
argument is 1, it makes a \"bullet item\" without querying. For
other prefix arguments, and if the query for a \"bullet item\" is
answered negatively, it calls tgdf and
behaves as the other functions do that call it."
  (interactive "P")
  (let (mode backslashes query)
    (if (or (string= mode-name
		     "Emacs-Lisp") (string= mode-name "Lisp")) (setq mode t)
      ;; else
      (setq mode nil))
    (setq backslashes
	  (if (eq mode t) "\\\\" "\\"))
    (if	(eq arg nil)
	(progn
	  (message "Do you want a bullet item?")
	  (sit-for  1.5)
	  (setq query
		(read-string
		 "Enter <RET> for yes or any other char for no: "))))
    (cond ((eq arg 1)
	   (insert backslashes "item{$" backslashes "bullet$}"))
          ((and (string= query "") (eq arg nil))
	   (insert backslashes "item{$" backslashes "bullet$}"))
	  (t 	   
	   (tgdf
	    (concat backslashes "item{")
	    "}" "What's the arg for \\item? " arg)
	   )
	  ;; Matches cond
	  )
    ;; Matches let
    )
  ;; Matches defun tex-item
  )


;; This works for tex and el-tex:
(fset 'equal-sign
      "$=$")

(defun a-umlaut ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\\\\"a}"))
   (t
    (insert "{\\\"a}"))))

(defun o-umlaut ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\\\\"o}"))
   (t
    (insert "{\\\"o}"))))


(defun u-umlaut ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\\\\"u}"))
   (t
    (insert "{\\\"u}"))))

(defun A-umlaut ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\\\\"A}"))
   (t
    (insert "{\\\"A}"))))
   
(defun O-umlaut ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\\\\"O}"))
   (t
    (insert "{\\\"O}"))))

(defun U-umlaut ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\\\\"U}"))
   (t
    (insert "{\\\"U}"))))

(defun scharf-s ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\ss}"))
   (t
    (insert "{\\ss}"))))


(defun slong ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\slong}"))
   (t
    (insert "{\\slong}"))))


(defun sshort ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\sshort}"))
   (t
    (insert "{\\sshort}"))))

(defun ok ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\&}"))
   (t
    (insert "{\\&}"))))

(defun ae ()
    "Makes ae ligature for ~/skand/paleo/*.tex and /*.el files.
For TeX and el-tex.
Functions differently for TeX and el-tex. Inserts the right number of 
backslashes depending on the mode."  
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\ae}"))
   (t
    (insert "{\\ae}"))))

(defun aa ()
    "Makes Skandinavian aa \(a with circle\).
For TeX and el-tex.
Functions differently for TeX and el-tex. Inserts the right number of 
backslashes depending on the mode."  
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\aa}"))
   (t
    (insert "{\\aa}"))))

(defun AA ()
  "Makes Skandinavian AA \(A with circle\).
For TeX and el-tex.
Functions differently for TeX and el-tex. Inserts the right number of 
backslashes depending on the mode."  
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\AA}"))
   (t
    (insert "{\\AA}"))))


(defun ydot ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\ydot}"))
   (t
    (insert "{\\ydot}"))))


(defun thorn ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\th}"))
   (t
    (insert "{\\th}"))))

(defun Thorn ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\TH}"))
   (t
    (insert "{\\TH}"))))

(defun eth ()
  "eth writes {\\dh} or {\\\\dh}, depending on mode. For tex and el-tex files"
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\dh}"))
   (t
    (insert "{\\dh}"))))

(defun Eth ()
  "Eth writes {\\DH} or {\\\\DH}, depending on mode. For tex and el-tex files"
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\DH}"))
   (t
    (insert "{\\DH}"))))


(defun icelandic-dotless-i ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\icei}"))
   (t
    (insert "{\\icei}"))))

(defun icelandic-dotless-j ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\icej}"))
   (t
    (insert "{\\icej}"))))

(defun ostrich ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\o}"))
   (t
    (insert "{\\o}"))))

(defun insular-f ()	
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\f}"))
   (t
    (insert "{\\f}"))))


(defun backslash ()
  (interactive)
  (expand-abbrev)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "\\\\"))
   (t
    (insert "\\"))))


(defun bigperiod ()
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\bigperiod}"))
   (t
    (insert "{\\bigperiod}"))))


(defun rthree ()
  "Makes {\\rthree} for tex, el-tex and lisp-tex files.
Functions differently for TeX and el-tex. Inserts the right number of 
backslashes depending on the mode."  
  (interactive)
  (cond 
   ((or (string= mode-name "Emacs-Lisp") (string= mode-name "Lisp"))
    (insert "{\\\\rthree}"))
   (t
    (insert "{\\rthree}"))))

(defun sperrung (arg)
  "sperrung queries the user and enters code for gesperrten text. If you want
an optional argument, you have to put it in yourself. sperrung uses 
tex-delimiter-function. See the documentation for that function for more 
info."
  (interactive "P")
    (tgdf "\\sperrung{" "}"
				     "Was muss gesperrt werden? "
				     arg)
    (message
     "If you want an optional argument, you'll have to put it in yourself.")
    (sit-for 1.5)
    (message nil)
  ;; Matches defun
  )

(defun indented-list ()
  "indented-list queries the user and puts in code for the tex-macro \\indentedlist.
Works for TeX and el-tex mode."
  (interactive)
  (let (a b (backslashes (if (string= mode-name "Emacs-Lisp") "\\\\" "\\")))
    (while (eq a nil)
      (setq a (read-string "What's the prefix string? "))
      (if (string= a "")
	  (progn
	    (setq a nil)
	    (message "You must enter a string.")
	    (sit-for 1.25))))
    (while (eq b nil)
      (setq b (read-string "For what level? "))
      (if (string= b "")
	  (progn
	    (setq b nil)
	    (message "You must enter a string.")
	    (sit-for 1.25))))
    (insert backslashes "indentedlist{" a "}{" b "}")
    
    ;; Matches let
    )
  ;; Matches defun indented-list
  )


(defun ldots ()
  "Inserts $\\ldots$ or $\\\\ldots$ for TeX-ellipses, depending on mode."
  (interactive)
  (insert "$\\" (if (or (string= mode-name "Emacs-Lisp")
			(string= mode-name "Emacs-Lisp"))
		    "\\" "") "ldots$"))


(defun tex-backslash ()
  "tex-backslash inserts $\\\\backslash$ or $\\backslash depending on mode."
  (interactive)
  (if (or (string= mode-name "Emacs-Lisp")
	  (string= mode-name "Lisp"))
      (insert "$\\\\backslash$")
    ;; else
    (insert "$\\backslash$")))

(defun miterbigletter ()
  "miterbigletter queries the user for a character and enters the code for the TeX-macro miterbigletter.
Works for Tex-, Lisp- and Emacs-Lisp modes."
  (interactive)
  (let (a (counter 1) (backslashes (if (or (string= mode-name "Lisp")
					   (string= mode-name "Emacs-Lisp"))
				       "\\\\"
				     ;; else
				     "\\")))
    (while (or (not (stringp a)) (string= a ""))
      (setq a (read-string "What's the big letter? "))
      (if (string= a "")
	  (progn
	    (message "You must enter a character.")
	    (sit-for 1.25)
	    )))
    (insert backslashes "miterbigletter{" a "}")
    (setq counter 1)
    (while (<= counter 8)
      (insert "{}")
      (setq counter (1+ counter)))
    (backward-char 15)
    (message "Enter additional args by hand.")
    (sit-for 2.5)
    (message nil)
    ;; Matches let
    )
  ;; Matches defun miterbigletter
  )


(defun hangbigletter ()
  "hangbigletter inserts the code for the TeX macro \\hangbigletter"
  (interactive)
  (let (query-string (backslashes (if (or (string= mode-name "Lisp")
					   (string= mode-name "Emacs-Lisp"))
				       "\\\\"
				     ;; else
				     "\\")))
    (setq query-string (read-string "What letter do you want? "))
    (insert backslashes "hangbigletter{" query-string "}{}{}{}{}")
    (backward-char 7)
    (message "Enter additional args by hand")
    (sit-for 5)
    (message nil)
    ;; Matches let
    )
  ;; Matches defun hangbigletter
  )


(defun longrightarrow ()
  "longrightarrow inserts code for the math symbol longrightarrow
Works in TeX, Lisp and Emacs-Lisp modes."
  (interactive)
  (let ((backslashes (if (or (string= mode-name "Lisp")
			     (string= mode-name "Emacs-Lisp"))
			 "\\\\" "\\")))
    (insert "$" backslashes "longrightarrow$")))


(defun yields (arg)
  "yields is for my TUGboat articles."
  (interactive "P")
  (let (here there my-string)
  (insert "%\n\\verbatim\n")
  (setq here (point))
  (setq my-string (read-string "What should be verbatim? "))
  (insert my-string "\n\\endverbatim\n%\n\\yields\n%\n\\display{}\n")
  (setq there (point))
  (insert my-string "\n\\enddisplay\n%\n")
  (if (string= my-string "")
      (progn
	(goto-char there)
	(set-mark-command nil)
	(goto-char here)
	(set-mark-command nil)
	(sit-for 1.5)
	(message "Previous mark set after \"\\display\"")
	(sit-for 2)
	(message nil)
	) ;; Matches progn
    )
  ) ;; Matches let
  ) ;; Matches defun yields



;; This is an old version.

;;(defun yields (arg)
;;  (interactive "P")
;;  (let (a b
;;	(backslashes 
;;	 (if (or (string= mode-name "Emacs-Lisp")
;;		 (string= mode-name "Lisp"))
;;	     "\\\\" "\\"))
;;	)

;;    (if (eq arg nil)
;;	(progn
;;	  (setq a (read-string "What text do you want? "))
;;	  (if (string= a "")
;;	      (progn
;;		(insert backslashes "verbatim")
;;		(set-mark-command nil)
;;		(insert backslashes "endverbatim" " $"
;;			backslashes "longrightarrow$ ")
;;		(exchange-point-and-mark)
;;		(message (concat "Put in text by hand. Mark set after "
;;				 backslashes "longrightarrow."))
;;		(sit-for 2)
;;		(message nil)
;;		;; Matches progn
;;		)
;;	    ;; Matches if
;;	    )
;;	  ;; Matches progn
;;	  )
;;	    ;; Matches if
;;      )
;;    (cond
;;     ((eq arg nil)
;;      (ignore))
;;     ((listp arg)
;;      (setq a (car kill-ring)))
;;     ((symbolp arg)
;;      (setq a "")
;;      (message "- as prefix arg to yields is not supported")
;;      (sit-for 2)
;;      (message nil))
;;     ((integerp arg)
;;      (setq a (nth arg kill-ring))))
;;    (if (not (string= a ""))
;;	(progn
;;	  (insert backslashes "verbatim")
;;	  (setq b (string-to-char (substring a 0 1)))
;;	  (if 
;;	      (or
;;	       (and (>= b ?A) (<= b ?Z))
;;	       (and (>= b ?a) (<= b ?z)))
;;	      (insert " "))
;;	  (insert a backslashes "endverbatim"  " $"
;;		  backslashes "longrightarrow$ " a)
;;	  ;; Matches progn
;;	  )
;;      ;; Matches if
;;      )
;;    ;; Matches let
;;    )
;;  ;; Matches defun
;;  )

;; This replaces the defun tex-file found in 
;; usr/local/lib/emacs/19.27/lisp/tex-mode.el
  
(defun my-tex-file (arg)
  "my-tex-file runs tex on the file associated with the current buffer, or
on the file named in the local variable run-tex-on-file in the local
variable list.
It replaces the function from /usr/local/lib/emacs/19.27/lisp/tex-mode.el, 
which doesn't work on all platforms.
my-tex-file has some special features for running TeX in certain directories
where I'm using Metapost. This is because Metapost is only installed on the 
Linux computers. There are some problems involving shell variables, aliases, 
etc. If the buffer-local-variable run-dvips-on-file is non-nil and I don't 
call my-tex-file with a prefix argument, dvips is run on the dvi file that
results from calling TeX. If run-dvips-on-file is nil and I call my-tex-file
with a prefix argument, dvips is also called. Otherwise, it's not called. This
means that I can contravene the default behavior of my-tex-file."
  (interactive "P")
  (let ((this-buffer (get-buffer (current-buffer)))
	(tex-file run-tex-on-file) current-dir kill-window linux-tex
	run-dvips)
    ;; run-dvips needs to be set here, before the buffer is switched.
    (setq run-dvips run-dvips-on-file)
    (setq this-buffer (get-buffer (current-buffer)))
    (setq current-dir (file-name-directory (buffer-file-name this-buffer)))
    (if (and (not normal-tex)
	     (or
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/animations/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/fonts/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/fonts/MP/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/perspective/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/patterns/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/xword/")))
	  (setq linux-tex t)
	) ;; Matches if


    ;; If the buffer-local variable run-tex-on-file is nil, then
    ;; I run tex on the file associated with the current buffer.
    ;; I can change the value for run-tex-on-file by putting code into
    ;; the local variables list.
    (if (eq tex-file nil)
	(setq tex-file (file-name-nondirectory (buffer-file-name))))
    (setq current-dir
	  (file-name-directory (buffer-file-name)))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (cond
     ((and linux-tex castor-pollux) ;; If it's on the pollux, it can't use *mp-shell*.
      (get-metapost-shell)
      (switch-to-buffer-other-window "*mp-shell*")
      )
     (t
 ;; Temporary.
 ;;     (make-comint "tex-shell" "/bin/ksh" nil "-i")
;;      (switch-to-buffer-other-window "*tex-shell*")
 
       (get-metapost-shell)
       (switch-to-buffer-other-window "*mp-shell*")

      ) ;; Matches t
     ) ;; Matches cond


    (insert "\n")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "pwd")
    (comint-send-input)
    (set-mark-command nil)
    (insert (concat "tex " tex-file))
    (comint-send-input)
    (let ((counter 0) (goal (length tex-file)) (temp-name tex-file)
	  (break-flag nil) current-char) ;; Matches let list 

    (setq tex-file "")
    (while (and (not break-flag)
		(< counter goal))
      (setq current-char (substring temp-name counter (1+ counter)))
      (if (equal current-char ".")
	  (setq break-flag t)
	;; else
	(progn
	  (setq tex-file (concat tex-file current-char))
	  (setq counter (1+ counter))
	  ) ;; Matches else progn
	) ;; Matches if
      ) ;; Matches while 
    
    ) ;; Matches inner let
    (cond ((or arg (and linux-tex run-dvips (not arg))
	       (and linux-tex (not run-dvips) arg))
	   (message "Running dvips")
	   (insert (concat "dvips -t landscape -o " tex-file ".ps " tex-file))
	   (comint-send-input)
	   (message "Running ps2pdf")
	   (insert (concat "ps2pdf " tex-file ".ps"))
	   (comint-send-input)
	   )
	  (t
	   (message "Not running dvips")
	   ) ;; Matches t
	) ;; Matches cond
    (switch-to-buffer-other-window this-buffer)
    (sit-for 1.5)
    (message nil)
    ) ;; Matches outer let
  ) ;; Matches my-tex-file
   



(defun my-latex-file ()
  "my-latex-file runs latex on the file associated with the current buffer, or
on the file named in the local variable run-latex-on-file in the local
variable list. Copied and adapted from my-tex-file. Not included in 
autoloads_tex or in any keymaps."
  (interactive)
  (let ((this-buffer (get-buffer (current-buffer)))
	(latex-file run-latex-on-file) current-dir kill-window)
    ;; If the buffer-local variable run-latex-on-file is nil, then
    ;; I run latex on the file associated with the current buffer.
    ;; I can change the value for run-latex-on-file by putting code into
    ;; the local variables list.
    (if (eq latex-file nil)
	(setq latex-file (file-name-nondirectory (buffer-file-name))))
    (setq current-dir
	  (file-name-directory (buffer-file-name)))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "latex-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*latex-shell*")
    (insert "\n")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "pwd")
    (comint-send-input)
    (insert (concat "latex " latex-file))
    (comint-send-input)
    (switch-to-buffer-other-window "*latex-shell*")
    (switch-to-buffer-other-window this-buffer)
    )
  )

;; ************** End of tex-functions.el



;; This works for both tex and el-tex

(defun make-verticals (arg)
  "make-verticals inserts || and prompts for a string to put between them.
It works for tex and el-tex files. 
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "|" "|"
				     "What goes between the verticals? "
				     arg)
  ;; Matches defun make-verticals
  )


(defun understroke ()
  "understroke inserts the text {\\understroke} or {\\\\understroke} for TeX or el-tex files. It's useful because {\\understroke} is often within a file name,
so it's inconvenient for an abbreviation."
  (interactive)
  (let
      ((backslashes
	(if (or (string= mode-name "Emacs-Lisp")
		(string= mode-name "Lisp"))
	    "\\\\" "\\")))
    (insert "{" backslashes "understroke}")
    ;; Matches let
    )
  ;; Matches defun understroke
  )



(defun acute (arg)
  "acute puts in TeX code for an acute accent: {\\'<arg>}
Works for tex and el-tex. In lisp-tex-keymap, set to \\C-c' followed by
a character. The characters are vowels which can take an acute accent.
A space causes {\\\\} to be inserted and point put before the closing 
curly brace. In oracle-mode, two single-quote marks are inserted. 
It should still work in the other modes, but I don't remember what files 
use the appropriate keymaps, so I haven't tested it to make sure."
  (interactive)
  (let (
        (quote (if (string= mode-name "Oracle")
		   "''" "'"))
    	(backslashes 
	 (if (or (string= mode-name "Emacs-Lisp")
		 (string= mode-name "Lisp"))
	     "\\\\" "\\")))
    (if (or (string= arg "i") (string= arg "j"))
	(insert "{" backslashes quote backslashes arg "}")
      ;; else
      (insert "{" backslashes quote arg "}"))
    ;; Matches let  
    )
  ;; Matches defun acute
  )


(defun grave (arg)
  "grave puts in TeX code for an grave accent: {\\`<arg>}
The characters are vowels which can take an grave accent.
A space causes {\\\\} to be inserted and point put before the closing 
curly brace."
  (interactive)
  (let ((backslashes 
	 (if (or (string= mode-name "Emacs-Lisp")
		 (string= mode-name "Lisp"))
	     "\\\\" "\\")))
    (if (or (string= arg "i") (string= arg "j"))
	(insert "{" backslashes "`" backslashes arg "}")
      ;; else
      (insert "{" backslashes "`" arg "}"))
    ;; Matches let  
    )
  ;; Matches defun grave
  )

(defun macron (arg)
  "macron puts in TeX code for a macron: {\\=<arg>}
The characters are vowels which can take a macron.
A space causes {\\\\} to be inserted and point put before the closing 
curly brace."
  (interactive)
  (let ((backslashes 
	 (if (or (string= mode-name "Emacs-Lisp")
		 (string= mode-name "Lisp"))
	     "\\\\" "\\")))
    (if (or (string= arg "i") (string= arg "j"))
	(insert "{" backslashes "=" backslashes arg "}")
      ;; else
      (insert "{" backslashes "=" arg "}"))
    ;; Matches let  
    )
  ;; Matches defun macron
  )

(defun breve (arg)
  "breve puts in TeX code for a breve accent: {\\u <arg>}
The characters are vowels which can take a breve accent.
A space causes {\\\\} to be inserted and point put before the closing 
curly brace."
  (interactive)
  (let ((backslashes 
	 (if (or (string= mode-name "Emacs-Lisp")
		 (string= mode-name "Lisp"))
	     "\\\\" "\\")))
    (if (or (string= arg "i") (string= arg "j"))
	(insert "{" backslashes "u" backslashes arg "}")
      ;; else
      (insert "{" backslashes "u " arg "}"))
    ;; Matches let  
    )
  ;; Matches defun breve
  )


(defun hfil-break ()
  (interactive)
  (insert "\\hfil\\break\n")
  )



(defun tex-filename (arg)
"tex-filename inserts \\filename{} and prompts for a string.
It's used for my TUGboat articles.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "\\filename{" "}"
				  "What filename do you want? " arg))


(defun display (arg &optional macro)
"display inserts code for a display and queries for a string.
It's used for my TUGboat articles.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
    (interactive "P")
    (tgdf "%\n\\display{}\n" "\n\\enddisplay\n%\n"
				  "What should be displayed? " arg)
  ;; Matches defun display
  )

(defun lisp-display (arg &optional macro)
  "lisp-display inserts code for a lisp-display and queries for a string.
It's used for my TUGboat articles.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
    (interactive "P")
    (tgdf "%\n\\lispdisplay{}\n" "\n\\endlispdisplay\n%\n"
				  "What lisp code should be displayed? " arg)
  ;; Matches defun lisp-display
  )

(defun lisp (arg)
  "lisp writes \\lisp{}\\endlisp and puts text between the braces. 
It's for my TUGboat articles. It works like all the other functions 
using tgdf."
    (interactive "P")
    (tgdf "\\lisp{" "}\\endlisp"
				  "What should be in the lisp environment? "
				  arg)
  ;; Matches defun lisp
  )


(defun lispfont (arg)
  "lispfont writes \\lispfont{} and puts text between the braces. 
It's for my TUGboat articles. It works like all the other functions 
using tgdf."
    (interactive "P")
    (tgdf "\\lispfont{" "}"
				  "What should be in lispfont? "
				  arg)
  ;; Matches defun lispfont
  )

;; Inserts the code for the TeX macro which prints the © symbol.
(fset 'copyright
      "{\\copyright}")
  
(defun danger ()
  "danger inserts code for \"dangerous bend\" paragraphs for my TUGboat articles"
  (interactive)
  (insert "\\danger\n\n")
  (insert "\\enddanger\n")
  (previous-line 2)
  )


(defun eplain-verbatim (arg)
  "eplain-verbatim inserts code for verbatim when I'm using eplain's 
conventions."
  (interactive "P")
  (tgdf "{\\verbatim" "|endverbatim}"
				  "What should be verbatim? "
				  arg)
  ) ;; Matches defun eplain-verbatim


(defun search-for-pounds-sterling ()
  "search-for-pounds-sterling searches for the British pound sterling symbol, 
decimal 163, octal 243, hexadecimal a3."
  (interactive)
  (let (a)
    (setq a (search-forward "£" nil t))
    (if (not a)
	(progn
	  (beginning-of-buffer)
	  (search-forward "£" nil t)
	  (message "Wrapped search for £.")
	  (sit-for 1.5)
	  (message nil)
	  ) ;; Matches progn
      ) ;; Matches if
    ) ;; Matches let
  ) ;; Matches defun search-for-pounds-sterling

(defun toggle-english-german ()
  "toggle-english-german does what it sounds like. 
See tex-functions.el for more information."
  (interactive)
  (cond ((eq local-abbrev-table german-tex-mode-abbrev-table)
	 (if english-tex-keymap nil (load "english-tex-keymap")) 
	 (use-local-map english-tex-mode-map)
	 (setq local-abbrev-table english-tex-mode-abbrev-table)
	 (message "Okay, changing to english keymap.")
	 (sit-for 2)
	 (message nil)
	)
	((eq local-abbrev-table english-tex-mode-abbrev-table)
    	 (if german-tex-keymap nil (load "german-tex-keymap")) 
	 (use-local-map german-tex-mode-map)
	 (setq local-abbrev-table german-tex-mode-abbrev-table)
	 (message "Okay, changing to german keymap.")
	 (sit-for 2)
	 (message nil)
	 )
	) ;; Matches cond
  ) ;; Matches defun toggle-english-german

(fset 'ustroke
   "{\\ustroke}")


(defun comment-question (arg)
"comment-question inserts code for comments ending with a question mark.
Used for my Mariu miracles translation."
  (interactive "P")
  (if arg 
      (tgdf "* " "?*" "What question do you want? " nil)
    (insert "*?*")
    ) ;; Matches if
  ) ;; Matches defun comment-question

(defun d2ps (arg)
  "d2ps runs dvips to make a PostScript file out of a dvi file.
If a prefix argument is used, and linux-tex is nil, then ghostview
is called to view the PostScript file."
  (interactive "P")
  (let ((this-buffer (get-buffer (current-buffer)))
	tex-file current-dir counter goal temp-name 
	break-flag kill-window linux-tex)
    ;; If the buffer-local variable run-tex-on-file is nil, then
    ;; I run tex on the file associated with the current buffer.
    ;; I can change the value for run-tex-on-file by putting code into
    ;; the local variables list.
    (if run-dvips-on-file
	(setq tex-file run-dvips-on-file)
      ;; else
      (if run-tex-on-file
	  (setq tex-file run-tex-on-file)
	)
      )
	  
    (if (eq tex-file nil)
	(setq tex-file (file-name-nondirectory (buffer-file-name))))
    ;; This gets rid of the extension, if any, of tex-file.
    (setq counter 0)
    (setq goal (length tex-file))
    (setq temp-name tex-file)
    (setq tex-file "")
    (setq break-flag nil)
    (while (and (not break-flag)
		(< counter goal))
      (setq current-char (substring temp-name counter (1+ counter)))
      (if (equal current-char ".")
	  (setq break-flag t)
	;; else
	(progn
	  (setq tex-file (concat tex-file current-char))
	  (setq counter (1+ counter))
	  ) ;; Matches else progn
	) ;; Matches if
      ) ;; Matches while 
    (setq current-dir
	  (file-name-directory (buffer-file-name)))

    (if (and (not normal-tex)
	     (or
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/animations/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/fonts/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/fonts/MP/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/perspective/")
	      (equal current-dir
		     "/usr/users/lfinsto1/metafont/metapost/xword/")))
	  (setq linux-tex t)
	) ;; Matches if




    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)

    (cond
     ((and linux-tex castor-pollux) ;; If it's on the pollux, it can't use *mp-shell*.
      (get-metapost-shell)
      (switch-to-buffer-other-window "*mp-shell*")
      )
     (t
      (make-comint "tex-shell" "/bin/ksh" nil "-i")
      (switch-to-buffer-other-window "*tex-shell*")
      ) ;; Matches t
     ) ;; Matches cond



    (insert "\n")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "pwd")
    (comint-send-input)
    (set-mark-command nil)
    (insert (concat "dvips -o " tex-file ".ps " tex-file))
    (comint-send-input)
    (if (and arg (not linux-tex))
	(progn
	  (insert (concat "ghostview " tex-file ".ps &"))
	  (comint-send-input)
	  ) ;; Matches progn
      ) ;; Matches if
    (switch-to-buffer-other-window this-buffer)
    ) ;; Matches let
  ) ;; Matches defun d2ps





(defun figure ()
  "figure is for inserting the code for the TeX macro \\figure."
  (interactive)
  (let (a 
	(backslash (if (or (string= mode-name "Emacs-Lisp")
			   (string= mode-name "Lisp"))
		       "\\\\" "\\"))
	);; Matches let-list
    (set-mark-command nil)
    (setq a
	  (read-string
	   "Type name of PostScript file, or m, or <RETURN> for m: "))
    (if (string= a "")
	(setq a "m"))   
    (insert backslash "fig{" a "}")
    (cond ((string= a "m")
	   ;; Must fill in here.
	   )
	  (t
	   (setq a (read-string
		    "Type in a title, a letter for placement or <RETURN> for nothing: "))
	   (cond ((or (string= a "l") (string= a "n") (string= a "r")
		      (string= a ""))
		  (insert "{" a "}"))
		 (t
		  (insert "{" a "}")
		  (setq a
			(read-string
			 "Type in a letter for placement or <RETURN> for none: "))
		  (insert "{" a "}")
		  );; Matches t
		 );; Matches cond
	   (setq a
		 (read-string
		  "Type in an integer for lines to be indented, or <RETURN> for the default: "))
	   (insert "{" a "}")

	   (setq a
		 (read-string
		  "Dimension for shifting the figure vertically, or <RETURN> for the default: "))
	   (insert "{" a "}")

	   (setq a
		 (read-string
		  "Dimension for shifting the figure horizontally, or <RETURN> for the default: "))
	   (insert "{" a "}")

	   (setq a
		 (read-string
		  "Dimension for space between figure and paragraph or <RETURN> for the default: "))
	   (insert "{" a "}")

	   (setq a
		 (read-string
		  "Dimension for skip before paragraph, or <RETURN> for the default: "))
	   (insert "{" a "}")

	   (setq a
		 (read-string
		  "Dimension for skip after paragraph, or <RETURN> for the default: "))
	   (insert "{" a "}")
	   );; Matches t
	  );; Matches cond
    );; Matches let
  );; Matches defun figure


(defun miracle ()
  "miracle is for the TeX macro \\miracle."
  (interactive)
  (insert "\\miracle{}{}")
  (backward-char 1)
  (set-mark-command nil)
  (backward-char 2)
  )



(defun pdev (arg)
  "pdev runs pdev and (possibly) TeX on the file associated with
the current buffer, or on the file named in the local variable
run-pdev-on-file in the local variable list. If pdev is called
with a prefix argument, TeX is not run."
  (interactive "P")
  (let ((this-buffer (get-buffer (current-buffer)))
	(pdev-file run-pdev-on-file) current-dir)
    (setq this-buffer (get-buffer (current-buffer)))
    (setq current-dir (file-name-directory (buffer-file-name this-buffer)))
    ;; If the buffer-local variable run-pdev-on-file is nil, then
    ;; I run pdev on the file associated with the current buffer.
    ;; I can change the value for run-pdev-on-file by putting code into
    ;; the local variables list.
    (if (not pdev-file)
	(setq pdev-file (file-name-nondirectory (buffer-file-name))))

    (let ((counter 0) (goal (length pdev-file)) (temp-name pdev-file)
	  (break-flag nil) current-char) ;; Matches let list 

    (setq pdev-file "")
    (while (and (not break-flag)
		(< counter goal))
      (setq current-char (substring temp-name counter (1+ counter)))
      (if (equal current-char ".")
	  (setq break-flag t)
	;; else
	(progn
	  (setq pdev-file (concat pdev-file current-char))
	  (setq counter (1+ counter))
	  ) ;; Matches else progn
	) ;; Matches if
      ) ;; Matches while 
        ) ;; Matches inner let
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "pdev-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*pdev-shell*")
    (insert "\n")(comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "pwd")
    (comint-send-input)
    (insert "\n")(comint-send-input)
    (set-mark-command nil)
    (insert "pdev ")
    ;; May want to reverse the results of the conditions.
    ;; Unspecified argument (C-u): run devnag, but not TeX.
    (cond ((and arg (listp arg))
	   (insert "-t "))
    ;;  Any other argument: run neither devnag nor TeX.
	  (arg
	   (insert "-d "))) ;; Matches cond
    (insert pdev-file "\n") 
    (comint-send-input)
    ) ;; Matches outer let
  ) ;; Matches pdev

(defun old-norse (arg)
  "old-norse inserts code for putting text into the format used for Old Norse.
Since \\ON is currently \\let to \\it, old-norse adds the italic
correction. This can be removed later, if necessary, but if it isn't,
it won't cause any harm."
  (interactive "P")
  (let (a return-value)
    (setq return-value
	  (tgdf
	   "{\\ON " "}" "What should be in Old Norse? " arg))
    ;; This queries for the italic correction
    (setq a (y-or-n-p "Do you want the italic correction? "))
    (message nil)
    (if (eq a t)
	(progn
	  ;; This is if I typed return to enter the string by hand,
	  ;; which causes tgdf to
	  ;; do a (backward-char 1), so I don't want to do one here.
	  (if (not (string= return-value ""))
	      (backward-char 1)
	    )
	  (insert "\\/")
	  (if (not (string= return-value ""))
	  (forward-char 1)
	  ;; else
	  (backward-char 2)
	  )
	  ;; Matches progn
	  )
      ;; else
      ;; (message "It's not return, not adding the italic correction.")
      ;; Matches if
      )
    (if (string= return-value "")
	(progn
	  (message "mark set after closing delimiter")
	  (sit-for 1.5)
	  (message nil)
	  )
      ;; If there was a prefix argument, old-norse returns
      ;; t. Otherwise, if I entered a string, it returns the
      ;; string. Otherwise, if I typed return, it returns nil.
      (if arg (setq return-value t))
      return-value
      ) ;; Matches let
    )
  ) ;; Matches defun old-norse


(defun latin (arg)
  "latin inserts code for putting text into the format used for Latin.
Since \\lat is currently \\let to \\it, latin adds the italic
correction. This can be removed later, if necessary, but if it isn't,
it won't cause any harm."
  (interactive "P")
  (let (a return-value)
    (setq return-value
	  (tgdf
	   "{\\lat " "}" "What should be in Latin? " arg))
    ;; This queries for the italic correction
    (setq a (y-or-n-p "Do you want the italic correction? "))
    (message nil)
    (if (eq a t)
	(progn
	  ;; This is if I typed return to enter the string by hand,
	  ;; which causes tgdf to
	  ;; do a (backward-char 1), so I don't want to do one here.
	  (if (not (string= return-value ""))
	      (backward-char 1)
	    )
	  (insert "\\/")
	  (if (not (string= return-value ""))
	  (forward-char 1)
	  ;; else
	  (backward-char 2)
	  )
	  ;; Matches progn
	  )
      ;; else
      ;; (message "It's not return, not adding the italic correction.")
      ;; Matches if
      )
    (if (string= return-value "")
	(progn
	  (message "mark set after closing delimiter")
	  (sit-for 1.5)
	  (message nil)
	  )
      ;; If there was a prefix argument, latin returns
      ;; t. Otherwise, if I entered a string, it returns the
      ;; string. Otherwise, if I typed return, it returns nil.
      (if arg (setq return-value t))
      return-value
      ) ;; Matches let
    )
  ) ;; Matches defun latin

(defun comment-old-norse (arg)
  (interactive "P")
  (let (a)
  "comment-old-norse is a combination of begin-comment and old-norse.
It puts Old Norse text within *...*. I doubt that I'll need this anymore, 
since I've programmed translit."
  (insert "**")
  (push-mark (point) t)
  (backward-char 1)
  (old-norse arg)  
  ) ;; Matches let
) ;; Matches defun comment-old-norse

(fset 'AE 
 "{\\AE}")

(fset 'oe
 "{\\oe}")

(fset 'OE
 "{\\OE}")


;; For Yiddish and Hebrew (and Arabic)

(defun xet-file (arg)
  "xet-file runs tex on the file associated with the current buffer, or
on the file named in the local variable run-tex-on-file in the local
variable list."
  (interactive "P")
  (let ((this-buffer (get-buffer (current-buffer)))
	(tex-file run-tex-on-file) current-dir kill-window linux-tex
	run-dvips)
    ;; run-dvips needs to be set here, before the buffer is switched.
    (setq run-dvips run-dvips-on-file)
    (setq this-buffer (get-buffer (current-buffer)))
    (setq current-dir (file-name-directory (buffer-file-name this-buffer)))


    ;; If the buffer-local variable run-tex-on-file is nil, then
    ;; I run tex on the file associated with the current buffer.
    ;; I can change the value for run-tex-on-file by putting code into
    ;; the local variables list.
    (if (eq tex-file nil)
	(setq tex-file (file-name-nondirectory (buffer-file-name))))
    (setq current-dir
	  (file-name-directory (buffer-file-name)))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "tex-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*tex-shell*")
    (insert "\n")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "pwd")
    (comint-send-input)
    (set-mark-command nil)
    (insert (concat "xet " tex-file))
    (comint-send-input)
    (let ((counter 0) (goal (length tex-file)) (temp-name tex-file)
	  (break-flag nil) current-char) ;; Matches let list 

    (setq tex-file "")
    (while (and (not break-flag)
		(< counter goal))
      (setq current-char (substring temp-name counter (1+ counter)))
      (if (equal current-char ".")
	  (setq break-flag t)
	;; else
	(progn
	  (setq tex-file (concat tex-file current-char))
	  (setq counter (1+ counter))
	  ) ;; Matches else progn
	) ;; Matches if
      ) ;; Matches while 
    
    ) ;; Matches inner let

    (switch-to-buffer-other-window this-buffer)
    (sit-for 1.5)
    (message nil)
    ) ;; Matches outer let
  ) ;; Matches xet-file
   
(defun translit-file (arg)
  "translit-file runs translit on the file associated with the current buffer, or
on the file named in the local variable run-translit-on-file in the local
variable list."
  (interactive "P")
  (let* ((this-buffer (get-buffer (current-buffer)))
	(translit-file run-translit-on-file)
	(current-dir (file-name-directory (buffer-file-name this-buffer)))
	kill-window comm-str)
    ;; If the buffer-local variable run-translit-on-file is nil, then
    ;; I run translit on the file associated with the current buffer.
    ;; I can change the value for run-translit-on-file by putting code into
    ;; the local variables list.
    (if (not translit-file)
	(setq translit-file (file-name-nondirectory (buffer-file-name))))
    ;; This removes the extension from the file name
    (let ((counter 0) (goal (length translit-file)) (temp-name translit-file)
	  (break-flag nil) current-char) ;; Matches let list 
    (setq translit-file "")
    (while (and (not break-flag)
		(< counter goal))
      (setq current-char (substring temp-name counter (1+ counter)))
      (if (equal current-char ".")
	  (setq break-flag t)
	;; else
	(progn
	  (setq translit-file (concat translit-file current-char))
	  (setq counter (1+ counter))
	  ) ;; Matches else progn
	) ;; Matches if
      ) ;; Matches while 
        ) ;; Matches inner let
    (setq comm-str "translit ")
    (cond ((eq arg nil) ;; No argument
	   (setq comm-str (concat comm-str "-t ")) ;; Temporary. Want to run 
	   ;; tex or xet every time. Comment out when I'm done.
	   (ignore))
          ((listp arg) ;; argument unspecified: C-u
	   (setq comm-str (concat comm-str "-t "))
	   )
	  ((symbolp arg) ;; Argument -  
	   (setq comm-str (concat comm-str "-c -t "))))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "translit-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*translit-shell*")
    (insert "\n")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "pwd")
    (comint-send-input)
    (set-mark-command nil)
    (insert (concat comm-str translit-file))
    (comint-send-input)
    (switch-to-buffer-other-window this-buffer)
    (sit-for 1.5)
    (message nil)
    ) ;; Matches outer let
  )   ;; Matches translit-file


(defun translit-verbatim (arg)
  "translit-verbatim is for verbatim text in nlt files. For the program translit."
  (interactive "P")
  (tgdf "@v " "@ev{}" "What should be verbatim? " arg)
  )

(defun anmerkung (arg)
 "anmerkung is for Anmerkungen in my miracle translation."
  (interactive "P")
  (tgdf "\\bANM\n" "\n\\eANM\n" "What's your Anmerkung? " arg)
  )


(defun mar-replace (arg)
  "Used for the scanned copies of Unger (Mariu miracles)."
  (interactive "P")
  (goto-char (point-min))
  (replace-string "" "\n")         (goto-char (point-min))
  (replace-string "á" "{\\'a}")      (goto-char (point-min))
  (replace-string "é" "{\\'e}")      (goto-char (point-min))
  (replace-string "í" "{\\'\\i}")    (goto-char (point-min))
  (replace-string "ó" "{\\'o}")      (goto-char (point-min))
  (replace-string "ú" "{\\'u}")      (goto-char (point-min))
  (replace-string "ý" "{\\'y}")      (goto-char (point-min))
  (replace-string "æ" "{\\ae}")      (goto-char (point-min))
  (replace-string "ö" "{\\\"o}")     (goto-char (point-min))
  (replace-string "œ" "{\\oe}")   (goto-char (point-min))
  (replace-string "ð" "{\\dh}")      (goto-char (point-min))
  (replace-string "þ" "{\\th}")      (goto-char (point-min))
  (replace-string "Þ" "{\\TH}")      (goto-char (point-min))
  (replace-string "„" "``")       (goto-char (point-min))
  (fill-region (point-min) (point-max)) (goto-char (point-min))
  (replace-string "\\\\ " "\\\\\n")  (goto-char (point-min))
  (replace-string "saal. " "saal.~")  (goto-char (point-min))
  (replace-string "mgl. " "mgl.~")  (goto-char (point-min))
  (replace-string "Fragm. " "Fragm.~")  (goto-char (point-min))
  (replace-string "tilf. " "tilf.~")  (goto-char (point-min))

  )


(defun mar-footnote-replace ()
"Used for the footnotes in the scanned copies of Unger (Mariu miracles)."
  (interactive)
  (query-replace-regexp "[ABC]" "{\\\\sl \\&}")
   (goto-char (point-min))
   (message "Now for the italic correction.")
   (sit-for 1)
   (query-replace-regexp "\\({\\\\sl [ABC]\\)}\\([^.,]\\)" "\\1\\\\/}\\2" nil)
)


(defun run-duewel (arg)
"run-duewel calls the shell script run_dw. It would be nice if it would
switch into ~/duewel/ before creating the shell, but I'll have to check
the Emacs lisp documentation in order to do this."
  (interactive "P")
  (let ((this-buffer (get-buffer (current-buffer))))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "duewel-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*duewel-shell*")
    (insert "clear")
    (comint-send-input)
    (insert "cd $DW")
    (comint-send-input)
    (insert "run_dw")
    (if arg
	(insert " 1"))
    (comint-send-input)
    (insert "\n")
    (comint-send-input)
    (switch-to-buffer-other-window "*duewel-shell*")
    (switch-to-buffer-other-window this-buffer)
    )
  )


;; LDF 2002.11.16.  Added texi2dvi-file-ldf.  I haven't defined any variables
;; for running texi2dvi on particular files, so texi2dvi-file-ldf always runs
;; texi2dvi on the file associated with the current buffer.  
;; I've given it the suffix "-ldf" because I think texinfo-mode may include 
;; a function of the same name someday, if it doesn't already exist in a newer 
;; version of GNU Emacs.

;; LDF 2003.01.19.  Added conditional code for running TeX instead of texi2dvi. 
;; See documentation string below.

;; LDF 2003.03.12.  Changed, so that the buffer local variable run-texi2dvi-on-file
;; can be used in a local variables list for running texi2dvi-file-ldf on a 
;; file different from the one associated with the current buffer.

;; LDF 2003.08.15.  Changed, so that the files examples.web and
;; extext.tex are moved to the directory above.  This
;; accounts for changes made in
;; the file ~/metafont/metapost/perspective/DOCUMENTATION/3DLDFman.texi. 
;; On the gwdg-wb01 under Linux, I was unable to get TeX to write onto
;; a file in the directory above.  It also wasn't possible to get
;; texi2dvi-file-ldf to move the files by using rename-file.  The
;; reason is, that texi2dvi (or tex, depending on the value of arg) is
;; run in a comint-shell, and I don't know of a way to suspend
;; execution of the Emacs-Lisp code until texi2dvi (or tex) is
;; finished.  It would be possible to do this with one of the other
;; methods of running shell commands, but I like to have the
;; comint-shell. 

;; LDF 2012.05.24.  Revised.  Removed special code from 2003.

(defun texi2dvi-file-ldf (arg)
  "texi2dvi-file-ldf runs texi2dvi and/or makeinfo on a file. 
If the buffer local variable run-texi2dvi-on-file is non-nil, texi2dvi-file-ldf
is run on the file named by that variable.  Otherwise, it's run on the file 
associated with the current buffer.

Prefix arguments:

If an empty prefix argument was used (\"C-u\"), makeinfo is run instead of texi2dvi.

If the prefix argument \"2\" is used (\"C-u 2\"), tex is run instead of texi2dvi.  

This is faster, if the indexes and cross-references don't need to be updated.

If any other numerical prefix argument is used (\"C-u <integer>\"), both texi2dvi 
and makeinfo are run.

If the prefix argument \"-\" is used, \"make all\" is run."
  (interactive "P")
  (let ((this-buffer (get-buffer (current-buffer)))
	(texi2dvi-file run-texi2dvi-on-file)
	current-dir
	)
    (if (not texi2dvi-file)
	(setq texi2dvi-file (file-name-nondirectory (buffer-file-name))))
    (setq current-dir (file-name-directory (buffer-file-name)))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "texinfo-shell" "/bin/bash" nil)
    (switch-to-buffer-other-window "*texinfo-shell*")
    (insert "\n")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "pwd")
    (comint-send-input)
    (set-mark-command nil)
    (cond ((not arg)
	   (insert (concat "texi2dvi " texi2dvi-file)))
	  ((listp arg)
	   (insert (concat "makeinfo " texi2dvi-file)))
	  ((eq arg 2)
	     (insert (concat "tex " texi2dvi-file)))
	  ((numberp arg)
	     (insert (concat "texi2dvi " texi2dvi-file " && makeinfo " texi2dvi-file)))
	  ((symbolp arg)
	     (insert "make all"))
	  ) ;; cond
    (comint-send-input)
    (switch-to-buffer-other-window this-buffer)
    (sit-for 1.5)
    (message nil)

    ) ;; Matches outer let

  ) ;; Matches texi2dvi-file-ldf
   

(defun setup-figure (arg)
  "setup-figure inserts TeX code for my figures in the 3DLDF User Manual.
It does not currently remove whitespace at the end of the lines. It would
be nice to make it do this, but this is really just a temporary convenience
function."
  (interactive "P")
  (let (start end temp)
    (setq start (make-marker))
    (setq end (make-marker))
    (set-marker start (point))
    (set-marker end (mark))
    (if (= start end)
	(progn
	  (message "No region to operate on. Exiting setup-figure.")
	  )
      ;; else
      (progn
	(when (> start end) ;; Exchange start and end.
	  (setq temp start)
	  (setq start end)
	  (setq end temp)
	  ) ;; when
	(goto-char start)
	(while (< (point) end)
	  (beginning-of-line)
	  (insert "\\immediate\\write\\examples{")
	  (end-of-line)
	  (insert "}")
	  (next-line 1)
	  ) ;; while
	(message "setup-figure is done")
	) ;; else progn
      ) ;; if
    ) ;; let
  ) ;; defun setup-figure


(defun convert-vert-code (arg)
  "convert-vert-code converts code fragments between Texinfo and CWEB format.
In Texinfo, code looks like this: \"@code{abc}\", while in CWEB, it looks
like this: \"|abc|\".  If convert-vert-code is called without a prefix argument,
it converts from CWEB to Texinfo format.  Otherwise, it converts from 
Texinfo to CWEB format.
START HERE!  This function should display the match somehow."
  (interactive "P")
  (if (eq arg nil)
      (while (re-search-forward "|\\([^|]*\\)|" nil t)
	(if (y-or-n-p "Replace?")
	    (replace-match "@code{\\1}" nil nil)))
    ;; else
    (while (re-search-forward "@code{\\([^}]*\\)}" nil t)
      (if (y-or-n-p "Replace?")
	  (replace-match "|\\1|" nil nil)))
    )
  )

;; Added defun for `syntax-item'.  LDF 2004.05.02.

;; Changed the way the string for the first delimiter is set.  
;; Previously, sometimes it worked and sometimes it didn't.  
;; It also seemed not to be portable.  It remains to be seen whether my changes 
;; fixed the problem.  LDF 2004.05.05.


;; LDF 2004.05.06.  Revised again.  Must see whether it works in my next
;; Emacs session.

;; LDF 2004.05.09.  It didn't.  Revised yet again.

;; LDF 2010.09.23.  Changed `\\§'  (Paragraph symbol) to `\\<'.

(defun syntax-item (arg)
  "syntax-item inserts  `\\<' and `>' and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (let (s) 
    (setq s (concat (char-to-string 92) "<"))
    (tgdf s ">" "Enter the syntax item: " arg)
    ) ;; let
  ) ;; defun syntax-item

;; Added defun for `cweb-literal-c'.  LDF 2004.05.03.

(defun cweb-literal-c (arg)
  "cweb-literal-c inserts `@=' and `@>' and prompts for a string to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "@=" "@>" "Enter the literal C code: " arg))


(defun cweb-bison-symbol (arg)
  "cweb-bison-symbol inserts `@=$' and `@>' and prompts for a symbol number to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "@=$" "@>" "Enter the symbol number: " arg))


(defun texinfo-insert-@command-ldf (arg)
  "texinfo-insert-@command-ldf inserts `@command{' and `}' and prompts for a command to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "@command{" "}" "Enter the command: " arg))

(defun texinfo-insert-@option-ldf (arg)
  "texinfo-insert-@option-ldf inserts `@option{' and `}' and prompts for a option to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "@option{" "}" "Enter the option: " arg))


(defun texinfo-insert-@ref-ldf (arg)
  "texinfo-insert-@ref-ldf inserts `@ref{' and `}' and prompts for a cross reference to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "@ref{" "}" "Enter the cross reference: " arg))

(defun texinfo-insert-@xref-ldf (arg)
  "texinfo-insert-@xref-ldf inserts `@xref{' and `}' and prompts for a cross reference to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "@xref{" "}" "Enter the cross reference: " arg))

(defun texinfo-insert-@pxref-ldf (arg)
  "texinfo-insert-@pxref-ldf inserts `@pxref{' and `}' and prompts for a cross reference to put between them.
If the user types <RET> without entering a string, it leaves point between the 
delimiters. Otherwise, it leaves point outside the delimiters.
It functions differently depending on the prefix argument.
With an unspecified prefix, just C-u, it inserts the last kill and then 
leaves point outside the delimiters. With an integer prefix arg, it inserts the 
argth item from the kill ring. Negative integers are also allowed. With the
argument -, \(a dash\), it inserts the last kill, leaves point between the 
delimiters and prompts the user to cycle through the kill ring or exit."
  (interactive "P")
  (tgdf "@pxref{" "}" "Enter the cross reference: " arg))


;; setup-funcs
;; LOG
;; LDF 2013.10.17.
;; Added this function.
;; ENDLOG

(defun setup-funcs (arg) 
  "setup-funcs" 
  (interactive "P") 
  (push-mark (point) t)
  




) ;; defun setup-funcs (for use in Texinfo files)

(fset 'handle-vars-with-default-arg
   [?\C-s ?= ?\C-  ?\C-r ?  ?\C-r ?\C-  C-right C-left S-f8 right ?\C-  escape ?\C-s ?  left right ?\C-w left ?\C-y ?\C-t f9 right ?\C-  ?\C-s ?, left ?\C-w left ?\C-y right ?\} ?\C-u ?\C-  ?\C-u ?\C-  ?\C-u ?\C-  ?\C-u ?\C-  ?\C-u ?\C-  ?\C-u ?\C-  ?\C-u ?\C-  C-right C-left ?\{ ?\C-n ?\C-a])


(fset 'handle-code-and-var-no-default
   [escape ?\C-s ?  ?\\ ?| ?& ?\\ ?| ?\\ ?* left right ?\C-w f9 ?\C-y ?\C-t S-f8 ?\C-  ?\C-s ?, left ?\C-w ?\C-y ?\C-  ?\C-r ?\{ right right ?\C-w left ?\C-y down ?\C-a C-right C-left])


;; Local Variables:
;; mode:Emacs-Lisp
;; End:
