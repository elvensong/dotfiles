// SidePanel.qml
import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Wayland
import QtQuick.Layouts
import "../../modules/IconButton"
import "../../modules/Theme"
import QtQuick.Effects

Rectangle {
	id: sideBar
	topRightRadius: 15
	implicitWidth: contentColumn.implicitWidth
	implicitHeight: contentColumn.implicitHeight
	x: showing ? 0 : -width
	y: 1440 - height

	property bool showing: false

	/* MultiEffect { */
    /*     anchors.fill: sideBar */
    /*     source: sideBar */
    /*     shadowEnabled: true */
    /*     shadowHorizontalOffset: 0 */
    /*     shadowVerticalOffset: 4 */
    /*     shadowColor: "#80000000" */
    /*     shadowBlur: 0.5 */
    /* } */


	MouseArea {
		hoverEnabled: true
		anchors.fill: parent
		//acceptedButtons: Qt.NoButton
		onExited: {
			sideBar.showing = false
		}

		RowLayout {
			visible: true
			id: contentColumn
			spacing: 4

			Repeater {
				model: [
					{ text: "Shutdown", icon: "", cmd: ["systemctl", "poweroff"]},
					{ text: "Restart", icon: "", cmd: ["systemctl", "reboot"]},
					{ text: "Suspend", icon: "", cmd: ["/usr/bin/systemctl", "suspend"]}
				]

				IconButton {
					icon: modelData.icon
					fontSize: 45
					iconColor: Theme.primary
					hoverColor: "#d08770"
					onClicked: {
						//sideBar.showing = false
						//sleepCmd.running = true
						powerCmd.command = modelData.cmd
						powerCmd.running = true
					}
				}
			}
		}
	}

	Process {
		id: powerCmd
	}

	Behavior on x {
		NumberAnimation {
			duration: 1000
			easing.type: Easing.InOutQuad
		}
	}

	function setShow(show) {
		this.showing = show
	}



}
