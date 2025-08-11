import QtQuick
import QtQuick.Layouts
import "../../themes"

Item {
	id: root
	readonly property QtObject theme: ThemeManager.currentTheme

	required property string title
	required property string body

	implicitWidth: notiLayout.implicitWidth
	implicitHeight: notiLayout.implicitHeight

	Rectangle {
		anchors.fill: parent
		color: theme.background
		border.color: theme.border
		border.width: 2
		radius: 12
	}

	ColumnLayout {
		id: notiLayout

		Text {
			font.pixelSize: 15
			text: "aaaaaa"
		}

		Text {
			id: title
			text: root.title
			font.pixelSize: 15
		}

		Text {
			id: body
			text: root.body
			font.pixelSize: 15
		}
	}
}
