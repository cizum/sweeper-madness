import QtQuick 2.0

Rectangle {
    id: root
    width: 25
    height: 25
    radius: width / 2 + 1
    color: "#aaaaaa"
    border.color: "#101010"
    property int team: 0
    property var colors: ["#ffff55", "#cc2020", "#ffffff", "#5555ff"]
    property string main_color: colors[team]

    Rectangle {
        width: 19
        height: 19
        radius: width / 2 + 1
        anchors.centerIn: parent
        color: root.main_color
        border.color: "#aaaaee"
    }

    Rectangle {
        id: handle
        width: 9
        height: 5
        radius: width / 2 + 1
        anchors.centerIn: parent
        color: root.main_color
        border.color: "#303030"

        Rectangle {
            width: parent.height - 2
            height: parent.height - 2
            radius: width / 2 + 1
            anchors.right: parent.right
            anchors.rightMargin: -1
            anchors.verticalCenter: parent.verticalCenter
            color: root.main_color
        }
    }
}
