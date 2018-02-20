#!/bin/bash
DATE=`date +"%y%m%d"`
GIT_HASH=`git rev-parse --short HEAD`
ORGFILE="index.pdf"
FILENAME="PlazaRoute-$DATE-$GIT_HASH.pdf"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mv $ORGFILE $FILENAME
python $SCRIPT_DIR/upload-to-jira.py $FILENAME
