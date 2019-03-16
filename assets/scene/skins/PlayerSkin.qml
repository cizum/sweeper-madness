import QtQuick 2.9

import krus.morten.style 1.0

/** Generic player skin */
Item {
    id: root

    width: 35
    height: 15

    property int team: Style.teamHome
    property int sex: Style.sex()
    property int specie: Style.specie()
    property color skinColor: Style.skinColor(specie)
    property color teamColor: Style.teamColor(team)
    property color borderColor: Style.playerBorderColor
    property int headOffset: 0
    property int rightArmLength: 19
    property int leftArmLength: 19
    property int rightArmAngle: 0
    property int leftArmAngle: 0
    property bool laid: false

    ArmSkin {
        id: leftArm

        color: root.teamColor
        skinColor: root.skinColor
        border.color: root.borderColor
        anchors.bottom: parent.verticalCenter
        height: root.leftArmLength

        transform: Rotation{
            origin.x: leftArm.width
            origin.y: leftArm.height
            angle: root.leftArmAngle
        }
    }

    ArmSkin {
        id: rightArm

        color: root.teamColor
        skinColor: root.skinColor
        border.color: root.borderColor
        anchors.bottom: parent.verticalCenter
        anchors.right: parent.right
        height: root.rightArmLength

        transform: Rotation{
            origin.x: 0
            origin.y: rightArm.height
            angle: root.rightArmAngle
        }
    }

    LegSkin {
        id: leftLeg

        anchors.bottom: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        color: root.teamColor
        border.color: root.borderColor
    }

    LegSkin {
        id: rightLeg

        anchors.bottom: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 8
        color: root.teamColor
        border.color: root.borderColor
        laid: root.laid
    }

    BodySkin {
        id: body

        anchors.centerIn: parent
        color: root.teamColor
        border.color: root.borderColor
        sex: root.sex
        laid: root.laid
    }

    HeadSkin {
        id: head

        specie: root.specie
        sex: root.sex
        anchors.centerIn: parent
        anchors.verticalCenterOffset: root.headOffset
        color: root.skinColor
        border.color: root.borderColor
        antialiasing: true

        SequentialAnimation on anchors.verticalCenterOffset {
            id: headAnim

            NumberAnimation{
                duration: 50
                from: root.headOffset
                to: - 3
            }
            NumberAnimation{
                duration: 100
                from: -3
                to: 3
            }
            NumberAnimation{
                duration: 50
                from: 3
                to: root.headOffset
            }
        }
    }

    function shoot() {
        if (root.team === Style.teamHome) {
            rightLeg.move()
        } else {
            leftLeg.move()
        }
    }

    function shakeHead() {
        headAnim.restart()
    }
}
