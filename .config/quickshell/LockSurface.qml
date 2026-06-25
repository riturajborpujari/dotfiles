import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import Quickshell

import "config.js" as Config

Rectangle {
	id: root
	required property LockContext context
	color: "#181818"

	Column {
		anchors {
			right: parent.right
			rightMargin: 24
		}

		Text {
			anchors.right: parent.right
			anchors.rightMargin: 0
			color: "#666666"

			// The native font renderer tends to look nicer at large sizes.
			renderType: Text.NativeRendering
			font.pointSize: 72

			// updated when the date changes
			text: Qt.formatDateTime(clock.date, "HH:mm")
		}

		Text {
			anchors.right: parent.right
			anchors.rightMargin: 0
			color: "#666666"

			// The native font renderer tends to look nicer at large sizes.
			renderType: Text.NativeRendering
			font.pointSize: 48

			// updated when the date changes
			text: Qt.formatDateTime(clock.date, "ddd, d MMM")
		}
	}

	ColumnLayout {
		spacing: 32
		anchors {
			horizontalCenter: parent.horizontalCenter
			verticalCenter: parent.verticalCenter
		}
		// Uncommenting this will make the password entry invisible except on the active monitor.
		visible: Window.active

		Avatar {
			width: 128
			height: 128
			Layout.alignment: Qt.AlignHCenter
		}

		Label {
			Layout.alignment: Qt.AlignHCenter
			renderType: Text.NativeRendering
			font.pointSize: 24
			color: "#d0d0d0"

			text: Config.user.name
		}

		RowLayout {
			Layout.alignment: Qt.AlignHCenter

			TextField {
				id: passwordBox

				implicitWidth: 400
				padding: 10

				focus: true
				enabled: !root.context.unlockInProgress
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhSensitiveData

				// Update the text in the context when the text in the box changes.
				onTextChanged: root.context.currentText = this.text;

				// Try to unlock when enter is pressed.
				onAccepted: root.context.tryUnlock();

				// Update the text in the box to match the text in the context.
				// This makes sure multiple monitors have the same text.
				Connections {
					target: root.context

					function onCurrentTextChanged() {
						passwordBox.text = root.context.currentText;
					}
				}
			}

			Button {
				text: "Unlock"
				padding: 10

				// don't steal focus from the text box
				focusPolicy: Qt.NoFocus

				enabled: !root.context.unlockInProgress && root.context.currentText !== "";
				onClicked: root.context.tryUnlock();
			}
		}

		Label {
			visible: root.context.showFailure
			text: "Incorrect password"
			color: "#dd2222"
		}
	}

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
