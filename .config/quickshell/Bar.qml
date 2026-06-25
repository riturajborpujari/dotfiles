import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Scope {
	id: root
	property string time: {
		Qt.formatDateTime(clock.date, "ddd, d MMM | HH:mm")
	}

	PanelWindow {
		anchors {
			bottom: true
			left: true
			right: true
		}
		color: "#000000ff"
		implicitHeight: 24

		Rectangle {
			anchors.fill: parent
			height: parent.height
			color: "#181818"
			border {
				color: "#484848"
			}

			RowLayout {
				width: parent.width
				height: parent.height
				spacing: 10

				Workspaces {
					Layout.alignment: Qt.AlignLeft
				}

				Clock {
					Layout.alignment: Qt.AlignRight
					time: root.time
				}
			}
		}
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
