import QtQuick 2.9

import krus.morten.style 1.0

Item {
    id: root

    width: 200
    height: 260

    property double direction: 0
    property double power: 0
    property int phase: 0

    Column {
        id: needle

        width: 13
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5

        property int balls: Math.floor(needle.height / (needle.width + needle.spacing))
        property real powerLevel: balls * root.power / 100

        Repeater {
            model: needle.balls

            Rectangle {
                property real gap: needle.powerLevel - (needle.balls - index - 1)
                property real grayColor: Math.max(0, 1 - gap)
                width: needle.width
                anchors.horizontalCenter: parent.horizontalCenter
                height: needle.width
                radius: needle.width
                color:  gap > 0  ? Style.powerBarColor : Style.directionBarColor
                border.color: Qt.rgba(grayColor, grayColor, grayColor, 1)

                scale: Math.max(1, Math.min(1.33, 1 + gap * 0.33))
            }
        }

        transform: Rotation {
            origin.x: needle.width / 2
            origin.y: needle.height
            angle: root.direction
        }
    }

    onPhaseChanged: {
        if (phase === 4) {
            opacityAnim.restart()
        } else if (phase === 1){
            opacity = 1
        }
    }

    NumberAnimation on opacity {
        id: opacityAnim

        running: false
        duration: 1500
        to: 0
    }
}
