import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

RowLayout {
	height: parent.height
	Layout.rightMargin: 32
	spacing: 8

	Rectangle {
		Layout.fillHeight: true
		implicitWidth: 20
		color: "transparent"

		MouseArea {
			anchors.fill: parent
			onClicked: adapterDefault.enabled = !adapterDefault.enabled
		}
		
		Image {
			anchors.centerIn: parent
			id: notificon
			source: Qt.resolvedUrl("icon-notif.svg")
			width: 20
			height: 20
		}

		MultiEffect {
			source: notificon
			anchors.fill: notificon
			colorization: 1.0
			colorizationColor: adapterDefault.enabled?"#44aaff":"#484848"
		}
	}

	Rectangle {
		Layout.fillHeight: true
		implicitWidth: 20
		color: "transparent"

		MouseArea {
			anchors.fill: parent
			onClicked: adapterDefault.enabled = !adapterDefault.enabled
		}
		
		Image {
			anchors.centerIn: parent
			id: bticon
			source: Qt.resolvedUrl("icon-bluetooth.svg")
			width: 20
			height: 20
		}

		MultiEffect {
			source: bticon
			anchors.fill: bticon
			colorization: 1.0
			colorizationColor: adapterDefault.enabled?"#44aaff":"#484848"
		}
	}

	Rectangle {
		Layout.fillHeight: true
		Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
		implicitWidth: 20
		color: "transparent"

		Image {
			anchors.centerIn: parent
			id: iconWifi
			mipmap: true
			source: Qt.resolvedUrl("icon-wifi.svg")
			width: 20
			height: 20
		}

		MultiEffect {
			source: iconWifi
			anchors.fill: iconWifi
			colorization: 1.0
			colorizationColor: "#44aaff"
			
		}
	}

	Rectangle {
		Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
		Layout.fillHeight: true
		width: 165
		color: "#10dddddd"

		Text {
			anchors.centerIn: parent
			text: time
			color: "#44aaff"
			font {
				family: root.fontFamily
				pixelSize: root.fontSize
			}
		}
	}
}
