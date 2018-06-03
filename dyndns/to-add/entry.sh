#!/bin/bash
while [ true ]; do 
  ddclient -noquiet -verbose -file $@ 
  sleep 100
done
