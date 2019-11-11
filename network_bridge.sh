#!/bin/sh
cp /etc/resolv.conf /tmp/resolv.conf
ip route del default via [default_gateway] dev [interface] proto dhcp metric 100
ip route add [internal range: 192.168.1.1/24] via [default_gateway] dev [other interface]
sleep 5
mv /tmp/resolv.conf /etc/resolv.conf
