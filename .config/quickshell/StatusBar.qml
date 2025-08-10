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
	implicitWidth: 50
	anchors {
		top: true
		left: true
		bottom: true
	}

	margins {
		left: 10
		top: 10
		bottom: 10
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
