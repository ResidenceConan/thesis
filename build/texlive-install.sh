#!/bin/bash
# source: https://gist.github.com/kokx/fd218f5c17cf795d6b8b
# This file will install texlive in a travis worker that does not allow sudo.
# Hopefully this will become obsolete in the near future.
mkdir ~/texlive
cd ~/texlive
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xf install-tl-unx.tar.gz
rm install-tl-unx.tar.gz
cd install-tl-*
echo "d
1
~/texlive
r
s
c
r
i
" | ./install-tl
