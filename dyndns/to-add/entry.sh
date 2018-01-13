#!/bin/bash
ddclient -noquiet -verbose -file $@ 
while [ true ]; do 
  sleep 100
done
