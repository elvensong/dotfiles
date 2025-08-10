// MyControls/Icon/IconButton.qml
import QtQuick
import QtQuick.Controls
import "../../modules/Theme"
import "../../themes"

Rectangle {
    id: root
	required property string icon

	readonly property QtObject theme: ThemeManager.currentTheme

    // === Public API: Customizable from outside ===
    property string actionType
    property alias mouseArea: iconMouseArea
    property int fontSize: root.width - 5
	property string text
	property real offsetX: 0
    property string fontFamily: "Symbols Nerd Font"
    property color iconColor: theme.primary
    property color hoverColor: theme.hover
    signal clicked()
	signal entered()
	signal exited()

    color: "transparent"

    //width: iconText.paintedHeight + padding * 2
    //height: width
    width: parent.width
	height: width
    //property int padding: 10

    // === Internal Text ===
    Text {
        id: iconText
        text: root.icon
        font.pixelSize: root.fontSize
        font.family: root.fontFamily
        color: root.iconColor
		x: x + offsetX
        anchors.centerIn: parent
	/* 	horizontalAlignment: Text.AlignHCenter */
	/* 	verticalAlignment: Text.AlignVCenter */
	}

	Text {
		visible: root.text !== undefined && root.text !== "" ? true : false
		font.pixelSize: 15
		text: root.text
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
