import QtQuick 2.9
import QtGraphicalEffects 1.0

import krus.morten.style 1.0

Item {
    id: root

    width: 550
    height: 200

    property var totalScore: [0, 0]
    property var score: [0, 0]
    property int currentEnd: 0
    property int ends: 1

    TextNum {
        id: endScoreText1

        text: root.score[1]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - root.width / 3
        anchors.verticalCenterOffset: -root.height / 2
        color: Style.redPlayerColor
        font.pixelSize: 70
    }

    TextNum {
        id: endScoreText2

        text: root.score[0]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: root.width / 3
        anchors.verticalCenterOffset: -root.height / 2
        color: Style.yellowPlayerColor
        font.pixelSize: 70
    }

    TextNum{
        id: end

        text: (root.currentEnd + 1) + "/" + root.ends
        font.pixelSize: 60
        anchors.bottom: parent.bottom
        color: Style.endColor
    }

    TextNum {
        id: totalScoreText1

        text: root.totalScore[1]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - root.width / 2
        anchors.verticalCenterOffset:  - root.height / 2
        color: Style.redPlayerColor
    }

    TextNum {
        id: totalScoreText2

        text: root.totalScore[0]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: root.width / 2
        anchors.verticalCenterOffset:  - root.height / 2
        color: Style.yellowPlayerColor
    }

    function clear() {
        root.totalScore[0] = 0
        root.totalScore[1] = 0
        root.score[0] = 0
        root.score[1] = 0
    }
}

