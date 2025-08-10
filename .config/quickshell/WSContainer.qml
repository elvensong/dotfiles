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
	//anchors.horizontalCenter: parent.horizontalCenter
	anchors.topMargin: 5
	anchors.bottomMargin: 5
	anchors.leftMargin: 5
	anchors.rightMargin: 5

	ColumnLayout {
		id: wsCol
		spacing: 5
		anchors.fill: parent
		anchors.leftMargin: 5
		anchors.rightMargin: 5
		Layout.margins: 2

		Instantiator {
			model: Hyprland.workspaces

			IconButton {
				required property var modelData
				visible: modelData.name.match(/^special:[^\s]+$/) ? false : true
				radius: 50
				//color: modelData.focused ? theme.foreground : "transparent"
				iconColor: modelData.focused ? theme.primary : theme.foreground
				width: wsCol.width
			//	offsetX: 2
				/* offsetX: { */
				/* 	if(modelData.name === '󰗰') { */
				/* 		console.log("email workspace") */
				/* 		return -5 */
				/* 	} */
				/* } */
				icon: modelData.name
				onClicked: modelData.activate()
			}

			onObjectAdded: (index, object) => wsCol.children.push(object)
			onObjectRemoved: (index, object) => wsCol.children.splice(index, 1)
		}
	}
}
