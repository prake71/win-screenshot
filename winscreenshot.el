;;; win-screenshot.el --- Insert latest Windows screenshot into Org buffers  -*- lexical-binding: t; -*-

;; Author: Peter Rake
;; Maintainer: Peter Rake
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.1") (org "9.4"))
;; Keywords: convenience, tools, org
;; Homepage: https://github.com/yourname/win-screenshot

;;; Commentary:

;; win-screenshot provides a simple workflow for inserting the most
;; recent Windows screenshot into an Org buffer.
;;
;; Typical use case:
;; - Take a screenshot on Windows (Win+Shift+S)
;; - In an Org buffer, run `M-x win-screenshot-here`
;; - The screenshot is copied into ./images/ and inserted as an Org link
;; - Inline images are refreshed automatically
;;
;; The source screenshot directory is configurable via
;; `win-screenshot-source-dir`.


;;; Code:

;(require 'subr-x)

;;;; Customization

(defgroup win-screenshot nil
  "Insert Windows screenshots into Org buffers."
  :group 'external
  :prefix "win-screenshot-")

(defcustom win-screenshot-source-dir
  (expand-file-name
   "Pictures/Screenshots"
   (or (getenv "OneDrive")
       (getenv "USERPROFILE")
       "~"))
  "Directory where Windows screenshots are stored."
  :type 'directory
  :group 'win-screenshot)

(defun win-screenshot--timestamp ()
  "Return an ISO-like timestamp safe for filenames."
  (format-time-string "%Y-%m-%dT%H-%M-%S"))

(defun win-screenshot-most-recent-file ()
  "Return the full path of the most recent PNG file in
`win-screenshot-source-dir`, or nil if none exists."
  (let ((files (directory-files-and-attributes
                win-screenshot-source-dir
                t "\\.png\\'" t)))
    (when files
      (car
       (car
        (sort files
              (lambda (a b)
                (time-less-p
                 (file-attribute-modification-time (cdr b))
                 (file-attribute-modification-time (cdr a))))))))))

(defun win-screenshot-capture-file (screenshot-file)
  "Copy SCREENSHOT-FILE into ./images/ with a timestamped filename.
Return the relative path."
  (let* ((images-dir (expand-file-name "images" default-directory))
         (filename (concat (win-screenshot--timestamp) ".png"))
         (full-path (expand-file-name filename images-dir)))
    (unless (file-directory-p images-dir)
      (make-directory images-dir t))
    (copy-file screenshot-file full-path nil t)
    (file-relative-name full-path default-directory)))

;;;###autoload
(defun win-screenshot-here ()
  "Insert the most recent Windows screenshot into the current Org buffer."
  (interactive)
  (require 'org)
  (let ((latest (win-screenshot-most-recent-file)))
    (unless latest
      (user-error "No screenshot found in %s" win-screenshot-source-dir))
    (let ((relative-path (win-screenshot-capture-file latest)))
      (insert (format "[[file:%s]]\n" relative-path))
      (org-redisplay-inline-images))))

(provide 'win-screenshot)

;;; win-screenshot.el ends here
