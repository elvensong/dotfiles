import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "modules/Theme"

WrapperRectangle {
	Layout.alignment: Qt.AlignHCenter
	//anchors.fill: parent
	//border.width: 3
	border.color: "black"
	radius: Theme.radius
	//anchors.verticalCenter: parent.verticalCenter
	//implicitWidth: textClock.implicitWidth + 20  // Optional padding
	//implicitHeight: textClock.implicitHeight + 10

	Text {
		id: textClock
		font.pixelSize: 20
		//anchors.centerIn: parent
		//anchors.horizontalCenter: statusBar.horizontalCenter
		text: "\n" + clock.hours + "\n" + clock.minutes
		//text: Qt.formatDateTime(clock.date, Theme.clockFormat)
	}

	SystemClock	{
		id: clock
		precision: SystemClock.Minutes
	}
}

