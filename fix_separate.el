;; /home/laurence/Songlist/fix_separate.el
;; Created by Laurence D. Finston (LDF) Thu 27 May 2021 02:18:04 PM CEST

;; This Emacs batch script removes blanks following \ characters at the end of lines.
;; It's used to fix `separate_all_sep.sh'.  Invocations of TeX's `\write' command in
;; `all.tex' write blanks after the backslash characters.  This prevents the latter from
;; functioning as continuation characters in the shellscript.
;; 2021.05.27.

(replace-regexp "\\\\ +$" "\\\\")

;; Local Variables:
;; mode:Emacs-Lisp
;; End:
