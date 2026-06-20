#!/bin/bash 
set -eux

git clone https://src.fedoraproject.org/rpms/kernel.git
cd kernel
git checkout f44

fedpkg sources

configs_to_disable=(
  CONFIG_RC_DEVICES
  CONFIG_INPUT_JOYDEV
  CONFIG_INPUT_JOYSTICK
  CONFIG_IIO
  CONFIG_USB_GSPCA
  CONFIG_HAMRADIO
  CONFIG_MEDIA_RADIO_SUPPORT
  CONFIG_MEDIA_DIGITAL_TV_SUPPORT
  CONFIG_MEDIA_ANALOG_TV_SUPPORT
  CONFIG_MEDIA_TEST_SUPPORT
  CONFIG_INFINIBAND
  CONFIG_PARPORT
  CONFIG_ATM
  CONFIG_GPIB
  CONFIG_BT_6LOWPAN
  CONFIG_6LOWPAN
  CONFIG_CAN
  CONFIG_GNSS
  CONFIG_L2TP
  CONFIG_HID_PXRC
  CONFIG_USB_TRANCEVIBRATOR
  CONFIG_MCTP  
  CONFIG_VIDEO_CS3308
  CONFIG_VIDEO_SAA6752HS
)

for config_to_disable in "${configs_to_disable[@]}"; do
  echo "# ${config_to_disable} is not set" >> kernel-local
done

sed -i 's/^# define buildid .*$/%define buildid .secureblue/' kernel.spec

mv * ../..
cd ../..
