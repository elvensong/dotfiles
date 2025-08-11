import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "themes"

WrapperRectangle {
	readonly property QtObject theme: ThemeManager.currentTheme

	property int fontSize
	id: root
	Layout.alignment: Qt.AlignHCenter
	color: theme.background
	/* width: parent.width */
	/* border.width: 2 */
	/* border.color: theme.border */


	//anchors.fill: parent
	//border.width: 3
	//border.color: "black"
	//radius: theme.radius
	//anchors.verticalCenter: parent.verticalCenter
	//implicitWidth: textClock.implicitWidth + 20  // Optional padding
	//implicitHeight: textClock.implicitHeight + 10

	ColumnLayout {

		Text {
			id: textHour
			font.pixelSize: 20
			font.family: "IBM Plex Mono"
			color: theme.foreground
			font.weight: 500
			//anchors.centerIn: parent
			//anchors.horizontalCenter: statusBar.horizontalCenter
			text: clock.hours.toString().padStart(2, "0")
			//text: Qt.formatDateTime(clock.date, Theme.clockFormat)
		}

		Text {
			id: textMin
			font.pixelSize: 20
			font.family: "IBM Plex Mono"
			color: theme.foreground
			font.weight: 500
			//anchors.centerIn: parent
			//anchors.horizontalCenter: statusBar.horizontalCenter
			text: clock.minutes.toString().padStart(2, "0")
			//text: Qt.formatDateTime(clock.date, Theme.clockFormat)
		}
	}
	SystemClock	{
		id: clock
		precision: SystemClock.Minutes
	}
}

