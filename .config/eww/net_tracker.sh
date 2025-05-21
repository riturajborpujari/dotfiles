#!/usr/bin/env bash

eww update netSpeed="offline"
OFFLINE=true

while true; do
    INTERFACE=$(ip route | grep default | cut -d ' ' -f5)
    if [ -z $INTERFACE ]; then
        if [ $OFFLINE = 'false' ]; then
            eww update netSpeed="offline"
            OFFLINE=true
        fi
        sleep 2
        continue
    fi

    OLD_RX=$(cat /proc/net/dev | grep $INTERFACE | tr ':' ' ' | awk '{print $2}')
    if [ -z $OLD_RX ]; then
        continue
    fi
    OLD_TX=$(cat /proc/net/dev | grep $INTERFACE | tr ':' ' ' | awk '{print $10}')
    if [ -z $OLD_TX ]; then
        continue
    fi
    sleep 1
    NEW_RX=$(cat /proc/net/dev | grep $INTERFACE | tr ':' ' ' | awk '{print $2}')
    if [ -z $NEW_RX ]; then
        continue
    fi
    NEW_TX=$(cat /proc/net/dev | grep $INTERFACE | tr ':' ' ' | awk '{print $10}')
    if [ -z $NEW_TX ]; then
        continue
    fi

    RX=$((($NEW_RX - $OLD_RX) / 1024 ))
    TX=$((($NEW_TX - $OLD_TX) / 1024 ))

    eww update netSpeed="↓${RX}KB/s ↑${TX}KB/s"
    OFFLINE=false
done;
