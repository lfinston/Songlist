;;;; This is ~/Emacs/cweb_functions.el
;;;; Created by Laurence D. Finston (LDF).  Date unknown.

;;;; This file contains Emacs-Lisp function definitions (defuns), that are useful for
;;;; CWEB files.  LDF 2003.08.18.

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

;; LDF 2011.09.12.
;; Added code for suppressing saving of current buffer if it's a directory.

(defun run-make (arg)
  "run-make runs make."
  (interactive "P")
  (if (not (compare-strings mode-name 0 5 "Dired" 0 nil))
      (save-buffer))
  (save-some-buffers t)
  (delete-other-windows)
  (make-comint "makeshell" "/bin/bash" nil "-i")
  (switch-to-buffer-other-window "*makeshell*")
  (end-of-buffer)
  (insert "make")
  (comint-send-input)
  (other-window 1)
  ) ;; Matches defun run-make

(defun run-cmpl (arg)
  "run-cmpl runs 3DLDFcpl. It is for recompiling 3dldf.  
It takes a numerical argument which controls which platform 
3dldf is recompiled for: 0 for DEC.ALPHA, 1 for INTEL.LINUX using
GCC 2.95, 2 for INTEL.LINUX using GCC 3.3, or 3 for INTEL.FREEBSD."
  (interactive "P")
  (let (compile-command
	hostname
	platform
	process-exists
	required-directory
	required-host
	required-platform 
	shell-buffer-name 
	shell-exists
	shell-name 
	this-buffer 
	)
    (setq this-buffer (get-buffer (current-buffer)))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (setq platform (getenv "PLATFORM"))
    (setq hostname (getenv "HOSTNAME"))

    (cond ((eq arg 0) ;; DEC
	   (message "Compiling 3dldf for Tru64 (DEC ALPHA)")
	   (setq shell-name "cmpl-DEC-shell")
	   (setq required-platform "DEC.ALPHA")
	   (setq required-host "gwdu70.gwdg.de")
	   (setq required-directory "DEC")
	   )

	  ((eq arg 1) ;; LINUX, GCC 2.95
	   (message "Compiling 3dldf for LINUX, GCC 2.95")
	   (setq shell-name "cmpl-LINUX-GCC_2.95-shell")
	   (setq required-platform "INTEL.LINUX")
	   (setq required-host "gwdg-wb01.gwdg.de")
	   (setq required-directory "LINUX_GCC_2_95")
	   )

	  ((eq arg 2) ;; LINUX, GCC 3.3
	   (message "Compiling 3dldf for LINUX, GCC 3.3")
	   (setq shell-name "cmpl-LINUX-GCC_3.3-shell")
	   (setq required-platform "INTEL.LINUX")
	   (setq required-host "gwdu101.gwdg.de")
	   (setq required-directory "LINUX_GCC_3_3")
	   )

	  ((eq arg 3) ;; FREEBSD
	   (message "Compiling 3dldf for FREEBSD")
	   (setq shell-name "cmpl-FREEBSD-shell")
	   (setq required-platform "INTEL.FREEBSD")
	   (setq required-host "gwdu60.gwdg.de")
	   (setq required-directory "FREEBSD")
	   )
	  )
    (setq compile-command "3DLDFcpl")
    (setq shell-buffer-name (concat "*" shell-name "*"))
    (setq shell-exists (get-buffer shell-buffer-name))
    (setq process-exists (get-buffer-process
			  (get-buffer shell-buffer-name)))
    (make-comint shell-name "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window shell-buffer-name)
    (when (or (and (not (string= hostname required-host))
		   (not shell-exists))
	      (and shell-exists (not process-exists)))
      (insert "ssh " required-host)
      (comint-send-input)
      )
    (insert "clear")
    (comint-send-input)
    (insert "cd ~/metafont/metapost/perspective/" required-directory)
    (comint-send-input)
    (insert compile-command)
    (comint-send-input)
    (switch-to-buffer-other-window this-buffer)
    )  ;; Matches let
  )  ;; Matches defun run-cmpl

(defun run-3dldf (arg)
  "run-3dldf runs 3dldf. It is for recompiling 3dldf.  
It takes a numerical argument which controls on which platform 
3dldf is run: 0 for DEC.ALPHA, 1 for INTEL.LINUX using GCC 2.95,
2 for INTEL.LINUX using GCC 3.3, or 3 for INTEL.FREEBSD."
  (interactive "P")
  (let (compile-command
	hostname
	platform
	process-exists
	required-directory
	required-host
	required-platform 
	shell-buffer-name 
	shell-exists
	shell-name 
	this-buffer
	continue-flag
	)

    (setq this-buffer (get-buffer (current-buffer)))
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (setq platform (getenv "PLATFORM"))
    (setq hostname (getenv "HOSTNAME"))

    (cond ((eq arg 0);; DEC
	   (if (file-exists-p "~/metafont/metapost/perspective/DEC/3dldf")
	       (progn
		 (message "Running 3dldf for Tru64 (DEC ALPHA)")
		 (setq continue-flag t)
		 (setq shell-name "cmpl-DEC-shell")
		 (setq required-platform "DEC.ALPHA")
		 (setq required-host "gwdu70.gwdg.de")
		 (setq required-directory "DEC")
		 )
	     ;; else
	     (progn
	       (message "3dldf doesn't exist. Not running 3dldf for Tru64 (DEC ALPHA).")
	       (setq continue-flag nil)
	       )
	     );; if
	   );; DEC ALPHA case

	  ((eq arg 1);; LINUX, GCC 2.95
	   (if (file-exists-p "~/metafont/metapost/perspective/LINUX_GCC_2_95/3dldf")
	       (progn
		 (message "Running 3dldf for LINUX, GCC 2.95.")
		 (setq continue-flag t)
		 (setq shell-name "cmpl-LINUX-GCC_2.95-shell")
		 (setq required-platform "INTEL.LINUX")
		 (setq required-host "gwdg-wb01.gwdg.de")
		 (setq required-directory "LINUX_GCC_2_95")
		 )
	     ;; else
	     (progn
	       (message "3dldf doesn't exist. Not running 3dldf for LINUX, GCC 2.95.")
	       (setq continue-flag nil)
	       )
	     );; if
	   );; LINUX case


	  ((eq arg 2);; LINUX, GCC 3.3
	   (if (file-exists-p "~/metafont/metapost/perspective/LINUX_GCC_3_3/3dldf")
	       (progn
		 (message "Running 3dldf for LINUX, GCC 3.3.")
		 (setq continue-flag t)
		 (setq shell-name "cmpl-LINUX-GCC_3.3-shell")
		 (setq required-platform "INTEL.LINUX")
		 (setq required-host "gwdu101.gwdg.de")
		 (setq required-directory "LINUX_GCC_3_3")
		 )
	     ;; else
	     (progn
	       (message "3dldf doesn't exist. Not running 3dldf for LINUX, GCC 3.3.")
	       (setq continue-flag nil)
	       )
	     );; if
	   );; LINUX case


	  ((eq arg 3);; FREEBSD
	   (if (file-exists-p "~/metafont/metapost/perspective/BSD/3dldf")
	       (progn
		 (message "Running 3dldf for FREEBSD")
		 (setq shell-name "cmpl-FREEBSD-shell")
		 (setq required-platform "INTEL.FREEBSD")
		 (setq required-host "gwdu60.gwdg.de")
		 (setq required-directory "FREEBSD")
		 )
	     ;; else
	     (progn
	       (message "3dldf doesn't exist. Not running 3dldf for FREEBSD.")
	       (setq continue-flag nil)
	       )
	     );; if
	   );; FREEBSD case
	  );; cond

    (when continue-flag
      (setq shell-buffer-name (concat "*" shell-name "*"))
      (setq shell-exists (get-buffer shell-buffer-name))
      (setq process-exists (get-buffer-process
			    (get-buffer shell-buffer-name)))


      (make-comint shell-name "/bin/ksh" nil "-i")
      (switch-to-buffer-other-window shell-buffer-name)
      
      (when (or (and (not (string= hostname required-host))
		     (not shell-exists))
		(and shell-exists (not process-exists)))

	(insert "ssh " required-host)
	(comint-send-input)
	)
      
      (insert "clear")
      (comint-send-input)
      (insert "cd ~/metafont/metapost/perspective/" required-directory)
      (comint-send-input)
      (insert "echo \"Running 3dldf\"")
      (comint-send-input)
      (insert "3dldf")
      (comint-send-input)
      (insert "echo \"Finished running 3dldf\"")
      (comint-send-input)
      (switch-to-buffer-other-window this-buffer)
      ) ;; when continue-flag
    );; let
  );; defun run-3dldf


(defun temp (arg)
  "temp is a temporary function for running ctangle and make on
my program in ~/skand/wordlists/CWEB/."
  (interactive "P")
  (save-buffer)
  (save-some-buffers t)
  (delete-other-windows)
  (make-comint "cweb-shell" "/bin/ksh" nil "-i")
  (switch-to-buffer-other-window "*cweb-shell*")
  (insert "clear")
  (comint-send-input)
  (insert "cd $WL/CWEB; ctangle words; ctangle read_data_file")
  (comint-send-input)
  (cond ((not arg)
	 (insert "make")
	 (comint-send-input))
	) ;; Matches cond
  ) ;; Matches defun temp
  


(defun comment-cweb (arg)
  "comment-cweb puts in a comment using \"@q\" and \"@>\" for cweb files.
It uses tgdf. See documentation for that function 
for more information."
  (interactive "P")
  (tgdf "@q " "@>" "What's your comment? " arg)
  ) ;; Matches defun comment-cweb


(defun section-title-cweb (arg)
  "section-title-cweb puts in a section title using \"@<\" and \"@>\".
For cweb files.
It uses tgdf. See documentation for that function 
for more information."
  (interactive "P")
  (tgdf "@<" "@>" "What's your section title? " arg)
  ) ;; Matches defun section-title-cweb

(defun cweave (arg)
  "cweave makes a shell and runs the shell command cweave on the file 
associated with
the current buffer, or the value of the buffer-local-variable 
run-cweave-on-file. I could
make it so that I log onto the gwdu20, if I'm not already on it. If there's no
prefix argument, tex is run on the resulting tex file. Otherwise, if there
is a prefix argument, it's not."
  (interactive "P")
  (let (a current-name default-name
	  (this-buffer (get-buffer (current-buffer)))
	  current-dir
	  current-cweave-file
	  ;; Matches let-list
	  )
    (setq current-dir (file-name-directory
		       (buffer-file-name
			this-buffer)))
    ;; If the buffer local variable run-cweave-on-file is non-nil,
    ;; then current-cweave-file is set to it. Else, if the buffer
    ;; local variable run-cweb-on-file is non-nil, current-cweave-file
    ;; is set to it. Else, current-cweave-file is set to the current
    ;; filename.
    (cond (run-cweave-on-file
	   (setq current-cweave-file run-cweave-on-file))
	  (run-cweb-on-file
	   (setq current-cweave-file run-cweb-on-file))
	  (t
	   (setq current-cweave-file
		 (file-name-nondirectory (buffer-file-name
					  this-buffer))))
	  );; Matches cond
    ;; This eliminates the extension of current-cweave-file, if any.
    (let (counter goal temp-name break-flag current-char extension)
      (setq counter 0)
      (setq goal (length current-cweave-file))
      (setq temp-name current-cweave-file)
      (setq current-cweave-file "")
      (setq break-flag nil)
      (while (and (not break-flag)
		  (< counter goal))
	(setq current-char (substring temp-name counter (1+ counter)))
	(if (equal current-char ".")
	    (progn
	      (setq break-flag t)
	      (setq extension (substring temp-name (1+ counter)))
	      );; Matches then progn
	  ;; else
	  (progn
	    (setq current-cweave-file
		  (concat current-cweave-file current-char))
	    (setq counter (1+ counter))
	    );; Matches else progn
	  );; Matches if
	);; Matches while
      );; Matches inner let
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "cweb-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*cweb-shell*")
    (insert "clear")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "cweave " current-cweave-file)
    (comint-send-input)
    (if (not arg)
	(progn
	  (message (concat "Running tex on " current-cweave-file))
	  (insert "tex " current-cweave-file)
	  (comint-send-input)
	  ) ;; Matches progn
      ) ;; Matches if
    (insert "\n")
    (comint-send-input)
    ;; Often, I want to run tex by hand when arg is non-nil, so in this case,
    ;; I don't switch buffers.
    (if (not arg) (switch-to-buffer-other-window this-buffer))
    );; Matches let
  ) ;; Matches defun cweave


(defun ctangle (arg)
  "ctangle makes a shell and runs the shell command ctangle on the file 
associated with
the current buffer, or the value of the buffer-local-variable 
run-ctangle-on-file. Then it compiles the resulting C program,
unless a prefix argument is used. The command used for compiling is in
the variable compile-command. It can be changed, if desired."
  (interactive "P")
  (let (a current-name default-name
	  (this-buffer (get-buffer (current-buffer)))
	  current-dir
	  (current-ctangle-file run-ctangle-on-file)
	  (local-exec-name executable-name)
	  compile-command	  
	  suffix
          (USE-G++ use-g++)
	  ) ;; Matches let-list

    ;; Change this to reflect the fact that I now have a variable cxx, 
    ;; also, when the Gnu compiler is updated, I should make it possible to
    ;; use it instead.
    (cond (USE-G++
	   (if (string-equal (getenv "PLATFORM") "INTEL.FREEBSD")
	       (setq compile-command  "cpp -o ")
	     ;(setq compile-command  "cxx -x cxx -lm -o "))
	     ;; Temporary.
	     (setq compile-command  "cxx -x cxx "))
	   (setq suffix  ".c"))
	  (t
	   (setq compile-command "gcc -lm -g -o ")
	   (setq suffix  ".c")))

    ;; This is a kludge. I should fix the problem below.
    (if (not local-exec-name) (setq local-exec-name "a.out"))
    (setq current-dir (file-name-directory
		       (buffer-file-name
			this-buffer)))
    ;; If the buffer local variable run-ctangle-on-file is non-nil,
    ;; then current-ctangle-file is set to it. Else, if the buffer
    ;; local variable run-cweb-on-file is non-nil, current-ctangle-file
    ;; is set to it. Else, current-ctangle-file is set to the current
    ;; filename.
    (cond (run-ctangle-on-file
	   (setq current-ctangle-file run-ctangle-on-file))
	  (run-cweb-on-file
	   (setq current-ctangle-file run-cweb-on-file))
	  (t
	   (setq current-ctangle-file
		 (file-name-nondirectory (buffer-file-name
					  this-buffer))))
	  );; cond
    ;; This eliminates the extension of current-ctangle-file, if any.
    (let (counter goal temp-name break-flag current-char extension)
      (setq counter 0)
      (setq goal (length current-ctangle-file))
      (setq temp-name current-ctangle-file)
      (setq current-ctangle-file "")
      (setq break-flag nil)
      (while (and (not break-flag)
		  (< counter goal))
	(setq current-char (substring temp-name counter (1+ counter)))
	(if (equal current-char ".")
	    (progn
	      (setq break-flag t)
	      (setq extension (substring temp-name (1+ counter)))
	      );; Matches then progn
	  ;; else
	  (progn
	    (setq current-ctangle-file
		  (concat current-ctangle-file current-char))
	    (setq counter (1+ counter))
	    );; Matches else progn
	  );; Matches if
	);; Matches while
      );; Matches inner let
    (save-buffer)
    (save-some-buffers t)
    (delete-other-windows)
    (make-comint "cweb-shell" "/bin/ksh" nil "-i")
    (switch-to-buffer-other-window "*cweb-shell*")
    (insert "clear")
    (comint-send-input)
    (insert "cd " current-dir)
    (comint-send-input)
    (insert "ctangle " current-ctangle-file)
    (comint-send-input)
    (insert "mv " current-ctangle-file ".c LINUX/" current-ctangle-file
	    ".cxx")
    (comint-send-input)

;;    (cond (arg ;; There was a prefix argument.
;;	   (ignore))

;;	   ;; Temporary.

;;;	   (insert compile-command
;;;		   " " current-ctangle-file  
;;;		   suffix
;;;		   )
;;	  (local-exec-name
;;	   (insert compile-command " -o "
;;		   local-exec-name " " current-ctangle-file  
;;		   suffix)
;;	   (comint-send-input)
;;	   )
;;;	  ((not local-exec-name)
;;;	   (insert "echo \"Running " compile-command 
;;;		   current-ctangle-file suffix "\"")  
;;;	   (comint-send-input)
;;;	   (insert compile-command current-ctangle-file suffix)
;;;	   (comint-send-input)
;;;	   )
;;	  ) ;; Matches cond

    (insert "\n")
    (comint-send-input)
    (switch-to-buffer-other-window this-buffer)
    ) ;; Matches let
  ) ;; Matches defun ctangle


(defun file-section-cweb (arg)
  "file-section-cweb inserts @( and @> in CWEB files. 
It uses tgdf. See the documentation for that
function for more information."
  (interactive "P")
  (tgdf "@(" "@>"
				  "What C file do you want to write to? "
                                   arg)) 
	

(defun tt-cweb (arg)
  "tt-cweb inserts \\.{ and } in CWEB files for typewriter type.
It uses tgdf. See the documentation for that
function for more information."
  (interactive "P")
  (tgdf "\\.{" "}"
				  "What do you want in typewriter type? "
                                   arg)) 
	

;;;; Added.  LDF 2009.09.29.

(fset 'cweb-include
   [right ?\C-d ?\C-d ?\C-e left left ?@ ?q])


(fset 'cweb-uninclude
   [right ?q ?  ?\C-e left left left left ?\C-d ?\C-d ?\C-n ?\C-a])


(defun write-function (arg)
  "write-function."
  (interactive "P")

  (insert (concat "\\write\\" (substring (buffer-name) 0 -3)
		  "{@@deftypefn {Function}  %\n"
		  "({} @@var{} @@*@@ ^^J%\n"
		  "{} @@var{})^^J%\n"
		  "@@end deftypefn^^J}\n"))

  )    ;; write-function

(defun write-variable (arg)
  "write-variable."
  (interactive "P")

  (insert (concat "\\write\\" (substring (buffer-name) 0 -3)
		  "{@@deftypevr {Variable}  %\n"
		  "^^J%\n"
		  "@@end deftypevr^^J}\n"))

  )    ;; write-variable


(fset 'cweb-include
   [?\C-a ?\C-s ?@ ?q left ?i ?\C-d ?\C-s ?@ ?@ ?q ?\C-  left left ?\C-d ?\C-a])

(fset 'cweb-uninclude
   [?\C-a ?\C-s ?@ ?i left ?q ?\C-d ?\C-s ?@ ?q ?\C-  left ?@ ?\C-a])






;; Local Variables:
;; mode:Emacs-Lisp
;; End:
