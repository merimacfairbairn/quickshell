pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

import Quickshell.Wayland

Singleton {
  id: root

  property var focusState: WlrKeyboardFocus.None

  signal closeLogoutMenu
  signal logoutMenu

  onCloseLogoutMenu: {
	root.focusState = WlrKeyboardFocus.None;
  }

  IpcHandler {
	function openLogoutMenu(): void {
	  root.logoutMenu();
	  root.focusState = WlrKeyboardFocus.Exclusive;
	}

	target: "root"
  }
}
