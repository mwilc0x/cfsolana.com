#!/bin/bash

echo "Begin entrypoint"

./setup-jdk.sh
./setup-commandbox.sh
./install-app.sh
