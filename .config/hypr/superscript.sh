command=$(echo -e "Applications\nBluetooth\nKill\nCalculate\nKeyboard layout\nLock\nSleep\nSignout\nPoweroff" | tofi)

case $command in
    Applications)
        tofi-drun --drun-launch true --prompt "Application "
        ;;
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
    Bluetooth)
		declare -a deviceNames=("SI-109BT", "Infinity Glide 510", "Airpods Pro")
		declare -A deviceIds
		deviceIds["SI-109BT"]="1E:A6:4B:71:A4:B9"
		deviceIds["Infinity Glide 510"]="00:1E:7C:95:C3:4C"
		deviceIds["Airpods Pro"]="40:ED:CF:EE:FF:22"
        deviceName=$(echo ${deviceNames[@]} | sed 's/, /\n/g' | tofi --prompt "Bluetooth connect ")
        deviceId=${deviceIds[$deviceName]}
        bluetoothctl connect $deviceId
        ;;
    Kill)
        process=$(ps -a --format "%c" | tail -n+2 | tofi --prompt "Kill ")
        kill -2 $(pidof ${process})
        ;;
    Calculate)
        result=$(echo "" | tofi --require-match false --prompt "Calculate " | bc)
        echo $result | tofi --require-match false --prompt "result= " | wl-copy
        ;;
	'Keyboard layout')
        layout=$(echo -e "US English\nAxomiya" | tofi --prompt "Layout ")
		case $layout in
			'US English')
				hyprctl switchxkblayout 'keyd-virtual-keyboard' 0
				;;
			Axomiya)
				hyprctl switchxkblayout 'keyd-virtual-keyboard' 1
				;;
		esac
		;;
esac
