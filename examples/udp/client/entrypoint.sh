#!/bin/bash

bash bootstrap.sh

while true
do
  echo 'hello world' | socat - udp4-sendto:server:50837
  echo
  echo "################ sleeping for 2 seconds ##################"
  echo
  sleep 2
done
