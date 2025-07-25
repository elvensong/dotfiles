import Quickshell
import QtQuick

Scope {

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
			screen: modelData

			id: statusBar

      anchors {
        top: true
        left: true
				 bottom: true
      }

			implicitWidth: 50

			Column {
        

				WSContainer {

				}

				PowerButton {
				}

				}
			
		}
	}
}	
