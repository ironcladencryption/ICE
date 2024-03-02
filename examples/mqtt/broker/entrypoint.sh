#!/bin/bash

bash bootstrap.sh

/usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
