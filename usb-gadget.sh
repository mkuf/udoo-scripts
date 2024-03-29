#!/bin/bash -e

modprobe libcomposite

cd /sys/kernel/config/usb_gadget/
mkdir g && cd g

echo 0x1d6b > idVendor  # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB    # USB 2.0

echo 0xEF > bDeviceClass
echo 0x02 > bDeviceSubClass
echo 0x01 > bDeviceProtocol

mkdir -p strings/0x409
echo "deadbeef00115599" > strings/0x409/serialnumber
echo "Voodoo"        > strings/0x409/manufacturer
echo "Sparkcube"   > strings/0x409/product

mkdir -p functions/acm.usb0    # serial
mkdir -p functions/rndis.usb0  # network

mkdir -p configs/c.1
echo 250 > configs/c.1/MaxPower
ln -s functions/rndis.usb0 configs/c.1/
ln -s functions/acm.usb0   configs/c.1/

# OS descriptors
echo 1       > os_desc/use
echo 0xcd    > os_desc/b_vendor_code
echo MSFT100 > os_desc/qw_sign

echo RNDIS   > functions/rndis.usb0/os_desc/interface.rndis/compatible_id
echo 5162001 > functions/rndis.usb0/os_desc/interface.rndis/sub_compatible_id

ln -s configs/c.1 os_desc

udevadm settle -t 5 || :
ls /sys/class/udc/ > UDC

ip link set dev usb0 up
ip a a 172.16.0.1/28 dev usb0

