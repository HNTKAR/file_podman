#!/bin/bash

while [ $# -gt 0 ];do
    case $1 in
        -[Nn]) NAME=$2;;
        -[Pp]) PASS=$2;;
    esac
    shift 2
done
useradd -s /sbin/nologin ${NAME=test_user}
echo -e "${PASS=password}\n${PASS=password}" | pdbedit -a -u ${NAME=test_user} 