#!/bin/bash

bash bootstrap.sh

nginx -c /nginx.conf -g 'daemon off;'
