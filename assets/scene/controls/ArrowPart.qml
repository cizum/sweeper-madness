import QtQuick 2.9

import krus.morten.style 1.0

Item {
    id: root

    property int side: 0
    property color color: Style.buttonTextColor

    Rectangle {
        anchors.fill: root
        anchors.leftMargin: root.side === 0 ? root.width / 2 - root.height / 2 : undefined
        anchors.rightMargin: root.side === 1 ? root.width / 2 - root.height / 2 : undefined
        color: root.color
    }
}
