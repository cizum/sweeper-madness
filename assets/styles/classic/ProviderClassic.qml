import QtQuick 2.0

Item {
    id: root
    width: 31
    height: 15
    property int team: 0
    property var colors: ["#ffff55", "#cc2020"]
    property string color: root.colors[team]
    property string borderColor: "#101010"
    property int headOffset: -3

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
        anchors.bottom: parent.verticalCenter
        x: parent.width / 2 - (root.team == 0 ? 0 : width)
        color: root.color
        border.color: "#101010"
        antialiasing: true
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

    Rectangle {
        id: foot
        width: 8
        height: 5
        z: -1
        radius: width / 2 + 1
        anchors.horizontalCenter: leg.horizontalCenter
        anchors.top: leg.top
        color: "#dddddd"
        border.color: "#101010"
        antialiasing: true
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

    function shoot() {
        leg_anim.restart()
    }
}
