#!/bin/bash 
set -eux

git clone https://src.fedoraproject.org/rpms/kernel.git
cd kernel
git checkout f44

fedpkg sources

configs_to_disable=(
  # https://www.kernelconfig.io/CONFIG_RC_CORE
  # Remote Controller support
  CONFIG_RC_CORE

  # https://www.kernelconfig.io/CONFIG_INPUT_JOYDEV
  # https://www.kernel.org/doc/Documentation/input/joydev/joystick.rst
  CONFIG_INPUT_JOYDEV

  # https://www.kernelconfig.io/CONFIG_INPUT_JOYSTICK
  # https://www.kernel.org/doc/Documentation/input/joydev/joystick.rst
  CONFIG_INPUT_JOYSTICK

  # https://www.kernelconfig.io/CONFIG_IIO
  # The industrial I/O subsystem provides a unified framework for
  # drivers for many different types of embedded sensors using a
  # number of different physical interfaces (i2c, spi, etc).
  CONFIG_IIO

  # https://www.kernelconfig.io/CONFIG_USB_GSPCA
  # GSPCA based webcams
  # https://www.kernel.org/doc/Documentation/admin-guide/media/gspca-cardlist.rst
  CONFIG_USB_GSPCA

  # https://www.kernelconfig.io/CONFIG_HAMRADIO
  # Amateur Radio support
  CONFIG_HAMRADIO

  # https://www.kernelconfig.io/CONFIG_MEDIA_RADIO_SUPPORT
  # AM/FM radio receivers/transmitters
  CONFIG_MEDIA_RADIO_SUPPORT

  # https://www.kernelconfig.io/CONFIG_MEDIA_DIGITAL_TV_SUPPORT
  # Enable digital TV support.
  # Say Y when you have a board with digital support or a board with
  # hybrid digital TV and analog TV.
  CONFIG_MEDIA_DIGITAL_TV_SUPPORT

  # https://www.kernelconfig.io/CONFIG_MEDIA_ANALOG_TV_SUPPORT
  # Enable analog TV support
  # Say Y when you have a TV board with analog support or with a
  # hybrid analog/digital TV chipset.
  CONFIG_MEDIA_ANALOG_TV_SUPPORT

  # https://www.kernelconfig.io/CONFIG_MEDIA_TEST_SUPPORT
  # Test drivers
  # "These drivers should not be used on production kernels"
  CONFIG_MEDIA_TEST_SUPPORT

  # https://www.kernelconfig.io/CONFIG_INFINIBAND
  # https://en.wikipedia.org/wiki/InfiniBand
  # InfiniBand support
  CONFIG_INFINIBAND

  # https://www.kernelconfig.io/CONFIG_PARPORT
  # Parallel port support
  CONFIG_PARPORT

  # https://www.kernelconfig.io/CONFIG_ATM
  # Asynchronous Transfer Mode (ATM)
  # https://en.wikipedia.org/wiki/Asynchronous_Transfer_Mode
  # In order to participate in an ATM network, your Linux box needs an
  # ATM networking card.
  # ATM became popular with telephone companies and many computer makers in the 1990s. 
  # However, even by the end of the decade, the better price–performance ratio of Internet Protocol-based
  # products was competing with ATM technology for integrating real-time and bursty network traffic.
  CONFIG_ATM

  # https://www.kernelconfig.io/CONFIG_GPIB
  # https://en.wikipedia.org/wiki/GPIB
  # Enable support for GPIB cards and dongles. 
  CONFIG_GPIB

  # https://www.kernelconfig.io/CONFIG_6LOWPAN
  # https://en.wikipedia.org/wiki/6LoWPAN
  # IPv6 over Low-Power Wireless Personal Area Networks
  # It was created with the intention of applying the Internet Protocol (IP) even to the smallest devices,
  # [3] enabling low-power devices with limited processing capabilities to participate in the Internet of Things.[1]
  CONFIG_6LOWPAN

  # https://www.kernelconfig.io/CONFIG_CAN
  # https://www.kernel.org/doc/Documentation/networking/can.rst
  # https://en.wikipedia.org/wiki/CAN_bus
  # Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
  # communications protocol. 
  CONFIG_CAN

  # https://www.kernelconfig.io/CONFIG_GNSS
  # https://en.wikipedia.org/wiki/Satellite_navigation
  # https://www.kernel.org/doc/Documentation/devicetree/bindings/gnss/gnss-common.yaml
  # GNSS receiver support
  CONFIG_GNSS

  # https://www.kernelconfig.io/CONFIG_L2TP
  # https://en.wikipedia.org/wiki/Layer_2_Tunneling_Protocol
  # Layer Two Tunneling Protocol (L2TP)
  CONFIG_L2TP

  # https://www.kernelconfig.io/CONFIG_IP_SCTP
  # https://en.wikipedia.org/wiki/Stream_Control_Transmission_Protocol
  # SCTP is a reliable transport protocol operating on top of a
  # connectionless packet network such as IP. 
  CONFIG_IP_SCTP

  # https://www.kernelconfig.io/CONFIG_RDS
  # https://en.wikipedia.org/wiki/Reliable_Datagram_Sockets
  # The RDS (Reliable Datagram Sockets) protocol provides reliable,
  # sequenced delivery of datagrams over Infiniband or TCP.
  CONFIG_RDS

  # https://www.kernelconfig.io/CONFIG_TIPC
  # https://en.wikipedia.org/wiki/Transparent_Inter-process_Communication
  # The Transparent Inter Process Communication (TIPC) protocol is
  # specially designed for intra cluster communication. This protocol
  # originates from Ericsson where it has been used in carrier grade
  # cluster applications for many years.
  CONFIG_TIPC

  # https://www.kernelconfig.io/CONFIG_SERIAL_NONSTANDARD
  # Non-standard serial port support
  # Say Y here if you have any non-standard serial boards -- boards
  # which aren't supported using the standard "dumb" serial driver.
  # This includes intelligent serial boards such as
  # Digiboards, etc. These are usually used for systems that need many
  # serial ports because they serve many terminals or dial-in
  # connections.
  CONFIG_SERIAL_NONSTANDARD

  # https://www.kernelconfig.io/CONFIG_NET_9P
  # Plan 9 Resource Sharing Support (9P2000)
  CONFIG_NET_9P
  
  # https://www.kernelconfig.io/CONFIG_HID_PXRC
  # Support for PhoenixRC HID Flight Controller, a 8-axis flight controller.
  CONFIG_HID_PXRC

  # https://www.kernelconfig.io/CONFIG_USB_TRANCEVIBRATOR
  # PlayStation 2 Trance Vibrator driver support
  CONFIG_USB_TRANCEVIBRATOR

  # https://www.kernelconfig.io/CONFIG_MCTP
  # https://en.wikipedia.org/wiki/Management_Component_Transport_Protocol
  # MCTP core protocol support
  CONFIG_MCTP

  # ADC with mismatched value that has to be set directly
  # https://www.kernelconfig.io/CONFIG_VIDEO_CS3308
  CONFIG_VIDEO_CS3308

  # AVE with mismatched value that has to be set directly
  # https://www.kernelconfig.io/CONFIG_VIDEO_SAA6752HS
  CONFIG_VIDEO_SAA6752HS
)

for config_to_disable in "${configs_to_disable[@]}"; do
  echo "# ${config_to_disable} is not set" >> kernel-local
done

sed -i 's/^# define buildid .*$/%define buildid .secureblue/' kernel.spec

mv * ../..
cd ../..
