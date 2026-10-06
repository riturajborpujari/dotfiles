import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
	spacing: 0
	height: parent.height

	Rectangle {
		Layout.fillHeight: true
		implicitWidth: 30
		color: "#10dddddd"
		border.width: 1
		border.color: "#303030"

		Text {
			anchors.centerIn: parent
			text: Hyprland.focusedWorkspace?.id?? ""
			
			font {
				family: root.fontFamily
				pixelSize: root.fontSize
			}
			color: "#44aaff"
		}
	}

	Rectangle {
		Layout.fillHeight: true
		width: {
			if (Hyprland.focusedWorkspace?.toplevels.values.length != 0) {
				return activeWindow.width + 20
			} else {
				return activeWindow.width
			}
		}
		color: "transparent"
		
		Text {
			id: activeWindow
			anchors.verticalCenter: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter
			
			text: {
				if (Hyprland.focusedWorkspace?.toplevels.values.length != 0) {
					return Hyprland.activeToplevel?.title?? "";
				} else {
					return ""
				}
			}

			elide: Text.ElideRight
			font {
				family: root.fontFamily
				weight: 400
				pixelSize: root.fontSize
			}
			color: "#d0d0d0"
		}
	}
}
