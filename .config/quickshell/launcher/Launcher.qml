import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

PanelWindow {
	id: root
	anchors {
		top: true
		right: true
		left: true
	}

	visible: false
	focusable: true
	aboveWindows: true
	exclusionMode: ExclusionMode.Ignore
	color: "transparent"
	implicitHeight: main.height + 85

	GlobalShortcut {
		appid: "quickshell"
		name: "launcher"

		onPressed: root.visible = true
	}

	HyprlandFocusGrab {
		id: grab
		active: true
		windows: [root]
		onActiveChanged: active = true
    }

	function launchEntry(entry) {
		if (entry.runInTerminal) {
			Quickshell.execDetached(["xdg-terminal-exec", entry.execString]);
		} else {
			entry.execute()
		}
		resetLauncher();
		root.visible = false
	}

	function resetLauncher() {
		searchField.clear();
		applicationList.currentIndex = 0;
	}

	Rectangle {
		id: main

		Keys.onPressed: (event) => {
			if (event.key === Qt.Key_Escape) {
				resetLauncher();
				root.visible = false;
				event.accepted = true;
			} else if (event.key === Qt.Key_Down || (event.key === Qt.Key_N && event.modifiers & Qt.ControlModifier)) {
				applicationList.currentIndex = applicationList.currentIndex + 1;
				if (applicationList.currentIndex === applicationList.count) {
					applicationList.currentIndex = applicationList.count - 1;
				}
				event.accepted = true;
			} else if (event.key === Qt.Key_Up || (event.key === Qt.Key_P && event.modifiers & Qt.ControlModifier)) {
				applicationList.currentIndex = applicationList.currentIndex -1;
				if (applicationList.currentIndex < 0) {
					applicationList.currentIndex = 0;
				}
				event.accepted = true;
			} else if (event.key === Qt.Key_Return || event.key == Qt.Key_Enter) {
				launchEntry(applicationList.currentItem.modelData);
				event.accepted = true;
			}
		}
		
		color: "#dd000000"
		height: content.height + 64
		width: content.width + 64
		anchors.centerIn: parent
		border {
			width: 1
			color: "#282828"
		}
		radius: 4

		Column {
			id: content
			anchors.centerIn: parent
			
			width: 400
			height: 590
			spacing: 4

			TextField {
				id: searchField
				
				anchors.horizontalCenter: parent.horizontalCenter				
				width: parent.width
				
				focus: true
				height: 50
				font.pixelSize: 24
				leftPadding: 12
				placeholderText: "Search apps"

				background: Rectangle {
					color: "#181818"
					border {
						width: 1
						color: "#202020"
					}
				}
			}

			ClippingRectangle {
				width: parent.width
				height: parent.height - 50
				color: "transparent"
			
				ListView {
					id: applicationList
					anchors.fill: parent
					anchors.horizontalCenter: parent.horizontalCenter

					spacing: 1
					highlight: Rectangle { color: "#44aaff"; radius: 0 }

					model: ScriptModel {
						values: {
							const apps = [...DesktopEntries.applications.values]
								  .filter(el => !el.noDisplay)
								  .sort((a, b) => a.id.localeCompare(b.id))
							const query = searchField.text.toLowerCase().trim();

							if (query === "") {
								return apps;
							}
							return apps.filter(app => app.name && app.name.toLowerCase().includes(query));
						}
						onValuesChanged: {
							applicationList.currentIndex = 0;
						}
					}
					
					delegate: Rectangle {
						required property var modelData
						width: content.width
						height: 50
						color: "#06ffffff"
						radius: 0

						Row {
							anchors.fill: parent
							anchors.margins: 8
							spacing: 12

							Image {
								width: 32
								height: 32
								source: Quickshell.iconPath(modelData.icon)
								fillMode: Image.PreserveAspectFit
							}

							Text {
								anchors.verticalCenter: parent.verticalCenter
								text: modelData.name
								color: "white"
							}
						}

						MouseArea {
							id: mouse
							anchors.fill: parent
							onClicked: launchEntry(modelData)
						}
					}
				}
			}
		}
	}
}
