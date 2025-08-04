import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick.Layouts
import QtQml
import QtQuick
import "modules/Theme"
import "modules/IconButton"
import "widgets/WorkspaceButton"

WrapperRectangle {
	id: barCont
	radius: Theme.wsContainer.radius

	//border.width: 2
	border.color: Theme.border
	color: Theme.surface
	anchors.top: parent.top
	anchors.left: parent.left
	anchors.right: parent.right
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.topMargin: 5
	anchors.leftMargin: 5
	anchors.rightMargin: 5

	ColumnLayout {
		id: wsCol
		spacing: Theme.spacing
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
				color: modelData.focused ? Theme.primary : "transparent"
				iconColor: modelData.focused ? Theme.surface : Theme.primary
				width: wsCol.width
				icon: {
					console.log(modelData.name)
					modelData.name
				}
				fontSize: 20
				//font.bold: modelData.focused
				//color: modelData.focus ? Theme.primary : Theme.textPrimary
				onClicked: modelData.activate()
			}

			onObjectAdded: (index, object) => wsCol.children.push(object)
			onObjectRemoved: (index, object) => wsCol.children.splice(index, 1)
		}
	}
}
