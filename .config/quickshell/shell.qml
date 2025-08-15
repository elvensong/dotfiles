//@ pragma UseQApplication

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
import "themes"
import "process/InternetStatus"
import "process/VpnStatus"
import "modules/IconButton"
import "process/NotiServer"
import "widgets/NotificationReport"
import "process/LoadConfig"

ShellRoot {

	Component.onCompleted: {
		LoadConfig.loadConfig.running = true
		Qt.application.iconTheme = "Papirus"
	}
	readonly property QtObject theme: ThemeManager.currentTheme

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
				item: rect
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
				font.pixelSize: 17
				font.family: theme.fontFamily
				text: {
				"Status: " + VpnStatus.vpnInfo.status + "\n" +
               "Server: " + VpnStatus.vpnInfo.server + "\n" +
               "Protocol: " + VpnStatus.vpnInfo.protocol + "\n" +
               "IP: " + VpnStatus.vpnInfo.ip + "\n" +
               "DNS: " + VpnStatus.vpnInfo.dns + "\n" +
               "DNS Suffix: " + VpnStatus.vpnInfo.dnsSuffix + "\n" +
               "Throughput: " + VpnStatus.vpnInfo.throughput + "\n" +
				"Connected: " + VpnStatus.vpnInfo.connected
				}
			}
		}

		Popout {
			id: powerPopout
			/* x: 0 */
			/* y: 600 */
			/* width: 200 */
			height: 70
			contents: RowLayout {
				anchors.fill: parent
				spacing: 10

				IconButton {
					icon: "⭘"
					width: 45
					iconColor: theme.negative
					//text: "Shutdown"
					onClicked: {
						//sideBar.showing = false
						//sleepCmd.running = true
						powerCmd.command = ["systemctl", "poweroff"]
						powerCmd.running = true
					}
				}

				IconButton {
					icon: "󰜉"
					width: 45
					iconColor: theme.accent
					onClicked: {
						//sideBar.showing = false
						//sleepCmd.running = true
						powerCmd.command = ["systemctl", "reboot"]
						powerCmd.running = true
					}
				}

				IconButton {
					icon: "⏾"
					width: 45
					iconColor: theme.warning
					onClicked: {
						//sideBar.showing = false
						//sleepCmd.running = true
						powerCmd.command = ["systemctl", "suspend"]
						powerCmd.running = true
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
				font.pixelSize: 17
				font.family: theme.fontFamily
				text: {
					"IP:" + statusPanel.wifi.ip + "\n"
						+ "Interface: " + statusPanel.wifi.interfaceName + "\n"
						+ "SSID: " + statusPanel.wifi.ssid
				}
			}
		}
	}

	PanelWindow {
		id: notiPanel
		exclusiveZone: 0
		color: "transparent"
		width: 250

		mask: Region {
			item: {
				if (notiList.count > 0) {
					return notiListLayout
				} else {
					return clickThroughZoneNotiPanel
				}
			}

		}

		Rectangle {
			id: clickThroughZoneNotiPanel
			anchors.centerIn: parent
			width: 1
			height: 1
		}

		anchors {
			top: true
			right: true
			bottom: true
		}

		ListModel {
			id: notiList

			function clearNotificationList() {
				for(let i = 0; i < count; i++) {
					get(i).notiItem.dismiss()
				}
				clear()
			}
		/*  	ListElement {title: "aha"; body: "body"; actions: {}} */
		}

		Component {
			id: notiDelegate
			Item {
				//id: notiItem
				readonly property QtObject theme: ThemeManager.currentTheme

				required property Notification notiItem
				/* required property string title */
				/* required property string body */
				width: parent.width

				implicitHeight: notiLayout.implicitHeight

				MouseArea {
					anchors.fill: parent

					onClicked: {
						console.log("Before remove: " + notiList.count)
						console.log("notiItem ID: " + notiItem.id)
						var rmIdx = -1
						for(var i = 0; i < notiList.count; i++) {

							console.log("notiList i ID: " + notiList.get(i).notiItem.id)
							if(notiList.get(i).notiItem.id === notiItem.id) {
								rmIdx = i
								console.log("Found removed notification:" + rmIdx)
								break
							}
						}

						notiItem.dismiss()
						notiList.remove(rmIdx)
						console.log("After remove: " + notiList.count)
					}
				}

				WrapperRectangle {
					color: theme.background
					anchors.fill: parent
					border.color: theme.border
					border.width: 2
					radius: 12

					Item {
						anchors.fill: parent
						anchors.margins: 7

						ColumnLayout {
							id: notiLayout
							//implicitHeight: title.contentHeight + body.contentHeight + notiActionBtnLayout.implicitHeight

							Text {
								id: title
								text: notiItem.summary
								font.pixelSize: 15
								wrapMode: Text.Wrap
								Layout.preferredWidth: notiPanel.width
								font.weight: Font.Bold
							}

							Text {
								id: body
								text: notiItem.body
								font.pixelSize: 15
								wrapMode: Text.Wrap
								Layout.preferredWidth: notiPanel.width
								clip: false
							}

							RowLayout {
								id: notiActionBtnLayout
								width: parent.width
								//implicitHeight: notiItemActionBtn.implicitHeight
								Repeater {
									model: notiItem.actions

									Button {
										text: modelData.text
										id: notiItemActionBtn
										onClicked:{
											console.log("Before remove: " + notiList.count)
											modelData.invoke()
											console.log("Before remove: " + notiList.count)
										}
									}
								}
							}
						}
					}
				}
			}
		}

		ColumnLayout {
			id:notiListLayout
			anchors.top: notiPanel.top
			anchors.left: parent.left
			anchors.right: parent.right

			ListView {
				id: notiListView
				Layout.fillWidth: true
				implicitHeight: contentHeight
				//anchors.fill: parent
				model: notiList
				delegate: notiDelegate
			}

			Button {
				visible: notiList.count > 0 ? true : false
				Layout.fillWidth: true
				text: "Dismiss All"
				onClicked: notiList.clearNotificationList()
			}
		}


		NotificationServer {
			id: notiServer
			bodySupported: true
			actionsSupported: true
			imageSupported: true
			//persistentSupported: true
			keepOnReload: true

			onNotification:  (notification) => {
				const notif = notification
				console.log("Received noti:" + notification.summary + ", with timeout: " + notification.expireTimeout)
				notif.tracked = true
			/* 	notiList.append({ */
			/* 		"title": notif.summary, */
			/* 		"body": notif.body, */
			/* 		"actions": notif.actions */
			/* 	}) */
				notiList.append({notiItem: notif})
			}
		}
	}
}
