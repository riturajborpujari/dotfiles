command=$(echo -e "Applications\nBluetooth\nKill\nCalculate\nKeyboard layout\nLock\nSleep\nSignout\nHibernate\nPoweroff\nToggle Appearance" | tofi)

case $command in
    Applications)
        tofi-drun --drun-launch true --prompt "Application> "
        ;;
    Lock)
        loginctl lock-session
        ;;
    Sleep)
        systemctl sleep
        ;;
    Signout)
		hyprctl dispatch "hl.dsp.exit()"
        ;;
	Hibernate)
		systemctl hibernate
		;;
    Poweroff)
        systemctl poweroff
        ;;
    Bluetooth)
		deviceNames=$(bluetoothctl devices | cut -d ' ' -f3-)
        deviceName=$(echo ${deviceNames} | tofi --prompt "Bluetooth connect>")
        deviceId=$(bluetoothctl devices | grep "${deviceName}" | cut -d ' ' -f2)
        bluetoothctl connect $deviceId
        ;;
    Kill)
        process=$(ps -a --format "%c" | tail -n+2 | tofi --prompt "Kill>")
        kill -2 $(pidof ${process})
        ;;
    Calculate)
        result=$(echo "" | tofi --require-match false --prompt "Calculate> " | bc)
        echo $result | tofi --require-match false --prompt "result= " | wl-copy
        ;;
	'Keyboard layout')
        layout=$(echo -e "US English\nAxomiya" | tofi --prompt "Layout> ")
		case $layout in
			'US English')
				hyprctl switchxkblayout 'keyd-virtual-keyboard' 0
				;;
			Axomiya)
				hyprctl switchxkblayout 'keyd-virtual-keyboard' 1
				;;
		esac
		;;
	'Toggle Appearance')
		hyprctl eval 'switch_color_scheme()'
	   ;;
esac
