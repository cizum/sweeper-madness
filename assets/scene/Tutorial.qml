import QtQuick 2.9
import QtGraphicalEffects 1.0
import "tutorial"

import krus.morten.style 1.0

Item {
    id: root

    anchors.fill: parent

    property int phase: 0
    property bool madiPlaying: false

    signal finish()

    BaseText {
        id: title

        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        y: 7
        text: qsTr("Help Mode") + translator.up
        color: Style.helpButtonSelectedColor
        visible: false
    }

    DropShadow {
        anchors.fill: title
        source: title
        horizontalOffset: 2
        verticalOffset: 2
        radius: 8.0
        samples: 17
        color: Style.titleShadowColor
    }

    BaseText {
        id: phase1Info

        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        y: 920
        opacity: root.phase === 1 ? 1 : 0
        visible: !root.madiPlaying
        text: qsTr("Choose a position on the starting line using left and right buttons") + translator.up
    }

    BaseText {
        id: phase2Info

        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        y: 920
        opacity: root.phase == 2 ? 1 : 0
        visible: !root.madiPlaying
        text: qsTr("Choose a direction!") + translator.up
    }

    BaseText {
        id: phase3Info

        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        y: 920
        opacity: root.phase == 3 ? 1 : 0
        visible: !root.madiPlaying
        text: qsTr("Choose the power of the throw!") + translator.up
    }

    BaseText {
        id: phase4Info

        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        y: 920
        opacity: root.phase == 4 ? 1 : 0
        visible: !root.madiPlaying
        text: qsTr("Sweep right to make the stone go to the left and vice versa") + translator.up
    }

    BaseText {
        id: phase123Info

        text: qsTr("Tap here to validate") + translator.up
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 150
        opacity: root.phase > 0 && root.phase < 4 ? 1 : 0
        visible: !root.madiPlaying
    }

    BaseText {
        id: madiInfo

        width: 700
        anchors.horizontalCenter: parent.horizontalCenter
        y: 920
        visible: root.madiPlaying
        text: qsTr("Let Billy show you the right way") + translator.up
    }
}
