import QtQuick 2.9

import krus.morten.style 1.0

Rectangle {
    id: root

    width: 19
    height: 19
    radius: width / 2 + 1

    property int specie: Style.specieHuman
    property int sex: Style.sexFemale
    property int headAngle: 0
    property int hairCut: Style.hairCut(sex)
    property color hairColor: Style.hairColor()

    Rectangle {
        id: hair

        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom
        width: root.width
        height: root.height - 3
        radius: root.width
        color: root.hairColor
        border.color: root.border.color

        visible: root.hairCut !== Style.hairCutBald && root.specie === Style.specieHuman
    }

    Rectangle {
        id: ponytail

        anchors.top: hair.bottom
        anchors.topMargin: -7
        anchors.horizontalCenter: root.horizontalCenter
        width: 7
        height: 9
        radius: 7
        color: root.hairColor
        border.color: root.border.color

        Rectangle {
            anchors.verticalCenter: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: 9
            height: 9
            radius: 9
            color: root.hairColor
            border.color: root.border.color
            z: -1
        }

        visible: root.hairCut === Style.hairCutPonyTail && root.specie === Style.specieHuman
    }

    transform: Rotation {
        id: headRotation

        origin.x: root.width / 2
        origin.y: root.height / 2
        axis { x: 0; y: 0; z: 1 }
        angle: root.headAngle
    }
}
