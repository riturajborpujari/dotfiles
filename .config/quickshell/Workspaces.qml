import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
	spacing: 8
	height: parent.height

	Rectangle {
		Layout.fillHeight: true
		implicitWidth: 30
		color: "#f5c04b"

		Text {
			anchors.centerIn: parent
			text: Hyprland.focusedWorkspace?.id?? ""
			
			font {
				family: "Iosevka"
				weight: 600
				pixelSize: 14
			}
			color: "#181818"
		}
	}

	Rectangle {
		Layout.fillHeight: true
		Text {
			id: activeWindow
			anchors.verticalCenter: parent.verticalCenter

			text: {
				if (Hyprland.focusedWorkspace?.toplevels.values.length != 0) {
					return Hyprland.activeToplevel?.title?? "";
				} else {
					return ""
				}
			}
			elide: Text.ElideRight
			font {
				family: "Iosevka"
				weight: 400
				pixelSize: 14
			}
			color: "#efefef"
		}
	}
}
