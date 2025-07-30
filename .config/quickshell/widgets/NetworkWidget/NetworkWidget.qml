// File: modules/Internet/InternetWidget.qml
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../models/NetworkTypeConstants" as NetType
import "../../process/InternetStatus"
import "../../modules/Theme"
import "../../process/VpnStatus"
import "../../modules/IconButton"

Rectangle {
    id: root
	signal enterIcon(QtObject iconMA, string actionType)
	//Layout.alignment: Qt.AlignHCenter
    color: Theme.surface
	implicitHeight: networkWidgetColumn.implicitHeight
	width: parent.width
	property int iconSize: 20

    // Load the InternetStatus singleton
	InternetStatus {
		id: internetStatus
	}

    property var wifi: internetStatus.wifi
    property var ethernet: internetStatus.ethernet

    ColumnLayout {
		visible: true
		id: networkWidgetColumn
        //anchors.centerIn: parent
        spacing: 4

		IconButton {
			id: vpnIcon
			fontSize: root.iconSize
			actionType: "vpn"
			icon: {
				if (VpnStatus.vpnInfo.status === "connected") {
					return "";
				} else return "";
			}
			iconColor: {
				if (VpnStatus.vpnInfo.status === "connected") {
					return Theme.primary
				} else {
					return Theme.textPrimary
				}
			}
			onEntered: {
				VpnStatus.trigger()
				root.enterIcon(vpnIcon.mouseArea, vpnIcon.actionType)
			}
			onClicked: {
				stopVpnProc.running = true
				VpnStatus.trigger()
			}
			Process {
				id: stopVpnProc
				command: ["nxcli", "disconnect"]
			}
		}

        // Show WiFi icon if WiFi is connected
        IconButton {
			id: wifiIcon
			fontSize: root.iconSize
			actionType: "network"
			icon:  {
				if (wifi !== undefined && wifi.ip !== "") {
					return "\uf1eb";
				} else return "";
			}
			onEntered: {
				root.enterIcon(wifiIcon.mouseArea, wifiIcon.actionType)
			}

		}

        // Show Ethernet icon if Ethernet is connected
        Rectangle {
            visible: ethernet ? ethernet.ip !== "" : false
            color: "transparent"

            Text {
                anchors.centerIn: parent
                font.family: "Font Awesome 6 Free"
                font.pixelSize: 20
                text: {
					if (ethernet.ip !== "") {
						return "\uf6ff";
					} else return "";
				}
                color: Theme.primary
            }
        }
    }
}
