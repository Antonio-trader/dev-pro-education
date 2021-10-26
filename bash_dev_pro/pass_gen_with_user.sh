#!/bin/bash

read -p "How long password do you want to have?  " PASS_LENGTH
read -p "Do you want to use special characters? y/n  " SPECIAL_CHARACTERS


pass_gen_with_params() {
  pwgen -s -N 1 -cny $PASS_LENGTH
}

pass_keygen() {
  pwgen -s $PASS_LENGTH 1
}

if [ $SPECIAL_CHARACTERS = "y" ]; then
  pass_gen_with_params
elif [ $SPECIAL_CHARACTERS = "n" ]; then
  pass_keygen
else
  echo "Something wrong..."
  echo "You should set the correct parameters for password length and special characters."
fi
