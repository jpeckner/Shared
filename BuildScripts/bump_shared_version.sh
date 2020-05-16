#!/bin/bash

set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
oldVersion=$1
newVersion=$2

cd $CURRENT_DIR/..
git grep -rI -l $oldVersion | xargs sed -i '' -e "s/$oldVersion/$newVersion/g"
