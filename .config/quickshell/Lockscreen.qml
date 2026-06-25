import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
	LockContext {
		id: lockContext

		onUnlocked: {
			lock.locked = false;
			Qt.quit()
		}
	}

	WlSessionLock {
		id: lock

		locked: true // start locked
		WlSessionLockSurface {
			LockSurface {
				anchors.fill: parent
				context: lockContext
			}
		}
	}

	IpcHandler {
		target: "sessionLock"

		function lock(): void { lock.locked = true }
		function unlock(): void { lock.locked = false }
	}
}
