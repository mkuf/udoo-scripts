# udoo-scripts
Collection of Scripts to use with a Udoo Quad/Dual

### gpio-setup.sh
Script to run at boot to set up Erase and Reset pins

### reset-due.sh
As the name implies, resets the SAM3X

### usb-gadget.sh
Set up the USB-OTG Port to use as a Serial and Network device.
Requires a Kernel that supports OTG for Udoo ( https://github.com/mkuf/linux_patches/blob/master/0001-ARM-dts-imx6qdl-udoo-Add-Pincfgs-for-OTG.patch )

### bossac_udoo.sh
Together with a recent (and self-compiled) version of bossac, this script replaces the patched bossac binary provided by Udoo.
You are therefore no longer bound to use a outdated Version of bossac on your Board.
