import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 100
    height: 100
    property double angle: 0
    Rectangle{
        id: needle
        width: 9
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#bbbbcc"
        transform: Rotation{
            origin.y: needle.height
            angle: root.angle
        }
        antialiasing: true
        smooth: true
        Rectangle{
            id: needle_top
            color: "#bbbbcc"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 2
            width: 1.5 * needle.width
            height: width
            antialiasing: true
            transform: Rotation{
                origin.x: needle_top.width / 2
                origin.y: needle_top.height / 2
                angle: 45
            }
        }
    }
    Rectangle{
        id: base
        width: 13
        height: 13
        radius: height / 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#bbbbcc"
    }
}
