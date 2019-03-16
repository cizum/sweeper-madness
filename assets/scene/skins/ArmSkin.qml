import QtQuick 2.9

Rectangle {
    id: root

    width: 6
    height: 19
    radius: width / 2
    antialiasing: true

    property int angle: 0
    property color skinColor: "green"

    transform: Rotation {
        id: armRotation

        origin.x: 0
        origin.y: root.height
        angle: root.angle
    }

    Rectangle {
        id: hand

        width: 6
        height: 6
        radius: width / 2
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.skinColor
        border.color: root.border.color
    }
}
