import QtQuick 2.9
import QtGraphicalEffects 1.0

import krus.morten.style 1.0

Item {
    id: root

    width: numText.width
    height: numText.height

    property alias text: numText.text
    property alias color: numText.color
    property alias font: numText.font

    Text {
        id: numText

        font.pixelSize: 160
        color: Style.buttonTextColor
        font.family: "I AM A PLAYER"
        visible: false
    }

    DropShadow {
        anchors.fill: numText
        source: numText
        horizontalOffset: 0
        verticalOffset: 5
        radius: 8.0
        samples: 17
        color: Style.titleShadowColor
    }
}


