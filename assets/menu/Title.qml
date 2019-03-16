import QtQuick 2.9
import QtGraphicalEffects 1.0

import krus.morten.style 1.0

Item {
    id: root

    width: 700
    height: 280

    property string text: ""
    property string fontName: "I AM A PLAYER"
    property int fontSize: 150
    property int colorOrder: Math.random() < 0.5

    Item {
        id: title

        anchors.fill: parent

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Sweeper"
            font.family: root.fontName
            font.pixelSize: root.fontSize
            color: root.colorOrder ? Style.yellowPlayerColor : Style.redPlayerColor
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            text: "Madness"
            font.family: root.fontName
            font.pixelSize: root.fontSize - 20
            color: root.colorOrder ? Style.redPlayerColor : Style.yellowPlayerColor
        }
    }

    DropShadow {
        anchors.fill: title
        source: title
        horizontalOffset: 5
        verticalOffset: 5
        radius: 8.0
        samples: 17
        color: Style.titleShadowColor
    }
}
