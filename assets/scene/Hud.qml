import QtQuick 2.9
import "hud"

Item {
    id: root

    anchors.fill: parent
    property bool debug: false
    property bool help: false
    property alias score: scoreDisplay.score
    property alias totalScore: scoreDisplay.totalScore
    property int phase: 0
    property alias currentEnd: scoreDisplay.currentEnd
    property alias ends: scoreDisplay.ends
    property alias areas: areas

    Winner {
        id: winnerDisplay

        visible: false
    }

    Score {
        id: scoreDisplay

        anchors.horizontalCenter: parent.horizontalCenter
        y: 180
    }

    Areas {
        id: areas

        visible: root.debug
    }

    FuturePath {
        id: futurePath

        visible: (root.debug || root.help) && (root.phase === 4 || root.phase === 5)
    }

    Stone{
        id: ghost

        team: 2
        opacity: 0.4
        visible: (root.debug || root.help) && (root.phase === 4 || root.phase === 5)

        Behavior on xC {
            NumberAnimation { duration: 80 }
        }
        Behavior on yC {
            NumberAnimation { duration: 80 }
        }
    }

    function updateFuturePath(stone) {
        var endT = stone.endTime()
        for (var i = 0; i < futurePath.count; i++) {
            var t = (i+1) * endT / (futurePath.count + 1)
            var r = stone.futurePosition(t)
            futurePath.children[i].xC = r[0]
            futurePath.children[i].yC = r[1]
        }
    }

    function updateGhost(xC, yC) {
        ghost.xC = xC
        ghost.yC = yC
    }

    function showWinner() {
        if (root.totalScore[0] === root.totalScore[1])
            winnerDisplay.team = -1
        else
            winnerDisplay.team = root.totalScore[0] > root.totalScore[1] ? 0 : 1
        winnerDisplay.visible = true
    }

    function initialize() {
        winnerDisplay.visible = false
        scoreDisplay.clear()
    }
}

