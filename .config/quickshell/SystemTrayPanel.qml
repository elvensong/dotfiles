import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "themes"


Item {
    id: root
    required property QsWindow parentWindow
    readonly property QtObject theme: ThemeManager.currentTheme
    width: parent ? parent.width : 100
    height: 150

    Rectangle {
        anchors.fill: parent
        color: theme.background
        border.color: theme.border
        border.width: 2
    }

    Row {
        spacing: 8
        anchors.fill: parent
        anchors.margins: 4
        layoutDirection: Qt.LeftToRight

        Repeater {
            model: SystemTray.items

            delegate: Rectangle {
                width: 24
                height: 24

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: (mouse) => {
                        console.log("SystemTrayIcon clicked" + modelData.title)
                        if(mouse.button == Qt.LeftButton) {
                            modelData.activate()
                        } else {
                            console.log("Right clicked")
                            modelData.display(parentWindow, 0, 0)
                        }
                    }
                }

                Image {
                    id: iconImg
                    anchors.fill: parent
                    source: {
                        console.log("SystemTray Icon: " + modelData.icon)
                        return modelData.icon
                    }
                    sourceSize.width: 24
                    sourceSize.height: 24
                }
            }
        }
    }
}
