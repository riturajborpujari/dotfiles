import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {
	WlrLayershell.layer: WlrLayer.Background
	color: "transparent"

	anchors {
		top: true
		left: true
		right: true
		bottom: true
	}

	WlrLayershell.exclusionMode: ExclusionMode.Ignore
	WlrLayershell.namespace: "wallpaper"

	Image {
		anchors.fill: parent
		fillMode: Image.PreserveAspectCrop
		source: "file://" + Quickshell.env("HOME") + "/Pictures/wallpaper.jpg"
	}
}
