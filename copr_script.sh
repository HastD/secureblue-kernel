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
)

shopt -s nullglob
config_files=(*.config)
if (( ${#config_files[@]} == 0 )); then
  echo "No config files found!"
  exit 1
fi

for config_to_disable in "${configs_to_disable[@]}"; do
  for config_file in "${config_files[@]}"; do
    sed -i "s/^${config_to_disable}=.*/${config_to_disable}=n/" "$config_file"
  done
done

mv * ../..
cd ../..
