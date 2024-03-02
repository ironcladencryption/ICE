#!/bin/bash

bash bootstrap.sh

while true
do
  echo 'hello world' | socat - tcp4-connect:proxy:5555
  echo
  echo "################ sleeping for 2 seconds ##################"
  echo
  sleep 2
done
