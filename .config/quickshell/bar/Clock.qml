import QtQuick

Rectangle {
	property string time

	width: timetext.width + 20
	topRightRadius: 4
	bottomRightRadius: 4
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
