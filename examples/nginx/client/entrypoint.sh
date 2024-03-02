#!/bin/bash

bash bootstrap.sh

while true
do
  curl server:8080 || true
  echo
  echo "################ sleeping for 2 seconds ##################"
  echo
  sleep 2
done
