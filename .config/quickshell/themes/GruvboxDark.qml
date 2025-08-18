pragma Singleton
import QtQuick 2.15

QtObject {
    property string name: "Gruvbox Dark"

    // Colors
    readonly property color background:   "#282828" // dark0 – main background
    readonly property color foreground:   "#ebdbb2" // light1 – main text color
    readonly property color primary:      "#fabd2f" // yellow – buttons, accents
    readonly property color accent:       "#83a598" // blue – links, secondary UI
    readonly property color positive:     "#b8bb26" // green – success indicators
    readonly property color negative:     "#fb4934" // red – errors, danger
    readonly property color warning:      "#fe8019" // orange – warnings, caution
    readonly property color border:       "#3c3836" // dark1 – panel borders, lines
    readonly property color hover:        "#504945" // dark2 – hover states
    readonly property color focus:        "#458588" // faded blue – focus highlight
    readonly property color selected:     "#98971a" // olive green – selection bg
    readonly property color textDisabled: "#928374" // gray – inactive text
    readonly property color surface:      "#3c3836" // dark1 – cards, panels
    readonly property color shadow:       "#1d2021" // dark alt – subtle outlines

    // Typography
    readonly property string fontFamily: "Inter, Noto Sans, sans-serif"

    // Application theme names
    readonly property QtObject appTheme: QtObject {
        readonly property string doomEmacs: "doom-gruvbox"
    }

    // Component defaults
    readonly property QtObject wsContainer: QtObject {
        property int radius: 40
        property int borderWidth: 2
    }

    readonly property QtObject button: QtObject {
        property int radius: 17
        property int borderWidth: 1
        property color background: primary
        property color hoverBackground: hover
        property color text: foreground
    }
}
