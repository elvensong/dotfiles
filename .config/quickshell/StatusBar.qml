import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import "modules/IconButton"
import "modules/Theme"
import "modules/SideBar"
import "widgets/NetworkWidget"

PanelWindow	{
	id: statusBar
	signal enterIcon(QtObject iconMA, string actionType)
	screen: Quickshell.screens[0]
	implicitWidth: 50
	anchors {
		top: true
		left: true
		bottom: true
	}

	WSContainer {

	}

	ColumnLayout {
		anchors.bottom:parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		spacing: 5
		//Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

		NetworkWidget {
			id: networkWidget
		}

		Component.onCompleted: {
			networkWidget.enterIcon.connect(enterIcon)
		}

		Clock {}

		IconButton {
			id: powerBtn
			actionType: "power"
			Layout.alignment: Qt.AlignHCenter
			icon: ""                      // Alternate icon (power)
			fontFamily: "Font Awesome 6 Free"
			fontSize: 25
			iconColor: Theme.primary
			hoverColor: "#d08770"
			onEntered: {
				statusBar.enterIcon(powerBtn.mouseArea, powerBtn.actionType)
			}
		}
	}
}
