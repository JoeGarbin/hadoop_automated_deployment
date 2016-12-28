#!/bin/bash
keyFile=$1
authorizationFile=$2
cat $keyFile >> $authorizationFile
echo "the ssh key have been authorized!"
