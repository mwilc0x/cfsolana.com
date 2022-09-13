#!/bin/bash

# install all dependencies

cd /app

box install contentbox-installer --force
box install
rm .env

box server start \
    trayEnable=false \
    host=0.0.0.0 \
    openbrowser=false \
    port=8080 \
    sslPort=8443 \
    saveSettings=false  \
    dryRun=false \
    console=false \
    startScript=bash \
    verbose=true

# TODO: why is container exiting?
# this keeps it alive so we can exec in
ping localhost
