#!/bin/bash
LATEXCMD="xelatex -shell-escape -interaction=nonstopmode"
# Shell escape is needed for pygments syntax highlighting
$LATEXCMD index.tex
# build glossary
makeglossaries index.glo
# build bibliography
bibtex index.aux
# build again with bibliography and glossary
$LATEXCMD index.tex
# build a third time to fix potential numbering changes
$LATEXCMD index.tex
