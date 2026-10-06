import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle {
	required property LockContext context
	property real margin: 8
	color: "#181818"

	Image {
		source: Qt.resolvedUrl("background.jpg")
		anchors.fill: parent
	}
	
	Rectangle {
		anchors.centerIn: parent
		height: 400
		width: 560
		radius: 4
		color: "#dd000000"

		Column {
			anchors.centerIn: parent
			anchors.margins: margin * 4
			spacing: margin * 2
			
			Image {
				source: Qt.resolvedUrl("avatar.jpg")
				anchors.horizontalCenter: parent.horizontalCenter
				width: 150
				height: 150
				layer.enabled: true
				layer.effect: OpacityMask {
					maskSource: Rectangle {
						width: 150
						height: 150
						radius: 75
					}
				}
			}

			Text {
				text: "Rituraj Borpujari"
				anchors.horizontalCenter: parent.horizontalCenter
				color: "#d0d0d0"
				font.pixelSize: 28
			}

			TextField {
				id: passwordField
				focus: true
				width: 320
				height: 40
				placeholderText: "Password please..."
				horizontalAlignment: TextInput.AlignHCenter
				color: "#efefef"
				font.pixelSize: 18
				background: Rectangle {
					color: "#10ffffff"
					border {
						width: 1
						color: "#202020"
					}
				}
    			
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhHiddenText | Qt.ImhSensitiveData
				enabled: !context.unlockInProgress
				onTextChanged: context.currentText = this.text;
    			onAccepted: context.tryUnlock();
			}

			Label {
    			visible: context.showFailure
    			text: "Incorrect password"
    			color: "#dd2222"
    		}
			
			Button {
				text: "Unlock"
				anchors.horizontalCenter: parent.horizontalCenter
				enabled: passwordField.text.length != 0 && !context.unlockInProgress

				background: Rectangle {
					color: enabled? "#44aaff": "#404040"
					implicitWidth: 90
					radius: 4
				}
				contentItem: Text {
					color: "#181818"
					text: "Unlock"
					font.pixelSize: 18
					horizontalAlignment: Text.AlignHCenter
				}

				onPressed: context.tryUnlock();
			}
		}					
	}
}
