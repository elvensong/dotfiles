import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQml
import QtQuick
import "modules/Theme"

WrapperRectangle {
	id: barCont
	radius: Theme.borderRadius
	border.width: 2
	border.color: Theme.border
	color: Theme.surface

	Column {
		id: wsCol
		spacing: Theme.spacing 
		padding: Theme.padding 

		Instantiator {
			model: Hyprland.workspaces

			delegate: WrapperMouseArea {
				required property var modelData

				onClicked: Hyprland.dispatch("workspace " + modelData.id)

				Text {
					text: modelData.name
					font.bold: modelData.focused
					color: modelData.focus ? Theme.primary : Theme.textPrimary
				}
			}
			
			onObjectAdded: (index, object) => wsCol.children.push(object)
			onObjectRemoved: (index, object) => wsCol.children.splice(index, 1)
		}
	}
}
