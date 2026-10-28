import Quickshell
import Quickshell.Services.Polkit
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Scope {
	property real margin: 8
	property string agentMsg: ""
	property string agentMsgColor: "#d0d0d0"

	function setAgentMsg(msg: string, color: string) {
		agentMsg = msg
		agentMsgColor = color
	}
	
	PolkitAgent {
		id: agent

		onIsActiveChanged: {
			if (agent.isActive) {
				setAgentMsg(agent.flow?.message?? "Please proceed", "#d0d0d0")
			}
		}

		onFlowChanged: {
			if (agent.flow) {
				agent.flow.authenticationFailed.connect(function() {
					passwordField.enabled = true;
					passwordField.clear();
					passwordField.forceActiveFocus();
					setAgentMsg("Authentication Failed", "red")					
				})

				agent.flow.authenticationSucceeded.connect(function() {
					passwordField.enabled = true
					passwordField.clear();
					passwordField.forceActiveFocus();
				})

				passwordField.textChanged.connect(() => setAgentMsg(agent.flow.message, "#d0d0d0"));
			}
		}
	}
	
	PanelWindow {	
		id: pkAgentWindow
		anchors {
			top: true
		}
		implicitWidth: 540
		implicitHeight: container.height + margin * 4

		visible: agent.isActive
		focusable: true
		aboveWindows: true
		exclusionMode: ExclusionMode.Ignore
		color: "transparent"

		Rectangle {
			anchors.fill: parent
			anchors.margins: margin
			border {
				color: "#303030"
				width: 1
			}
			color: "#dd000000"
			radius: shell.radius

			ColumnLayout {
				id: container
				anchors.top: parent.top
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.margins: margin
				spacing: margin * 2
				
				Text {
					Layout.fillWidth: true
					Layout.rightMargin: margin
					Layout.leftMargin: margin
					Layout.topMargin: margin

					horizontalAlignment: Text.AlignHCenter
					text: "Authentication Required"
					color: "#44aaff"

					font.weight: 800
					font.pointSize: 18
				}

				Text {
					Layout.fillWidth: true
					Layout.rightMargin: margin
					Layout.leftMargin: margin

					horizontalAlignment: Text.AlignHCenter
					text: agentMsg
					color: agentMsgColor
					wrapMode: Text.WordWrap
				}

				TextField {
					id: passwordField
					Layout.fillWidth: true
					Layout.rightMargin: margin * 2
					Layout.leftMargin: margin * 2

					focus: true
					echoMode: TextField.Password
					inputMethodHints: Qt.ImhSensitiveData | Qt.ImhHiddenText | Qt.ImhNoPredictiveText

					background: Rectangle {
						color: "#20ffffff"
						radius: shell.radius
					}
					font.pointSize: 12
					leftPadding: margin
					topPadding: margin
					bottomPadding: margin
					placeholderText: "Password Please..."

					color: enabled? "#d0d0d0":"#404040"

					Keys.onPressed: (event) => {
						if (event.key === Qt.Key_Escape) {
							onCancel();
							event.accepted = true;
						}
					}
					onAccepted: onSubmit();
				}

				
				Rectangle {
					Layout.fillWidth: true
					Layout.rightMargin: margin
					Layout.leftMargin: margin
					Layout.bottomMargin: margin

					height: childrenRect.height
					color: "transparent"

					RowLayout {
						anchors.right: parent.right
						spacing: margin
						
						Button {
							id: btnCance
							Layout.alignment: Qt.AlignRight
							
							flat: true
							contentItem: Text {
								text: "Cancel"
								color: parent.hovered?"#44aaff":"#888888"
								horizontalAlignment: Text.AlignHCenter
								font.pointSize: 12
							}
							background: Rectangle { color: "transparent" }

							onClicked: onCancel()
						}

						Button {
							id: btnSubmit
							Layout.alignment: Qt.AlignRight
							background: Rectangle {
								color: "#44aaff"
								radius: shell.radius
							}
							contentItem: Text {
								text: "Submit"
								horizontalAlignment: Text.AlignHCenter
								color: "#181818"
								font.pointSize: 12
							}

							onClicked: onSubmit();
						}
					}
				}
			}
		}
	}

	function onCancel() {
		passwordField.clear();
		if (agent.flow) {
			agent.flow.cancelAuthenticationRequest();
		}
	}

	function onSubmit() {
		if (agent.flow) {
			agent.flow.submit(passwordField.text)
		}
	}
}
