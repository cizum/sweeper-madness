import QtQuick 2.2

Rectangle {
    id: root
    width: 31
    height: width / 2
    radius: width / 2 + 1
    color: "#800000"
    border.color: "#101010"
    antialiasing: true
    x: xC - width / 2
    y: yC - height /2
    z: 1
    property double xC: 0
    property double yC: 0
    property bool sweeping: false

    Rectangle{
        id: sweeper
        width: 5
        height: parent.width
        z: -1
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -parent.width / 2
        color: "#805030"
        border.color: "#101010"
        antialiasing: true
        Rectangle{
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 15
            height: 6
            color: "#121212"
            border.color: "#101010"
            antialiasing: true
        }
        transform: Rotation{
            origin.x: sweeper.width / 2
            origin.y: sweeper.height
            angle: 25
        }
        SequentialAnimation on height{
            id: sweeper_anim
            running: root.sweeping
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
        border.color: root.border.color
        antialiasing: true
        transform: Rotation{
            origin.x: 0
            origin.y: left_arm.height
            angle: 50
            SequentialAnimation on angle {
                id: left_arm_anim
                running: root.sweeping
                //loops: Animation.Infinite
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
        border.color: root.border.color
        antialiasing: true
        transform: Rotation{
            origin.x: right_arm.width
            origin.y: left_arm.height
            angle: -5
            SequentialAnimation on angle {
                id: right_arm_anim
                running: root.sweeping
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
    Rectangle {
        id: head
        width: 17
        height: 17
        radius: width / 2 + 1
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -5
        color: hair_color()
        border.color: "#101010"
        antialiasing: true
        SequentialAnimation on anchors.verticalCenterOffset {
            id: head_anim
            running: root.sweeping
            NumberAnimation{
                duration: 100
                from: -2
                to: -6
            }
            NumberAnimation{
                duration: 100
                from: -6
                to: -2
            }
        }
    }

    onColorChanged:{
        head.color = hair_color()
    }

    function hair_color(){
        var r = Math.random()
        if (r < 0.4)
            return "#202020"
        else if (r < 0.65)
            return "#d0d020"
        else if (r < 0.95)
            return "#a68c24"
        else
            return "#bd5f10"
    }

    function sweep(){
        head_anim.restart()
        sweeper_anim.restart()
        left_arm_anim.restart()
        right_arm_anim.restart()
    }

    function move_smooth(){
        move_smooth_x.enabled = true;
        move_smooth_y.enabled = true;
    }

    Behavior on x {
        id: move_smooth_x
        enabled: false
        NumberAnimation {
            duration: 2000
            easing.type: "OutCubic"
            NumberAnimation on duration {
                running: move_smooth_x.enabled
                from: 2000
                to: 0
                duration: 2000
                easing.type: "OutCubic"
                onStopped: move_smooth_x.enabled = false
            }
        }
    }
    Behavior on y {
        id: move_smooth_y
        enabled: false
        NumberAnimation {
            duration: 2000
            NumberAnimation on duration {
                running: move_smooth_y.enabled
                from: 2000
                to: 0
                duration: 2000
                easing.type: "OutCubic"
                onStopped: move_smooth_y.enabled = false
            }
        }
    }
}
