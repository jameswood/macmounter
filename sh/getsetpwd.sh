#!/usr/bin/env bash

PASSWD=$(security find-generic-password -a $1 -s $2 -w)
if [[ -z $PASSWD ]]
then
    echo -n Account: 
    read account

    echo -n Service: 
    read service

    echo -n Password:  
    read -s password

    security add-generic-password -a "${account}" -s "${service}" -w "${password}"
fi
