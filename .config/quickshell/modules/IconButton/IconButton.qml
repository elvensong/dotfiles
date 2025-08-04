// MyControls/Icon/IconButton.qml
import QtQuick
import QtQuick.Controls
import "../../modules/Theme"

Rectangle {
    id: root
	required property string icon

    // === Public API: Customizable from outside ===
    property string actionType
    property alias mouseArea: iconMouseArea
    property int fontSize: 60
    property string fontFamily: "Symbols Nerd Font"
    property color iconColor: Theme.iconButton.primary
    property color hoverColor: Theme.iconButton.hover
    signal clicked()
	signal entered()
	signal exited()

    color: "transparent"

    width: iconText.paintedHeight + padding * 2
    height: width
    property int padding: 10

    // === Internal Text ===
    Text {
        id: iconText
        text: root.icon
        font.pixelSize: root.fontSize
        font.family: root.fontFamily
        color: root.iconColor
        anchors.centerIn: parent
    }

    MouseArea {
		id: iconMouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: root.clicked()

        onEntered: {
			iconText.color = root.hoverColor
			root.entered()
		}
        onExited: {
			iconText.color = root.iconColor
			root.exited()
		}
    }
}
