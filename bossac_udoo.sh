#!/bin/bash

BIN=$1
DUE=ttymxc3
BOSSAC=/opt/bossac/bin/bossac

function export_gpio {
  if ! [ -d "/sys/class/gpio/gpio${1}" ]; then
    echo ${1} > /sys/class/gpio/export
  fi
}

function write_gpio {
  echo ${2} > /sys/class/gpio/gpio${1}/direction
}

function log {
  echo -e "\033[0;36m## ${1} \033[0m"
}

## Check if provided File exists
if [ ! -f ${BIN} ] || [ -v ${BIN} ]; then
  log "File not found!"
  log "Usage: $0 <file-to-flash>.bin"
  exit 1
fi

## gpios connected to SAM3X
## gpio117 | default: low  | erase: high
## gpio0   | default: high | reset: low
export_gpio 117
export_gpio 0
write_gpio 117 low
write_gpio 0 high

## Erase Flash
log "Erasing flash"
write_gpio 117 high
sleep 2
write_gpio 117 low

## Reset
log "Resetting SAM3X"
write_gpio 0 low
sleep 2
write_gpio 0 high

## Flash
log "Flashing via bossac"
#${BOSSAC} --port=${DUE} --usb-port=false -a -e -w ${BIN} -v -b
${BOSSAC} --port=${DUE} --usb-port=false -a -e -w ${BIN} -b
${BOSSAC} --port=${DUE} --usb-port=false -R

