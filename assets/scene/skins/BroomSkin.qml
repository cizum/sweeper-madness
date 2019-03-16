import QtQuick 2.9

import krus.morten.style 1.0

Rectangle {
    id: root

    width: 5
    height: 15
    color: Style.playerBroomColor
    antialiasing: true

    property int angle: 25

    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height
        angle: root.angle
    }

    Rectangle {
        id: brush

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 15
        height: 6
        radius: 3
        color: Style.playerBroomBrushColor
        border.color: root.border.color
        antialiasing: true
    }
}
