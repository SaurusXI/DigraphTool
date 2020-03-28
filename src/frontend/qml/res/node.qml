import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0

Button {
    width: 160
    height: 100
    text: "Node"
    
    Button {
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        width: parent.width / 2
        height: parent.height / 4

        font.pointSize: 10
        text: "LeftChild"
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        width: parent.width / 2
        height: parent.height / 4

        font.pointSize: 10
        text: "RightChild"
    }
}