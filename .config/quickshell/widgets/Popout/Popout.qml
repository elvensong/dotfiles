import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../modules/Theme"

Rectangle {
	id: root
	implicitWidth: contents.implicitWidth
	implicitHeight: contents.implicitHeight
	topRightRadius: Theme.popout.topRightRadius
	bottomRightRadius: Theme.popout.bottomRightRadius
	property bool showing: false
	required property Item contents
	x: showing ? 0 : -width
	//x: 0
	//y: 600

	MouseArea {
		id: hoverArea
		enabled: true
		hoverEnabled: true
		anchors.fill: parent
		z: 999

		/* ColumnLayout { */
		/* 	id: contentColumn */
		/* 	visible: true */
		/* 	Repeater { */
		/* 		model: [{text: "aaaaaa"}, {text: "bbb"}, {text: "ccc"}] */


		/* 		Label { */
		/* 			text: modelData.text */
		/* 		} */
		/* 	} */
		/* } */
		onExited: {
			root.showing = false
		}

		onClicked: {
		}
	}

	Behavior on x {
		NumberAnimation {
			duration: 1000
			easing.type: Easing.InOutQuad
		}
	}

	function setShow(show) {
		this.showing = show
	}

	function setY(y) {
		console.log("Screen height:" + Screen.height)
		console.log("Set popout Y: " + y)
		console.log("Popout height: " + root.height)
		if ((y + root.height) < Screen.height) {
			root.y = y
		} else {
			root.y = Screen.height - root.height
		}
	}

	Component.onCompleted: {
		contents.parent = hoverArea
	}

}
