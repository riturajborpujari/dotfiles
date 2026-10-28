import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
	spacing: 0
	height: parent.height

	Rectangle {
		Layout.fillHeight: true
		implicitWidth: 30
		color: shell.mode=="dark"?"#282828":"#efefef"
		border.width: 0
		border.color: shell.mode == "dark"?"#303030":"#efefef"
		topLeftRadius: shell.radius
		bottomLeftRadius: shell.radius

		Text {
			anchors.centerIn: parent
			text: Hyprland.focusedWorkspace?.id?? ""
			
			font {
				family: root.fontFamily
				pixelSize: root.fontSize
			}
			color: shell.mode=="dark"?"#efefef":"#181818"
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
			color: shell.mode=="dark"?"#efefef":"#181818"
		}
	}
}
