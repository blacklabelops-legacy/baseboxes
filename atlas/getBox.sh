#!/bin/bash

set -o errexit    # abort script at first error

# Setting environment variables
readonly CUR_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# Reading config
source $CUR_DIR/atlas.cfg

function jsonval {
    temp=`echo $1 | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $2`
    echo ${temp##*|}
}

#Checks for an Atlas API Error
function checkErr {
	if  [[ $1 == '{"errors":'* ]] ;
	then
		echo $1
    	err
	fi
}

# Helper functions
err() {
  printf '%b\n' ""
  printf '%b\n' "\033[1;31m[ATLAS ERROR] $@\033[0m"
  printf '%b\n' ""
  exit 1
} >&2

#------------------
# SCRIPT ENTRYPOINT
#------------------

boxname=$1

if [ -z "$1" ]; then
  boxname=${ATLAS_USER}/${ATLAS_BOX}
fi

response=$(curl https://atlas.hashicorp.com/api/v1/box/${boxname}?access_token=${ATLAS_TOKEN})

checkErr $response

echo $response
