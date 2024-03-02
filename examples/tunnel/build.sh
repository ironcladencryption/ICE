#!/bin/bash

cd server
./build.sh

cd ../client
./build.sh

cd ../proxy
./build.sh
