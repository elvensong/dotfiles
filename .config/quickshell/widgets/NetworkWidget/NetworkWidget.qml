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
    id: root
    
    readonly property QtObject theme: ThemeManager.currentTheme
    width: parent.width - 6
    height: networkWidgetColumn.implicitHeight
    
    signal enterIcon(QtObject iconMA, string actionType)

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
        anchors.margins: 0  // No margins on the rectangle itself, padding is handled by the column

        Column {
            id: networkWidgetColumn
            width: parent.width - 20  // Add margin on both sides
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8
            topPadding: 8
            bottomPadding: 8

            IconButton {
                id: vpnIcon
                visible: true
                actionType: "vpn"
                icon: VpnStatus.vpnInfo.status === "connected" ? "" : ""
                iconColor: VpnStatus.vpnInfo.status === "connected" ? theme.primary : theme.textDisabled
                
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
            Item {
                width: parent.width
                height: 30
                
                IconButton {
                    id: wifiIcon
                    anchors.centerIn: parent
                    iconColor: (wifi !== undefined && wifi.ip !== "") ? theme.accent : theme.textDisabled
                    width: 30
                    height: 30
                    actionType: "network"
                    icon: (wifi !== undefined && wifi.ip !== "") ? "󰖩" : "󰖪"
                    
                    onEntered: {
                        root.enterIcon(wifiIcon.mouseArea, wifiIcon.actionType)
                    }
                }
            }

            // Show Ethernet icon if Ethernet is connected
            Item {
                visible: ethernet ? (ethernet.ip !== "") : false
                width: parent.width
                height: 30
                
                Text {
                    anchors.centerIn: parent
                    font.family: "Font Awesome 6 Free"
                    font.pixelSize: 20
                    text: (ethernet && ethernet.ip !== "") ? "\uf6ff" : ""
                    color: theme.primary
                }
            }
        }
    }
}
