import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: root.lying ? 22 : 31
    height: root.lying ? 22 : 15
    property int team: 0
    property var colors: ["#ffbb00", "#00bbff", "#ffffff"]
    property string color: root.colors[team]
    property string borderColor: "#101010"
    property int headOffset: root.lying ? - 8 : - root.height / 4
    property bool lying: false

    Rectangle {
        id: broom
        width: 4
        height: 15
        radius: width / 2
        z: -1
        anchors.bottom: left_arm.top
        anchors.bottomMargin: -3
        anchors.horizontalCenterOffset: -5
        anchors.horizontalCenter: left_arm.horizontalCenter
        color: "#ffffff"
        border.color: root.borderColor
        antialiasing: true
        visible: false

        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 15
            height: 6
            radius: 3
            color: "#ffffff"
            border.color: "#101010"
            antialiasing: true
        }
    }

    Glow {
        anchors.fill: broom
        source: broom
        color: root.color
        samples: 17
        spread: 0.1
        antialiasing: true

        transform: Rotation {
            origin.x: 0
            origin.y: left_arm.height
            angle: - 15
        }
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
            angle: -20
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
        visible: false
    }

    Glow {
        anchors.fill: leg
        source: leg
        color: root.color
        samples: 17
        antialiasing: true
        spread: 0.1
        visible: root.lying
    }

    Rectangle {
        id: foot
        width: 9
        height: 7
        z: -1
        radius: width / 2 + 1
        anchors.horizontalCenter: leg.horizontalCenter
        anchors.bottom: leg.bottom
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
        visible: root.lying
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
        SequentialAnimation on anchors.verticalCenterOffset {
            id: head_anim
            NumberAnimation{
                duration: 100
                from: root.headOffset + 3
                to: root.headOffset - 3
            }
            NumberAnimation{
                duration: 100
                from: root.headOffset- 3
                to: root.headOffset + 3
            }
        }
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
}
