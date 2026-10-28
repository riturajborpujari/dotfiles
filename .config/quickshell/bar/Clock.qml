import QtQuick

Rectangle {
	property string time

	width: timetext.width + 20
	topRightRadius: shell.radius
	bottomRightRadius: shell.radius
	color: "#44aaff"

	Text {
		id: timetext
		text: time
		color: "#181818"
		anchors.centerIn: parent
		
		font {
			family: root.fontFamily
			pixelSize: root.fontSize
		}
	}
}
