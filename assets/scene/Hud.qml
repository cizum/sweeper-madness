import QtQuick 2.2
import "hud"

Item {
    id:root
    anchors.fill: parent
    property int style: 0
    property bool debug: false
    property alias power: power_bar.power
    property alias direction: direction_bar.direction
    property alias score: score_display.score
    property alias total_score: score_display.total_score
    property alias phase: indications.phase
    property alias current_end: score_display.current_end
    property alias ends: score_display.ends
    property alias areas: areas

    PowerBar {
        id: power_bar
        anchors.horizontalCenter: parent.horizontalCenter
        y: 640
        style: root.style
    }

    DirectionBar {
        id: direction_bar
        anchors.horizontalCenter: parent.horizontalCenter
        y: 515
        style: root.style
    }

    Winner {
        id: winner_display
        visible: false
        style: root.style
    }

    Score {
        id: score_display
        anchors.horizontalCenter: parent.horizontalCenter
        y: 80
        style: root.style
    }

    Indications {
        id: indications
        y: 675
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.style == 1 ? "#eeeeee" : "#101010"
    }

    Areas {
        id: areas
        visible: root.debug
    }

    FuturePath {
        id: future_path
        visible: root.debug && (root.phase == 4 || root.phase == 5)
    }

    Stone{
        id: ghost
        team: 2
        opacity: 0.4
        visible: root.debug && (root.phase == 4 || root.phase == 5)
        style: root.style

        Behavior on xC {
            NumberAnimation { duration: 80 }
        }
        Behavior on yC {
            NumberAnimation { duration: 80 }
        }
    }

    function update_future_path(stone) {
        var end_t = stone.end_time()
        for (var i = 0; i < future_path.count; i++) {
            var t = (i+1) * end_t / (future_path.count + 1)
            var r = stone.future_position(t)
            future_path.children[i].xC = r[0]
            future_path.children[i].yC = r[1]
        }
    }

    function update_ghost(xC, yC) {
        ghost.xC = xC
        ghost.yC = yC
    }

    function show_winner() {
        if (root.total_score[0] === root.total_score[1])
            winner_display.team = -1
        else
            winner_display.team = root.total_score[0] > root.total_score[1] ? 0 : 1
        winner_display.visible = true
    }

    function initialize() {
        winner_display.visible = false
        score_display.clear()
    }
}

