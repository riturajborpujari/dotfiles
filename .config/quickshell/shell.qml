import Quickshell
import Quickshell.Hyprland
import QtQuick

import "./bar"
import "./pkagent"
import "./launcher"
import "./dock"
import "./lockscreen"
import "./wallpaper"

Scope {
	id: shell
	property string mode: "dark"
	property real radius: 4

	GlobalShortcut {
		appid: "quickshell"
		name: "color-light"
		onPressed: shell.mode = "light"
	}
	GlobalShortcut {
		appid: "quickshell"
		name: "color-dark"
		onPressed: shell.mode = "dark"
	}
	
	Bar{}
	Wallpaper{}
	LockScreen{}
	PkAgent{}

	Launcher{}
	Dock{}
}
