import QtQuick 2.15
import QtQuick.Controls 2.15
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Item {
    id: root

    property bool showMenu: false
	//anchors.bottom: parent.bottom
	//anchors.horizontalCenter: parent.horizontalCenter
	width: parent.width
	height: root.width

    // Power icon
    MouseArea {
        id: iconArea
        anchors.fill: parent
		anchors.horizontalCenter: parent.horizontalCenter
        onClicked: menu.visible = true
		onEntered: menu.visible = true
		onExited: menu.visible = false

		Text {
			text: "⏻"
			// hack to make button size to be as big as the bar, tune the factor manually.
			font.pixelSize: parent.width * 1
			anchors.fill: parent
			anchors.horizontalCenter: parent.horizontalCenter
		}

    /*     IconImage { */
    /*         anchors.centerIn: parent */
    /*         source: Quickshell.iconPath("system-shutdown")  // Or "system-log-out", etc. */
    /*         width: 24; height: 24 */
    /*     } */
    }
