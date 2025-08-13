pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../../themes"

//TODO: tidy up this theme file loading, make it load first, add per-computer config like network interfaces, video output ports etc.

Singleton {
    id: configManager
  property alias loadConfig: loadConfig

  Process {
    id: loadConfig
    //command: ["/bin/sh", "-c", "cat", "~/.config/wm-config.json"]
    command: ["cat", "/home/eve/.config/wm-config.json"]
    stdout: StdioCollector {
      onStreamFinished: {
        const output = this.text
        console.log("[ConfigManager] Raw output:", output)

        try {
            const config = JSON.parse(output)
          console.log("Loading theme: " + config.theme + config.mode)

            var themeFile = config.theme + config.mode + ".qml"
            var themeUrl = Qt.resolvedUrl("../../themes/" + themeFile)
          console.log("ThemeURL: " + themeUrl)
          const activeTheme = Qt.createComponent(themeUrl).createObject(configManager)
          ThemeManager.currentTheme = activeTheme
            //console.log("[ConfigManager] Loaded config:", JSON.stringify(config))
        } catch (e) {
            console.error("[ConfigManager] Failed to parse JSON:", e)
        }

      }
    }
  }
}
