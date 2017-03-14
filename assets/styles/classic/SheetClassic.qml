import QtQuick 2.2

Rectangle {
    id: root
    height: 261
    width: 1181
    color: "#dddaee"
    property int start_line: 210
    property int end_sweep_line: 920
    property int d_target: root.height - 40
    property int x_target: root.width - 20 - root.r_target
    property int y_target: root.height / 2
    property int r_target: root.d_target / 2

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 3
        color: "#cccccc"
    }
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        x: root.start_line
        width: 2
        color: "#555599"
        height: parent.height
    }
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        x: root.end_sweep_line
        width: 1
        color: "#cccccc"
        height: parent.height
    }
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        x: target.x + target.width / 2 - 1
        width: 3
        color: "#cccccc"
        height: parent.height
    }
    Rectangle {
        id: target
        x: root.x_target - root.r_target
        anchors.verticalCenter: parent.verticalCenter
        height: root.d_target
        width: root.d_target
        radius: width / 2
        border.width: 45
        color: "transparent"
        border.color: "#151590"
        Rectangle {
            anchors.centerIn: parent
            height: parent.width/3
            width: parent.height/3
            radius: width/2
            border.width: 25
            color: "transparent"
            border.color: "#901515"
        }
        opacity: 0.8
    }
    Rectangle {
        id: border
        anchors.fill: parent
        color: "transparent"
        border.color: "#505050"
        border.width: 2
    }
}
