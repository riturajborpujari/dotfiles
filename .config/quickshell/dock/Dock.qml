import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
	id: root
	anchors {
		bottom: true
		left: true
		right: true
	}

	property real margin: 8
	property real iconSize: 36
	property var pinnedApps: [
		"firefox",
		"foot",
		"thunar",
		"guitarix",
		"libreoffice-writer",
		"libreoffice-calc",
		"libreoffice-impress",
	]
	property var apps: DesktopEntries.applications.values
		.filter(app => pinnedApps.includes(app.id))
		.sort((a, b) => pinnedApps.indexOf(a.id) - pinnedApps.indexOf(b.id))
	property bool isActive: false
	
	function launchEntry(entry) {
		if (entry.runInTerminal) {
			Quickshell.execDetached(["xdg-terminal-exec", entry.execString]);
		} else {
			entry.execute()
		}
	}
	
	aboveWindows: true
	focusable: true
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
	exclusionMode: ExclusionMode.Ignore
	implicitHeight: iconSize + margin * 2
	color: "transparent"

	MouseArea {
		id: mouseArea
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		height: iconSize + margin * 2
		width: (apps.length + 1) * iconSize + margin
		hoverEnabled: true

		onContainsMouseChanged: {
			if (isActive && !this.containsMouse) {
				isActive = false
			}
		}

		MouseArea {
			id: bottomArea
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			width: (apps.length + 1) * iconSize + margin
			height: 8
			hoverEnabled: true

			onContainsMouseChanged: {
				if (!isActive && this.containsMouse) {
					isActive = true
				}
			}
		}

		Rectangle {
			id:  main
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.margins: margin
			height: iconSize + margin
			width: (apps.length + 1) * iconSize + margin
			color: shell.mode=="dark"?"#66000000":"#66ffffff"
			radius: shell.radius

			// Slide up when mouse enters bottom-area or workspace is empty
			property bool emptyWorkspace:
			Hyprland.focusedWorkspace?.toplevels.values.length == 0
			property bool showDock: isActive || emptyWorkspace;
		
			anchors.bottomMargin: showDock? margin:-height
			Behavior on anchors.bottomMargin {
				NumberAnimation {
					duration: 400
					easing.type: Easing.OutCubic
				}
			}
			
			RowLayout {
				anchors.verticalCenter: parent.verticalCenter
				anchors.horizontalCenter: parent.horizontalCenter
				spacing: 0
				height: parent.height
				
				Rectangle {
					width: iconSize
					height: parent.height
					color: "transparent"

					Button {
						anchors.fill: parent
						flat: true
						background: IconImage {
							source: Quickshell.iconPath("kdenlive-menu")//Qt.resolvedUrl("open_app_drawer_button.svg")
							implicitSize: iconSize - margin * 1.5
							anchors.centerIn: parent
						}

						onClicked: {
							Quickshell.execDetached(["hyprctl", "dispatch", 'hl.dsp.global("quickshell:launcher")'])
						}
					}
				}
				
				Repeater {
					model: apps

					delegate: Rectangle {
						width: iconSize
						height: parent.height
						color: "transparent"

						Button {
							anchors.fill: parent
							flat: true
							background: IconImage {
								source: Quickshell.iconPath(modelData.icon)
								implicitSize: iconSize - margin * 1.5
								anchors.centerIn: parent
							}

							onClicked: launchEntry(modelData)
						}
					}
				}
			}
		}
	}
}
