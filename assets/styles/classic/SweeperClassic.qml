import QtQuick 2.2

Item {
    id: root
    width: 31
    height: 15
    antialiasing: true
    property int team: 0
    property var colors: ["#ffff55", "#cc2020"]
    property string color: root.colors[team]
    property string borderColor: "#101010"
    property int headOffset: - root.height / 4

    Rectangle {
        id: broom
        width: 5
        height: 15
        z: -1
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -parent.width / 2
        color: "#808090"
        border.color: root.borderColor
        antialiasing: true
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
            radius: 3
            color: "#202020"
            border.color: root.borderColor
            antialiasing: true
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
            return "#a68c24"
        else if (r < 0.85)
            return "#bd5f10"
        else
            return "#c0a080"
    }

    function shake_head() {
        head_anim.restart()
    }

    function sweep() {
        root.shake_head()
        broom_anim.restart()
        left_arm_anim.restart()
        right_arm_anim.restart()
    }
}
