import QtQuick

Rectangle {
	property string time

	anchors {
		verticalCenter: parent.verticalCenter
		right: parent.right
		rightMargin: 8
	}

	width: timetext.width
	height: timetext.height
	color: "#000000ff"

	Text {
		id: timetext
		text: time
		color: "#30d020"

		font {
			family: "Iosevka"
			weight: 600
			pixelSize: 14
		}
	}
}
