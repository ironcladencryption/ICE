#!/bin/bash

while true; do
  socat -u tcp4-listen:5556,fork exec:'/bin/cat'
done
