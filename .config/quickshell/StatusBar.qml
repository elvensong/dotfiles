import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import "modules/IconButton"
import "modules/SideBar"
import "themes"
import "widgets/NetworkWidget"
import "process/LoadConfig"

PanelWindow	{
	id: statusBar

	readonly property QtObject theme: ThemeManager.currentTheme
	signal enterIcon(QtObject iconMA, string actionType)
	implicitWidth: 50
	color: theme.background
	anchors {
		top: true
		left: true
		bottom: true
	}

	WSContainer {}

	Column {
		id: bottomBlock
		anchors {
			left: parent.left
			right: parent.right
			bottom: parent.bottom
		}
		width: parent.width
		spacing: 10

		// Top spacer to push content down
		Item { Layout.fillHeight: true }

		Button {
			anchors.horizontalCenter: parent.horizontalCenter
			onClicked: { LoadConfig.loadConfig.running = true }
		}

		SystemTrayPanel {
			width: parent.width
			parentWindow: statusBar
		}

		// Network Widget with margins
		NetworkWidget {
			id: networkWidget
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Clock {
			anchors.horizontalCenter: parent.horizontalCenter
		}

		IconButton {
			id: powerBtn
			anchors.horizontalCenter: parent.horizontalCenter
			actionType: "power"
			icon: "⏻"
			fontSize: 27
			iconColor: theme.negative
			onClicked: {
				statusBar.enterIcon(powerBtn.mouseArea, powerBtn.actionType)
			}
		}

		// Bottom margin
		Item { height: 10; width: 1 }

		Component.onCompleted: {
			networkWidget.enterIcon.connect(enterIcon)
		}
	}
}
