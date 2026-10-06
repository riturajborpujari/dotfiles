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
	Bar{}
	Wallpaper{}
	LockScreen{}
	PkAgent{}

	Launcher{}
	Dock{}
}
