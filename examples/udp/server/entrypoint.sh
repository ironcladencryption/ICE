#!/bin/bash

bash bootstrap.sh

socat -u udp4-recv:50837 -
