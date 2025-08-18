import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick.Layouts
import QtQml
import QtQuick
import "themes"
import "modules/IconButton"
import "widgets/WorkspaceButton"

WrapperRectangle {
	id: barCont
	readonly property QtObject theme: ThemeManager.currentTheme
	radius: theme.wsContainer.radius

	border.width: theme.wsContainer.borderWidth
	border.color: theme.border
	color: theme.surface
	anchors.top: parent.top
	anchors.left: parent.left
	anchors.right: parent.right
	// Hack to add bottom padding to wsCol
	implicitHeight: wsCol.implicitHeight + 10
	//anchors.horizontalCenter: parent.horizontalCenter
	anchors.topMargin: 5
	anchors.bottomMargin: 5
	anchors.leftMargin: 5
	anchors.rightMargin: 5

	Column {
		id: wsCol
		spacing: 5
		anchors.fill: parent
		anchors.leftMargin: 2
		anchors.rightMargin: 2
		anchors.topMargin: 10

		Repeater {
			model: Hyprland.workspaces

			IconButton {
				required property var modelData
				visible: modelData.name.match(/^special:[^\s]+$/) ? false : true
				radius: 50
				iconColor: modelData.focused ? theme.primary : theme.foreground
				width: wsCol.width
				icon: modelData.name
				onClicked: modelData.activate()
			}
		}
	}
}
