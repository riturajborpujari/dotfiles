import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell

Item {
	Image {
		id: avatar
		anchors.fill: parent
		source: "file://" + Quickshell.env("HOME") + "/.config/quickshell/avatar.jpg"
		fillMode: Image.PreserveAspectCrop
		visible: false
	}

	Rectangle {
		id: mask
		anchors.fill: parent
		radius: width / 2
		visible: false
	}

	OpacityMask {
		anchors.fill: parent
		source: avatar
		maskSource: mask
	}
}
