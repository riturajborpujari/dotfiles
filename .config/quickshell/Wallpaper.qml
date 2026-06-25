import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {
	WlrLayershell.layer: WlrLayer.Background
	color: "#000000"

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
		source: "file://" + Quickshell.env("HOME") + "/pictures/wallpapers/current.jpg"
	}

	Column {
		anchors {
			top: parent.top
			right: parent.right
			rightMargin: 24
		}

		Text {
			anchors.right: parent.right
			color: "#282828"

			// The native font renderer tends to look nicer at large sizes.
			renderType: Text.NativeRendering
			font.pointSize: 72

			// updated when the date changes
			text: Qt.formatDateTime(clock.date, "HH:mm")
		}

		Text {
			anchors.right: parent.right
			color: "#282828"

			// The native font renderer tends to look nicer at large sizes.
			renderType: Text.NativeRendering
			font.pointSize: 48

			// updated when the date changes
			text: Qt.formatDateTime(clock.date, "ddd, d MMM")
		}
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
