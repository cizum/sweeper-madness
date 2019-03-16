import QtQuick 2.9

import krus.morten.style 1.0

Rectangle {
    id: root

    width: 25
    height: 25
    radius: width / 2 + 1
    color: Style.stoneColor
    border.color: Style.stoneBorderColor

    property int team: 0
    property string mainColor: Style.teamColor(team)

    Rectangle {
        width: 19
        height: 19
        radius: width / 2 + 1
        anchors.centerIn: parent
        color: root.mainColor
        border.color: Style.stoneCenterBorderColor
    }

    Rectangle {
        id: handle

        width: 5
        height: 9
        radius: height / 2 + 1
        anchors.centerIn: parent
        color: root.mainColor
        border.color: Style.stoneHandleBorderColor

        Rectangle {
            width: parent.width - 2
            height: parent.width - 2
            radius: width / 2 + 1
            anchors.top: parent.top
            anchors.topMargin: -1
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.mainColor
        }
    }
}
