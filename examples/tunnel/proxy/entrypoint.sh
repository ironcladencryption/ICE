#!/bin/bash

bash bootstrap.sh

haproxy -f /etc/haproxy/haproxy.cfg
