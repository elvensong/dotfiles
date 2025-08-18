pragma Singleton
import QtQuick 2.15

QtObject {
    property string name: "Gruvbox Light"

    // Base background color (light0)
    property color background:    "#fbf1c7" // light0 – main background#FBF1C7

    // Base text color (dark1)
    property color foreground:    "#3c3836" // dark1 – main text color

    // Highlighted primary UI elements (yellow)
    property color primary:       "#79740E" // yellow – buttons, accents

    // Secondary accent (blue)
    property color accent:        "#458588" // blue – links, secondary UI

    // Positive actions (green)
    property color positive:      "#98971a" // green – success indicators

    // Negative actions (red)
    property color negative:      "#9D0107" // red – errors, danger, delete

    // Warnings or attention (orange)
    property color warning:       "#d65d0e" // orange – warnings, caution

    // Border or separator color (light4)
    property color border:        "#EBDBB2" // light4 – panel borders, lines

    // Hover background (light1)
    property color hover:         "#ebdbb2" // light1 – hover states

    // Focus ring or selected border (blue alt)
    property color focus:         "#83a598" // faded blue – focus highlight

    // Selected item highlight (bright green)
    property color selected:      "#b8bb26" // bright green – selection bg

    // Disabled text or low contrast (gray)
    property color textDisabled:  "#a89984" // gray – inactive text

    // Surface background (light2)
    property color surface:       "#F2E5BC" // light2 – cards, panels

    // Shadow or subtle outlines (gray alt)
    property color shadow:        "#928374" // gray – subtle outlines/shadows

	property string fontFamily: "Inter"


    // Application theme names
    readonly property QtObject appTheme: QtObject {
        readonly property string doomEmacs: "doom-gruvbox-light"
    }

	property QtObject wsContainer: QtObject {
		property int radius: 17
		property int borderWidth: 2
	}
}
