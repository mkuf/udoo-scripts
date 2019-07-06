#!/bin/bash

if ! [ -d /sys/class/gpio/gpio0 ]; then
	echo 0 > /sys/class/gpio/export
	echo out > /sys/class/gpio/gpio0/direction
fi

echo 0 > /sys/class/gpio/gpio0/value
sleep 0.5
echo 1 > /sys/class/gpio/gpio0/value

