import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Notifications
import "modules/SideBar"
import "widgets/Popout"
import "modules/Theme"
import "process/InternetStatus"
import "process/VpnStatus"
import "modules/IconButton"
import "process/NotiServer"

ShellRoot {
	/* Variants { */
	/* 	model: Quickshell.screens */

	PanelWindow {
		//required property var modelData
		//screen: modelData
		id: statusPanel
		property bool collapsed: true
		//WlrLayershell.layer: WlrLayer.Background
		//aboveWindows: true
		//focusable: false
		exclusiveZone: 0
		color: "transparent"
		implicitWidth: 400
		mask:
			Region {
				item: sideBar
			}
		Rectangle {
			id: rect
			anchors.centerIn: parent
			width: 1
			height: 1
		}

		anchors {
			top: true
			left: true
			bottom: true
		}

		InternetStatus {
			id: internetStatus
		}
		property var wifi: internetStatus.wifi
		property var ethernet: internetStatus.ethernet

		//implicitWidth: 50

			//Layout.fillHeight: true
		StatusBar {
			onEnterIcon: (iconMA, actionType) => {
				let popout;
				switch (actionType) {
					case "network":
						popout = wifiPopout
						break;
					case "power":
						popout = powerPopout
						break;
					case "vpn":
						popout = vpnPopout
					break;
					default:
						console.log("Unrecognizable actionType value.")
				}
				popout.setY(iconMA.mapToItem(null, 0, 0).y)
				popout.setShow(true)
				statusPanel.mask.item = popout
			}
		}

		Popout {
			id: vpnPopout
			contents: Label {
				text: {
				"status: " + VpnStatus.vpnInfo.status + "\n" +
               "server: " + VpnStatus.vpnInfo.server + "\n" +
               "protocol: " + VpnStatus.vpnInfo.protocol + "\n" +
               "ip: " + VpnStatus.vpnInfo.ip + "\n" +
               "dns: " + VpnStatus.vpnInfo.dns + "\n" +
               "dnsSuffix: " + VpnStatus.vpnInfo.dnsSuffix + "\n" +
               "throughput: " + VpnStatus.vpnInfo.throughput + "\n" +
				"connected: " + VpnStatus.vpnInfo.connected
				}
			}
		}

		Popout {
			id: powerPopout
			contents: RowLayout {
				spacing: 4

				Repeater {
					model: [
						{ text: "Shutdown", icon: "a", cmd: ["systemctl", "poweroff"]},
						{ text: "Restart", icon: "b", cmd: ["systemctl", "reboot"]},
						{ text: "Suspend", icon: "c", cmd: ["/usr/bin/systemctl", "suspend"]}
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

		Popout {
			id: wifiPopout
			contents: Label {
				text: {
					statusPanel.wifi.ip + "\n" + statusPanel.wifi.interfaceName + "\n" + statusPanel.wifi.ssid
				}
			}
		}

		function findChildrenOfType(item, typeName) {
			let matches = [];

			for (let i = 0; i < item.children.length; ++i) {
				let child = item.children[i];

				console.log(child.toString())
				if (child.metaObject.className === typeName) {
					matches.push(child);
				}

				// Recurse if child has children (i.e., is an Item)
				if (child.children) {
					matches = matches.concat(findChildrenOfType(child, typeName));
				}
			}

			return matches;
		}
	}

	PanelWindow {
		id: notiPanel
		exclusiveZone: 0
		color: "transparent"

	}
}
