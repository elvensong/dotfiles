BarContainer {
  id: barCont
  width: childrenRect.width + 16
  height: childrenRect.height + 8
  radius: 6
  color: "#2E3440"           // Background color
  border.color: "#81A1C1"    // Border color
  border.width: 2
  anchors.centerIn: parent
  padding: 8

  Row {
    id: workspaceRow
    spacing: 8

    Repeater {
      model: Hyprland.workspaces

      delegate: Text {
        text: {
		  console.log("aaat": modeldata.name)
		  return modelData.name
		}
        color: modelData.focused ? "#81A1C1" : "#D8DEE9"
        font.bold: modelData.focused
      }
    }
  }
}

