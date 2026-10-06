import Quickshell
import Quickshell.Services.Polkit
import QtQuick
import QtQuick.Controls

Scope {
	PolkitAgent {
		id: agent

		onFlowChanged: {
			if (agent.flow) {
				agent.flow.authenticationFailed.connect(function() {
					polkitError.visible = true;
					passwordField.enabled = true;
					passwordField.clear();
					passwordField.forceActiveFocus();
				})

				agent.flow.authenticationSucceeded.connect(function() {
					passwordField.enabled = true
					passwordField.clear();
					passwordField.forceActiveFocus();
				})
			}
		}
	}
	
	PanelWindow {	
		id: pkAgentWindow
		anchors {
			top: true
			left: true
			right: true
		}
		color: "transparent"
		implicitWidth: container.width + 40
		implicitHeight: container.height + 85

		focusable: true
		visible: agent.isActive
		aboveWindows: true
		exclusionMode: ExclusionMode.Ignore

		Rectangle {
			id: container
			color: "#dd000000"
			border {
				color: "#303030"
				width: 1
			}
			radius: 4
			anchors.centerIn: parent

			width: content.width + 80
			height: content.height + 64

			Column {
				id: content
				anchors.centerIn: parent
				width: 400
				spacing: 20
				
				Text {
					color: "#efefef"
					text: agent.flow?.message?? "Authentication Required. Please enter your Password"
					horizontalAlignment: Text.AlignHCenter
					wrapMode: Text.WordWrap
					width: parent.width - 10
					anchors.horizontalCenter: parent.horizontalCenter
					font.pixelSize: 20
				}

				Text {
					id: polkitError
					visible: false
					color: "#ff4455"
					text: "Authentication Failed"
					anchors.horizontalCenter: parent.horizontalCenter
				}

				TextField {
					id: passwordField
					echoMode: TextField.Password
					height: 40
					focus: true
					inputMethodHints: Qt.ImhSensitiveData | Qt.ImhHiddenText | Qt.ImhNoPredictiveText

					horizontalAlignment: Text.AlignHCenter
					width: parent.width
					color: {
						if (this.enabled) {
							return "#44aaff";
						} else {
							return "#666666";
						}
					}
					background: Rectangle {
						color: {
							if (passwordField.enabled) {
								return "#363636";
							} else {
								return "#444444";
							}
						}
						radius: 4
					}

					Keys.onPressed: (event) => {
						if (event.key === Qt.Key_Escape) {
							cancelButton.clicked();
							event.accepted = true;
						} else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
							submitButton.clicked();
							event.accepted = true;
						}
					}

					onTextChanged: {
						if (this.text.length > 0) {
							polkitError.visible = false
						}
					}
				}

				Row {
					anchors.right: parent.right
					spacing: 10

					Button {
						id: cancelButton
						flat: true
						contentItem: Text {
							text: "Cancel"
							color: "#444444"
							horizontalAlignment: Text.AlignHCenter
						}

						onClicked: {
							if (agent.flow) {
								agent.flow.cancelAuthenticationRequest()
							}
						}
					}

					Button {
						id: submitButton
						background: Rectangle {
							color: "#44aaff"
							radius: 4
						}
						contentItem: Text {
							horizontalAlignment: Text.AlignHCenter
							text: "Submit"
							color: "#101010"
						}

						onClicked: {
							if (agent.flow) {
								passwordField.enabled = false
								agent.flow.submit(passwordField.text)
							}
						}
					}
				}
			}
		}
	}
}
