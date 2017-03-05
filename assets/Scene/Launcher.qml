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
//    Rectangle{
//        id: bretelle1
//        width: 4
//        height: parent.height - 2
//        x: parent.width / 7
//        anchors.verticalCenter: parent.verticalCenter
//        border.width: 1
//        border.color: parent.border.color
//    }
//    Rectangle{
//        id: bretelle2
//        width: 4
//        height: parent.height - 2
//        x: parent.width - parent.width / 7 - width
//        anchors.verticalCenter: parent.verticalCenter
//        border.width: 1
//        border.color: parent.border.color
//    }

    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height / 2
        angle: 90
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

    Behavior on x{
        id: move_smooth_x
        enabled: false
        onEnabledChanged: if (enabled) animx_reducer.restart()
        NumberAnimation{
            duration: 5000
            NumberAnimation on duration {
                id: animx_reducer
                running: move_smooth_x.enabled
                from: 5000
                to: 0
                duration: 5000
                onStopped: move_smooth_x.enabled = false
            }
        }
    }

    Behavior on y{
        id: move_smooth_y
        enabled: false
        onEnabledChanged: if (enabled) animy_reducer.restart()
        NumberAnimation{
            duration: 5000
            NumberAnimation on duration {
                id: animy_reducer
                from: 5000
                to: 0
                duration: 5000
                onStopped: move_smooth_y.enabled = false
            }
        }
    }
}
