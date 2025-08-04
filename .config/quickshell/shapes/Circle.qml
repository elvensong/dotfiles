import QtQuick.Shapes
import QtQuick

Shape {
    width: 50
    height: 50

    ShapePath {
        strokeColor: "black"
        fillColor: "yellow"

		PathArc {
			x: 50; y: 100
			radiusX: 10; radiusY: 10
			useLargeArc: true
		}
    }
}
