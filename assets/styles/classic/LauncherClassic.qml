import QtQuick 2.0

Item {
    id: root
    width: root.lying ? 22 : 31
    height: root.lying ? 22 : 15
    property int team: 0
    property var colors: ["#ffff55", "#cc2020"]
    property string color: root.colors[team]
    property string borderColor: "#101010"
    property int headOffset: root.lying ? - 8 : - root.height / 4
    property bool lying: false

    Rectangle {
        id: left_arm
        width: 6
        height: 15
        radius: width / 2
        z: -1
        x: 0
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height / 5
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
                radius: 3
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
        anchors.bottomMargin: parent.height / 5
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
        color: "#dddddd"
        border.color: "#101010"
        antialiasing: true
        visible: root.lying
    }

    Rectangle{
        id: body
        width: root.width
        height: root.height
        radius: 8
        color: root.color
        border.color: root.borderColor
    }

    Rectangle {
        id: head
        width: 17
        height: 17
        radius: width / 2 + 1
        anchors.centerIn: parent
        anchors.verticalCenterOffset: root.headOffset
        color: root.hair_color()
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
    }

    onTeamChanged: {
        head.color = root.hair_color()
    }

    function hair_color() {
        var r = Math.random()
        if (r < 0.3)
            return "#202020"
        else if (r < 0.5)
            return "#d0d020"
        else if (r < 0.7)
            return "#d6cc24"
        else if (r < 0.85)
            return "#bd5f10"
        else
            return "#c0a080"
    }
}
