#!/bin/bash

PASS_LENGTH=$1
SPECIAL_CHARACTERS=$2


pass_gen_with_params() {
  pwgen -s -N 1 -cny $PASS_LENGTH
}

pass_keygen() {
  pwgen -s $PASS_LENGTH 1
}

if [ -z "$SPECIAL_CHARACTERS" ]
  then
    pass_keygen
else
  pass_gen_with_params
fi
