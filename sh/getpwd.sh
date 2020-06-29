#!/usr/bin/env bash

PWD=`security find-generic-password -a $1 -s $2 -w`

# for mount_smbfs, spaces in passwords need to be escaped as %20
printf "%s" `echo ${PWD// /%20}`
