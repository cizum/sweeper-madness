import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 31
    height: 15
    property int team: 0
    property var colors: ["#ffbb00", "#00bbff", "#ffffff"]
    property string color: root.colors[team]
    property string borderColor: "#101010"
    property int headOffset: - root.height / 4

    Rectangle {
        id: left_arm
        width: 6
        height: 15
        radius: width / 2
        z: -1
        x: 0
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height / 6
        color: root.color
        border.color: root.borderColor
        antialiasing: true
        visible: false
    }

    Glow {
        anchors.fill: left_arm
        source: left_arm
        color: root.color
        samples: 17
        spread: 0.1
        antialiasing: true

        transform: Rotation {
            origin.x: 0
            origin.y: left_arm.height
            angle: root.team == 0 ? -17 : 5
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
        anchors.bottomMargin: parent.height / 6
        color: root.color
        border.color: root.borderColor
        antialiasing: true
        visible: false
    }

    Glow {
        anchors.fill: right_arm
        source: right_arm
        color: root.color
        samples: 17
        spread: 0.1
        antialiasing: true

        transform: Rotation {
            origin.x: right_arm.width
            origin.y: left_arm.height
            angle: root.team == 0 ? -5 : 17
        }
    }

    Rectangle {
        id: leg
        width: 8
        height: 0
        z: -1
        radius: width / 2 + 1
        anchors.top: parent.verticalCenter
        x: parent.width / 2 - (root.team == 0 ? 0 : width)
        color: root.color
        border.color: "#101010"
        antialiasing: true
        visible: false
        SequentialAnimation on height {
            id: leg_anim
            NumberAnimation{
                duration: 100
                from: 0
                to: 25
            }
            NumberAnimation{
                duration: 300
                from: 25
                to: 0
            }
        }
    }

    Glow {
        anchors.fill: leg
        source: leg
        color: root.color
        samples: 17
        antialiasing: true
        spread: 0.1
    }

    Rectangle {
        id: foot
        width: 8
        height: 5
        z: -1
        radius: width / 2 + 1
        anchors.horizontalCenter: leg.horizontalCenter
        anchors.top: leg.top
        color: root.color
        border.color: "#101010"
        antialiasing: true
        visible: false
    }

    Glow {
        anchors.fill: foot
        source: foot
        color: root.color
        samples: 17
        antialiasing: true
        spread: 0.1
    }

    Rectangle{
        id: body
        width: root.width
        height: root.height
        radius: 8
        color: root.color
        border.color: root.borderColor
        visible: false
    }

    Glow {
        anchors.fill: body
        source: body
        color: root.color
        samples: 17
        antialiasing: true
        spread: 0.1
    }

    Rectangle {
        id: head
        width: 17
        height: 17
        radius: width / 2 + 1
        anchors.centerIn: parent
        anchors.verticalCenterOffset: root.headOffset
        color: root.color
        border.color: root.borderColor
        antialiasing: true
        visible: false
    }

    Glow {
        anchors.fill: head
        source: head
        color: root.color
        samples: 17
        antialiasing: true
        spread: 0.1
    }

    function shoot() {
        leg_anim.restart()
    }
}
