command=$(echo -e "Application\nSystem\nBluetooth\nKill\nCalculate" | tofi)

case $command in
    Application)
        tofi-drun --drun-launch true --prompt "Application "
        ;;
    System)
        sysCommand=$(echo -e "Lock\nSleep\nSignout\nPoweroff\nReboot" | tofi --prompt "System ")
        case $sysCommand in
            Lock)
                loginctl lock-session
                ;;
            Sleep)
                systemctl sleep
                ;;
            Signout)
                hyprctl dispatch exit
                ;;
            Poweroff)
                systemctl poweroff
                ;;
            Reboot)
                systemctl reboot
                ;;
        esac
        ;;
    Bluetooth)
        btDevice=$(bluetoothctl devices | grep Device | awk '{printf "%s %s\n",$3,$2}' | tofi --prompt "Bluetooth connect ")
        deviceId=$(echo $btDevice | awk '{print $2}')
        bluetoothctl connect $deviceId
        ;;
    Kill)
        process=$(ps -u $USER -o pid,comm | tail -n+2 | tofi --prompt "Kill ")
        kill -2 $(echo $process | awk '{print $1}')
        ;;
    Calculate)
        result=$(echo "" | tofi --require-match false --prompt "Calculate " | bc)
        echo $result | tofi --require-match false --prompt "result= " | wl-copy
        ;;
esac
