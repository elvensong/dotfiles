import QtQuick 2.15
import QtQuick.Controls 2.15
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root
		width: 32; height: 32

    property bool showMenu: false

    // Power icon
    MouseArea {
        id: iconArea
        anchors.fill: parent
        onClicked: menu.visible = true 

        IconImage {
            anchors.centerIn: parent
            source: Quickshell.iconPath("system-shutdown")  // Or "system-log-out", etc.
            width: 24; height: 24
        }
    }

    // Proper Popup using Quickshell.PopupWindow
    PopupWindow {
        id: menu
				onClosed: root.showMenu = false

				anchor.window: statusBar

        Column {
            width: 160
            spacing: 6
            padding: 10

            Repeater {
                model: [
                    { text: "Shutdown", icon: "system-shutdown", cmd: ["systemctl", "poweroff"]},
                    { text: "Restart", icon: "system-reboot", cmd: ["systemctl", "reboot"]},
                    { text: "Suspend", icon: "system-suspend", cmd: ["/usr/bin/systemctl", "suspend"]}
                ]

                Button {
                    text: modelData.text
                    width: parent.width
                    icon.source: Quickshell.iconPath(modelData.icon)
                    onClicked: {
                        menu.visible = false
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
	}

