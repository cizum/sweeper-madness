import QtQuick 2.9

import krus.morten.style 1.0

Rectangle {
    id: root

    height: 1181
    width: 261
    color: Style.sheetColor

    property int startLine: 970
    property int endSweepLine: 260
    property int dTarget: root.width - 40
    property int xTarget: 20 + root.rTarget
    property int yTarget: root.width / 2
    property int rTarget: root.dTarget / 2

    property int colorMode: 0

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 3
        height: parent.height
        color: Style.lineColor
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.startLine
        width: parent.width - border.border.width * 2
        height: 4
        color: Style.startLineColor
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.endSweepLine
        width: parent.width - border.border.width * 2
        height: 4
        color: Style.startLineColor
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: target.y + target.height / 2 - 1
        width: parent.width
        height: 3
        color: Style.lineColor
    }

    Rectangle {
        id: target

        y: root.yTarget - root.rTarget
        anchors.horizontalCenter: parent.horizontalCenter
        height: root.dTarget
        width: root.dTarget
        radius: width / 2
        border.width: 45
        color: "transparent"
        border.color: Style.targetExColor(root.colorMode)
        opacity: 0.8

        Rectangle {
            anchors.centerIn: parent
            height: parent.width/3
            width: parent.height/3
            radius: width/2
            border.width: 25
            color: "transparent"
            border.color: Style.targetInColor(root.colorMode)
        }
    }

    Rectangle {
        id: border

        anchors.fill: parent
        color: "transparent"
        border.color: Style.sheetBorderColor
        border.width: 4
    }

    function randomColors() {
        root.colorMode = Math.floor(3 * Math.random())
    }
}
