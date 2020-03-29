import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0

import "res"
import "scripts/node.js" as NodeScript

ApplicationWindow {
    id: window
    visible: true
    width: 960
    height: 720

    minimumWidth: 960
    minimumHeight: 720


    title: "DigraphTool"
    flags: Qt.Window | Qt.FramelessWindowHint

    color: "transparent"

    property var isFullScreen: false
    property var prevHeight: minimumHeight
    property var prevWidth: minimumWidth
    property var prevWindowX: 0
    property var prevWindowY: 0


    Rectangle {
        id: windowLayer
        height: parent.height - Resources.windowDropShadowVerticalPadding
        width: parent.width - Resources.windowDropShadowVerticalPadding
        radius: Resources.windowCornerRadius
        color: Resources.windowBackgroundColor


        Rectangle {
            id: windowTitleBar
            width: parent.width
            height: Resources.windowTitleBarHeight
            color: Resources.windowTitleBarBackgroundColor
            radius: Resources.windowCornerRadius

            Text {
                id: windowTitleBarText
                text: window.title
                font.pointSize: Resources.windowTitleBarFontPointSize
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: Resources.windowTitleBarForegroundColor
            }

            Rectangle {
                id: windowTitleBarCornerRadiusOffset
                //offset to hide corner radius at bottom of titlebar.
                width: parent.width
                height: parent.radius
                color: parent.color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }


            MouseArea {
                id: windowTitleBarMoveArea
                height: parent.height
                width: parent.width

                property int previousX
                property int previousY

                onPressed: {
                    previousX = mouseX
                    previousY = mouseY
                }

                onMouseXChanged: {
                    window.setX(window.x + mouseX - previousX)
                }

                onMouseYChanged: {
                    window.setY(window.y + mouseY - previousY)
                }
            }

            RoundButton {
                id: windowTitleBarCloseButton
                x: Resources.windowTitleBarButtonOffset
                anchors.verticalCenter: parent.verticalCenter
                height: windowTitleBarText.height
                radius: Resources.windowTitleBarButtonRadius
                background: Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    radius: parent.radius
                    color: Resources.windowTitleBarCloseButtonBackgroundColor
                    height: 2 * parent.radius
                    width: 2 * parent.radius
                }
                onClicked: {
                    console.log("You are closing this window.");
                }
            }

            RoundButton {
                id: windowTitleBarRestoreButton
                x: windowTitleBarCloseButton.x + windowTitleBarCloseButton.width + Resources.windowTitleBarButtonOffset
                anchors.verticalCenter: parent.verticalCenter
                height: windowTitleBarText.height
                radius: Resources.windowTitleBarButtonRadius
                background: Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    radius: parent.radius
                    color: Resources.windowTitleBarRestoreButtonBackgroundColor
                    height: 2 * parent.radius
                    width: 2 * parent.radius
                }

                onClicked: {
                    if(isFullScreen) {
                        isFullScreen = false
                        window.height = prevHeight
                        window.width = prevWidth
                        window.x = prevWindowX
                        window.y = prevWindowY
                    } else {
                        prevHeight = window.height
                        prevWidth = window.width
                        isFullScreen = true
                        window.height = Screen.height
                        window.width = Screen.width
                        prevWindowX = window.x
                        prevWindowY = window.y
                        window.x = 0
                        window.y = 0
                    }
                }
            }

            RoundButton {
                id: windowTitleBarMinimizeButton
                x: windowTitleBarRestoreButton.x + windowTitleBarRestoreButton.width + Resources.windowTitleBarButtonOffset
                anchors.verticalCenter: parent.verticalCenter
                height: windowTitleBarText.height
                radius: Resources.windowTitleBarButtonRadius
                background: Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    radius: parent.radius
                    color: Resources.windowTitleBarMinimizeButtonBackgroundColor
                    height: 2 * parent.radius
                    width: 2 * parent.radius
                }

                onClicked: {
                    window.visibility = Window.Minimized
                }
            }

        }

        Rectangle {
            id: commandLayer
            anchors.top: windowTitleBar.bottom
            height: parent.height - windowTitleBar.height - parent.radius
            width: 180
            color: "transparent"

            RoundButton {
                id: createNewNodeButton
                anchors.horizontalCenter: parent.horizontalCenter
                y: 90
                height: 40
                width: parent.width - 20
                radius: 10
                hoverEnabled: true
                text: "Create New Node"
                background: Rectangle {
                    id: backgroundRectangle
                    anchors.fill: parent
                    color: Resources.childElementBackgroundColor
                    radius: parent.radius
                }

                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    opacity: enabled ? 1.0 : 0.3
                    color: Resources.childElementForegroundColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                onPressed: {
                    backgroundRectangle.color = Resources.childElementClickColor
                }

                onReleased: {
                    backgroundRectangle.color = Resources.childElementFocusColor
                }

                onHoveredChanged: {
                    if (hovered) {
                        backgroundRectangle.color = Resources.childElementFocusColor
                    } else {
                        backgroundRectangle.color = Resources.childElementBackgroundColor
                    }
                }

                onClicked: {
                    NodeScript.createNode(graphLayer, 50, 50, new NodeScript.Node(10, "Sample"))
                }
            }
        }


        ScrollView {
            id: graphLayerScrollView
            clip: true
            anchors.left: commandLayer.right
            anchors.top: windowTitleBar.bottom
            height: windowLayer.height - windowTitleBar.height - windowLayer.radius
            width: 2 * windowLayer.width / 3 //66% of windowLayer is given to graphLayer's ScrollView

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOn

            Flickable {
                id: graphLayerFlickable

                property real flickHeight: 50000
                property real flickWidth: 5000

                width: flickWidth
                height: flickHeight

                contentHeight: flickHeight
                contentWidth: flickWidth
                boundsBehavior: Flickable.StopAtBounds

                Rectangle {
                    id: graphLayer
                    height: graphLayerFlickable.flickHeight
                    width: graphLayerFlickable.flickWidth
                    color: "#ddddf7"
                }
            }
        }

    }

    DropShadow {
        id: windowLayerDropShadow
        anchors.fill: windowLayer
        cached: true
        verticalOffset: 1
        horizontalOffset: 1
        radius: 8
        samples: 16
        color: "#80000000"
        source: windowLayer
    }

    MouseArea {
        id: windowHorizontalResizeArea
        width: 5
        anchors.right: windowLayer.right
        anchors.top: windowLayer.top
        anchors.bottom: windowLayer.bottom

        cursorShape: Qt.SizeHorCursor

        property int previousX

        onPressed: previousX = mouseX

        onMouseXChanged: {
            var dx = mouseX - previousX
            var newWidth = window.width + dx
            if(newWidth >= window.minimumWidth) {
                window.setWidth(newWidth)
            } else {
                if(window.width !== window.minimumWidth) {
                    window.setWidth(window.minimumWidth)
                }
            }
        }
    }

    MouseArea {
        id: windowVerticalResizeArea
        height: 5
        anchors.right: windowLayer.right
        anchors.left: windowLayer.left
        anchors.bottom: windowLayer.bottom

        cursorShape: Qt.SizeVerCursor

        property int previousY

        onPressed: previousY = mouseY

        onMouseYChanged: {
            var dy = mouseY - previousY
            var newHeight = window.height + dy
            if(newHeight >= 480) {
                window.setHeight(newHeight)
            } else {
                if(window.height !== window.minimumHeight) {
                    window.setHeight(window.minimumHeight)
                }
            }
        }
    }

}
