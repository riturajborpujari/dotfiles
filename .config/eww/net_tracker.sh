#!/usr/bin/env bash

echo "offline"
OFFLINE=true

while true; do
    INTERFACE=$(ip route | grep default | cut -d ' ' -f5)
    if [ -z $INTERFACE ]; then
        if [ $OFFLINE = 'false' ]; then
            echo "offline"
            OFFLINE=true
        fi
        sleep 2
        continue
    fi

    stats_dir="/sys/class/net/$INTERFACE/statistics/"

    if [ -z $OLD_RX ]; then
        echo "Initializing..."
        OLD_RX=$(cat "$stats_dir/rx_bytes")
        if [ -z $OLD_RX ]; then
            continue
        fi
        OLD_TX=$(cat "$stats_dir/tx_bytes")
        if [ -z $OLD_TX ]; then
            continue
        fi
    fi
    sleep 1

    NEW_RX=$(cat "$stats_dir/rx_bytes")
    if [ -z $NEW_RX ]; then
        continue
    fi
    NEW_TX=$(cat "$stats_dir/tx_bytes")
    if [ -z $NEW_TX ]; then
        continue
    fi

    RX=$((($NEW_RX - $OLD_RX) / 1024 ))
    TX=$((($NEW_TX - $OLD_TX) / 1024 ))

    echo "↓${RX}KB/s ↑${TX}KB/s"
    OFFLINE=false

    OLD_RX=$NEW_RX
    OLD_TX=$NEW_TX
done;
