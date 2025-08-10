// File: modules/Internet/InternetWidget.qml
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../models/NetworkTypeConstants" as NetType
import "../../process/InternetStatus"
import "../../process/VpnStatus"
import "../../modules/IconButton"
import "../../themes"


Item {
	readonly property QtObject theme: ThemeManager.currentTheme
	//radius: theme.wsContainer.radius
	//border.width: 2
	//border.color: theme.border
	//color: theme.surface
	Layout.alignment: Qt.AlignHCenter
	implicitHeight: networkWidgetColumn.implicitHeight
	width: parent.width - 10

    id: root
	signal enterIcon(QtObject iconMA, string actionType)
	//Layout.alignment: Qt.AlignHCenter
	//property int iconSize: 20

    // Load the InternetStatus singleton
	InternetStatus {
		id: internetStatus
	}

    property var wifi: internetStatus.wifi
    property var ethernet: internetStatus.ethernet

	Rectangle {
		anchors.fill: parent
		radius: theme.wsContainer.radius
		border.width: 2
		border.color: theme.border
		color: theme.surface
	}

    ColumnLayout {
		id: networkWidgetColumn
		width: root.width
		//height: 150

        //anchors.centerIn: parent

		IconButton {
			id: vpnIcon
			visible: true
			//fontSize: root.iconSize
			//fontSize: 30
			actionType: "vpn"
			icon: {
				if (VpnStatus.vpnInfo.status === "connected") {
					return "";
				} else return "";
			}
			iconColor: {
				if (VpnStatus.vpnInfo.status === "connected") {
					return theme.primary
				} else {
					return theme.textDisabled
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
			iconColor: {
				if (wifi !== undefined && wifi.ip !== "") {
					return theme.accent;
				} else return theme.textDisabled;
			}
			implicitHeight: parent.width
			//fontSize: 30
			actionType: "network"
			icon:  {
				if (wifi !== undefined && wifi.ip !== "") {
					return "󰖩";
				} else return "󰖪";
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
                color: theme.primary
            }
        }
    }
}
