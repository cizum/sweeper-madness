import QtQuick 2.2

Character {
    id: root
    z: 1

    Rectangle {
        id: broom
        width: 5
        height: 15
        z: -1
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -parent.width / 2
        color: "#808090"
        border.color: root.borderColor
        transform: Rotation{
            origin.x: broom.width / 2
            origin.y: broom.height
            angle: 25
        }

        Rectangle {
            id: brush
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 15
            height: 6
            color: "#202020"
            border.color: root.borderColor
        }

        SequentialAnimation on height{
            id: broom_anim
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
    Rectangle {
        id: left_arm
        width: 6
        height: 23
        radius: width / 2
        z: -1
        x: 0
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height / 4
        color: root.color
        border.color: root.borderColor
        antialiasing: true
        transform: Rotation{
            origin.x: 0
            origin.y: left_arm.height
            angle: 50
            SequentialAnimation on angle {
                id: left_arm_anim
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
        }
    }
    Rectangle {
        id: right_arm
        width: 6
        height: 15
        radius: width / 2
        z: -1
        x: parent.width - width
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height / 3
        color: root.color
        border.color: root.borderColor
        antialiasing: true
        transform: Rotation{
            origin.x: right_arm.width
            origin.y: left_arm.height
            angle: -5
            SequentialAnimation on angle {
                id: right_arm_anim
                NumberAnimation{
                    duration: 100
                    from: -20
                    to: -10
                }
                NumberAnimation{
                    duration: 100
                    from: -10
                    to: -20
                }
            }
        }
    }

    function sweep() {
        root.shake_head()
        broom_anim.restart()
        left_arm_anim.restart()
        right_arm_anim.restart()
    }
}
