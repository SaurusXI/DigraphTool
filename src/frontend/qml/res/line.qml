import QtQuick 2.14
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.14
import QtGraphicalEffects 1.0

Shape {
    id: containerShape
    property var startX: 0
    property var startY: 0
    property var endX: 0
    property var endY: 0

    anchors.fill: parent


    ShapePath {
        strokeColor: "#708ae9"
        strokeWidth: 2
        fillColor: "transparent"
        capStyle: ShapePath.RoundCap

        property int joinStyleIndex: 0

        property variant styles: [
            ShapePath.BevelJoin,
            ShapePath.MiterJoin,
            ShapePath.RoundJoin
        ]

        joinStyle: styles[joinStyleIndex]

        startX: containerShape.startX
        startY: containerShape.startY

        property var endX: containerShape.endX
        property var endY: containerShape.endY

        PathLine { x: endX; y: endY }

    }

}
