#!/usr/bin/env python3
# Sends a Wake-on-LAN magic packet to a hardcoded MAC address over the local broadcast network.

import socket, binascii, os
mac = os.environ['PC_MAC']
data = 'FF' * 6 + mac.replace(':', '') * 16
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
sock.sendto(binascii.unhexlify(data), ('10.0.255.255', 9))
