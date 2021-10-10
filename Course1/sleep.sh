#!/bin/bash

trap - SIGINT
trap "./region.sh" SIGINT
echo "To Change Ngrok Region Press Ctrl+C"
sleep 50000
