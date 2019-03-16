import QtQuick 2.9

import krus.morten.style 1.0

PlayerSkin {
    id: root

    leftArmAngle: -20

    BroomSkin {
        id: broom

        angle: -5
        anchors.bottom: parent.top
        anchors.bottomMargin: 3
        anchors.right: parent.left
        border.color: root.borderColor
        z: -1
    }
}
