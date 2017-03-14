import QtQuick 2.2

Item {
    id: root
    width: 100
    height: 100
    property double direction: 0
    property string color: "#303030"

    Rectangle {
        id: needle
        width: 9
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color
        antialiasing: true
        transform: Rotation {
            origin.y: needle.height
            angle: root.direction
        }

        Rectangle {
            id: needle_top
            color: root.color
            width: 1.5 * needle.width
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 2
            antialiasing: true
            transform: Rotation {
                origin.x: needle_top.width / 2
                origin.y: needle_top.height / 2
                angle: 45
            }
        }
    }

    Rectangle {
        id: base
        width: 13
        height: 13
        radius: height / 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.color
    }
}
