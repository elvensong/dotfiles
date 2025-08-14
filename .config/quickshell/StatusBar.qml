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

	ColumnLayout {
		anchors.bottom:parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		spacing: 5
		id: bottomBlock
		//Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

		SystemTrayPanel {
			parentWindow: statusBar
		}

		NetworkWidget {
			id: networkWidget
		}

		Component.onCompleted: {
			networkWidget.enterIcon.connect(enterIcon)
		}

		Clock {
		}

		IconButton {
			id: powerBtn
			actionType: "power"
			//Layout.alignment: Qt.AlignHCenter
			icon: "⏻"                      // Alternate icon (power)
			fontSize: 27
			iconColor: theme.negative
			onClicked: {
				statusBar.enterIcon(powerBtn.mouseArea, powerBtn.actionType)
			}
		}
	}
}
