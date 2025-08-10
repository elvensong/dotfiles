import QtQuick
import "../../themes"

Item {
	id: root
	readonly property QtObject theme: ThemeManager.currentTheme

	required property string title
	required property string body

	Rectangle {
		color: theme.background
		border.color: theme.border
		border.width: 2
	}

	Text {
		id: title
		text: root.title

		anchors.top: parent.top
	}

	Text {
		id: body
		text: root.body
		anchors.bottom: parent.bottom
	}
}
