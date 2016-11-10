Pep8 checks your python code for common formatting fixes. Pyflakes checks your syntax, your imports, etcetera. Indispensable tools, so they should be easy to use.

If you don’t have them yet, do a simple easy_install pep8 and easy_install pyflakes and you’ve got them. Then call either pep8 or pyflakes on a python file or on a directory to get an error report.

I’ve integrated them in two ways into my daily emacs workflow.

First: emacs’ ctrl-c ctrl-w is by default bound to pychecker. I modified that to run both pyflakes and pep8. You’ll need a pychecker.sh bash file somewhere on your path:

```
#!/bin/bash
pyflakes $1
echo "## pyflakes above, pep8 below ##"
pep8 --repeat $1
```

Then tell emacs to treat ctrl-c ctrl-w differently in your .emacs (or .emacs.d/custom.el when you use the “emacs starter kit”):

```
(custom-set-variables
  ...
    '(py-pychecker-command "pychecker.sh")
      '(py-pychecker-command-args (quote ("")))
        '(python-check-command "pychecker.sh")
          ...
```
          When you’re editing a python file, press ctrl-c ctrl-w and you get a good clickable error report that goes right to the offending line in your python code.

The second way: flymake. Flymake checks your file’s syntax on the fly. Continuously. So you get feedback the moment you use a variable you didn’t define yet. The moment you make a typo. Chris McDonough has a config for pyflakes that I’m happily using:

```
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                             'flymake-create-temp-inplace))
                                        (local-file (file-relative-name
                                                                temp-file
                                                                                        (file-name-directory buffer-file-name))))
                                                                                              (list "pyflakes" (list local-file))))
                                                                                                (add-to-list 'flymake-allowed-file-name-masks
                                                                                                               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)
```
In the screenshot you’ll see a red highlight on one of the “import” lines: that’s pyflakes warning about an extraneous import that you’re not using yet.