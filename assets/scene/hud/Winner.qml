import QtQuick 2.9
import QtGraphicalEffects 1.0
import "../tutorial"

import krus.morten.style 1.0

Item {
    id: root

    anchors.centerIn: parent
    width: 1280
    height: 1280

    property int team: 0
    property var messages: [qsTr("Yellow Team wins!") + translator.up, qsTr("Red Team wins!") + translator.up]

    Rectangle{
        anchors.fill: parent
        color: Style.teamColor(root.team)
        opacity: 0.8
    }

    BaseText {
        id: title

        text: (root.team == -1 ? qsTr("Draw...") : root.messages[root.team]) + translator.up
        font.pixelSize: 90
        width: 600
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -50
        color: Style.winnerTextColor
        visible: false
    }

    DropShadow {
        anchors.fill: title
        source: title
        horizontalOffset: 4
        verticalOffset: 4
        radius: 8.0
        samples: 17
        color: Style.winnerShadowColor
    }
}
