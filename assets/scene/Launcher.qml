import QtQuick 2.2

Character {
    id: root
    width: 22
    height:22
    z: 1
    headOffset: -12
    property int moveDuration: 10000
    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height / 2
        angle: 90
    }

    Rectangle {
        id: left_arm
        width: 6
        height: 15
        radius: width / 2
        z: -1
        x: 0
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height / 4
        color: root.color
        border.color: root.borderColor
        antialiasing: true
        transform: Rotation {
            origin.x: 0
            origin.y: left_arm.height
            angle: -20
        }

        Rectangle {
            id: broom
            width: 4
            height: 15
            radius: width / 2
            z: -1
            anchors.bottom: left_arm.top
            anchors.bottomMargin: -3
            anchors.horizontalCenter: left_arm.horizontalCenter
            color: "#aaaaaa"
            border.color: root.borderColor
            antialiasing: true
            transform: Rotation {
                origin.x: 0
                origin.y: left_arm.height
                angle: 5
            }
            Rectangle {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: 15
                height: 6
                color: "#505050"
                border.color: "#101010"
                antialiasing: true
            }
        }
    }

    Rectangle {
        id: right_arm
        width: 6
        height: 18
        radius: width / 2
        z: -1
        x: parent.width - width
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height / 3
        color: root.color
        border.color: root.borderColor
        antialiasing: true
        transform: Rotation {
            origin.x: right_arm.width
            origin.y: left_arm.height
            angle: -5
        }
    }

    Rectangle {
        id: leg
        width: 9
        height: 27
        z: -1
        radius: width / 2 + 1
        anchors.top: parent.verticalCenter
        x: parent.width / 2
        color: root.color
        border.color: "#101010"
        antialiasing: true
    }

    Rectangle {
        id: foot
        width: 9
        height: 7
        z: -1
        radius: width / 2 + 1
        anchors.horizontalCenter: leg.horizontalCenter
        anchors.bottom: leg.bottom
        color: "#dddddd"
        border.color: "#101010"
        antialiasing: true
    }

    Behavior on x {
        id: move_smooth_x
        enabled: false
        NumberAnimation {
            NumberAnimation on duration {
                running: move_smooth_x.enabled
                from: 8000
                to: 0
                duration: 8000
                onStopped: move_smooth_x.enabled = false
            }
        }
    }

    Behavior on y {
        id: move_smooth_y
        enabled: false
        NumberAnimation {
            NumberAnimation on duration {
                running: move_smooth_y.enabled
                from: 8000
                to: 0
                duration: 8000
                onStopped: move_smooth_y.enabled = false
            }
        }
    }

    function move_smooth(){
        move_smooth_x.enabled = true;
        move_smooth_y.enabled = true;
    }
}
