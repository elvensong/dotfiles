pragma Singleton
import QtQuick
import Quickshell.Io
import "."
import "../process/LoadConfig" as Config

Item {
    property QtObject currentTheme

    onCurrentThemeChanged: {
        console.log("Theme changed to " + currentTheme.toString())

        switchEmacsTheme.running = true
    }

    Process {
        id: switchEmacsTheme
        command: ["emacsclient", "-e", "(my/switch-theme \"'" + currentTheme.appTheme.doomEmacs + "\")"]
    /*     stout.StdioCollector { */
    /*         onStreamFinished: { */
    /*             const output = this.text */

    /*         } */
    /*     } */
    }

}
