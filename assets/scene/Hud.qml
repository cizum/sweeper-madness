import QtQuick 2.2
import "hud"

Item {
    id:root
    anchors.fill: parent
    property alias power: power_bar.power
    property alias direction: direction_bar.direction
    property alias score: score_display.score
    property alias total_score: score_display.total_score
    property alias phase: indications.phase
    property alias current_end: score_display.current_end
    property alias ends: score_display.ends

    PowerBar {
        id: power_bar
        anchors.horizontalCenter: parent.horizontalCenter
        y: 650
    }

    DirectionBar {
        id: direction_bar
        anchors.horizontalCenter: parent.horizontalCenter
        y: 525
    }

    Winner {
        id: winner_display
        visible: false
    }

    Score {
        id: score_display
        anchors.verticalCenter: parent.verticalCenter
        x: 1050
    }

    Indications {
        id: indications
        y:50
        anchors.horizontalCenter: parent.horizontalCenter
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

