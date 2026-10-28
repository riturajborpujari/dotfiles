import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Scope {
	id: root
	property string time: {
		Qt.formatDateTime(clock.date, "ddd, d MMM | HH:mm")
	}
	property int fontSize: 16
	property string fontFamily: "Iosevka Light"
	property real margin: 8

	PanelWindow {
		anchors {
			top: true
			left: true
			right: true
		}
		margins {
			top: 8
			left: 8
			right: 8
		}
		implicitHeight: 27
		exclusiveZone: 28
		color: "transparent"

		Rectangle {
			radius: shell.radius
			anchors.fill: parent
			height: parent.height
			color: (shell.mode=="dark")?"#dd000000":"#aaffffff"

			RowLayout {
				anchors.fill: parent
				spacing: 0

				Rectangle {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignLeft

					Workspaces{}
				}

				Rectangle {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignRight
					width: childrenRect.width
					color: "transparent"

					ControlCenter{}
				}
			}
		}
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
