import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

ShellRoot {
	LockContext {
		id: lockContext

		onUnlocked: {
			lock.locked = false;
		}
	}

	WlSessionLock {
		id: lock

		WlSessionLockSurface {
			LockSurface {
				anchors.fill: parent
				context: lockContext
			}
		}
	}

	GlobalShortcut {
		appid: "quickshell"
		name: "lock"

		onPressed: lock.locked = true
	}
}
