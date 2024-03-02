#!/bin/bash

bash bootstrap.sh

mosquitto_sub -v -h broker -t 'test/topic' &

while true
do
  mosquitto_pub -h broker -t 'test/topic' -m 'hello world' || true
  echo
  echo "################ sleeping for 2 seconds ##################"
  echo
  sleep 2
done
