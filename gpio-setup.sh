#!/bin/bash

## erase
echo 117 > /sys/class/gpio/export

## reset
echo 0 > /sys/class/gpio/export
echo high > /sys/class/gpio/gpio0/direction

