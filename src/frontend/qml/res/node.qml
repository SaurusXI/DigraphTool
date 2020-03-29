import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.14
import QtGraphicalEffects 1.0

import "../scripts/line.js" as LineScript

RoundButton {
    id: nodeButton
    width: 160
    height: 100
    text: "Node"
    radius: 5

    property var nodeId
    property var parentFlickable: graphLayerFlickable
    property var parentLayer: graphLayer
    property var parentLayerWidth: parent.width
    property var parentLayerHeight: parent.height

    background: Rectangle {
        id: backgroundRectangle
        anchors.fill: parent
        color: "#f569d9"
        radius: parent.radius
    }

    contentItem: Text {
            text: parent.text
            font: parent.font
            opacity: enabled ? 1.0 : 0.3
            color: "#2f2d52"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }


    MouseArea {
        anchors.fill: parent

        property int previousX
        property int previousY

        onPressed: {
            previousX = mouseX
            previousY = mouseY
            backgroundRectangle.color = "#d145b5"
            parentFlickable.interactive = false
        }

        onClicked: {

        }

        onReleased: {
            backgroundRectangle.color = "#f569d9"
            parentFlickable.interactive = true
        }

        onMouseXChanged: {
            nodeButton.x = nodeButton.x + mouseX - previousX

            if (nodeButton.x < 0) {
                nodeButton.x = 0
            } else if (nodeButton.x > parentLayerWidth - nodeButton.width) {
                nodeButton.x = parentLayerWidth - nodeButton.width
            }
        }

        onMouseYChanged: {
            nodeButton.y = nodeButton.y + mouseY - previousY
            if (nodeButton.y < 0) {
                nodeButton.y = 0
            }
        }
    }


    
    RoundButton {
        id: leftNodeButton
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        width: parent.width / 2
        height: parent.height / 4

        font.pointSize: 10
        text: "LeftChild"
        contentItem: Text {
                text: parent.text
                font: parent.font
                opacity: enabled ? 1.0 : 0.3
                color: "#2f2d52"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? "#d145b5" : "#f569d9"
            radius: parent.radius
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                width: parent.width
                height: parent.radius
                color: parent.color
            }
            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.radius
                height: parent.height
                color: parent.color
            }
        }

        onClicked: {

        }
        radius: parent.radius
    }

    RoundButton {
        id: rightNodeButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        width: parent.width / 2
        height: parent.height / 4
        radius: parent.radius

        font.pointSize: 10
        text: "RightChild"
        contentItem: Text {
                text: parent.text
                font: parent.font
                opacity: enabled ? 1.0 : 0.3
                color: "#2f2d52"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        background: Rectangle {
            anchors.fill: parent
            color: parent.down ? "#d145b5" : "#f569d9"
            radius: parent.radius
            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                width: parent.width
                height: parent.radius
                color: parent.color
            }
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.radius
                height: parent.height
                color: parent.color
            }
        }
    }
}
