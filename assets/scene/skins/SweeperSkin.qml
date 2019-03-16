import QtQuick 2.9

import krus.morten.style 1.0

PlayerSkin {
    id: root

    rightArmLength: 18
    leftArmLength: 19
    rightArmAngle: -30
    leftArmAngle: 45

    BroomSkin {
        id: broom

        anchors.centerIn: parent
        anchors.verticalCenterOffset: -parent.width / 2
        border.color: root.borderColor
        z: -1

        SequentialAnimation on height {
            id: broomAnim
            running: false

            NumberAnimation{
                duration: 100
                from: root.height
                to: root.height + 25
            }
            NumberAnimation{
                duration: 100
                from: root.height + 25
                to: root.height
            }
        }
    }

    SequentialAnimation on leftArmAngle {
        id: leftArmAnim
        running: false

        NumberAnimation{
            duration: 100
            from: 45
            to: 55
        }

        NumberAnimation{
            duration: 100
            from: 55
            to: 45
        }
    }

    SequentialAnimation on rightArmAngle {
        id: rightArmAnim
        running: false

        NumberAnimation{
            duration: 100
            from: -30
            to: -5
        }

        NumberAnimation{
            duration: 100
            from: -5
            to: -30
        }
    }

    function sweep() {
        root.shakeHead()
        broomAnim.restart()
        leftArmAnim.restart()
        rightArmAnim.restart()
    }
}
