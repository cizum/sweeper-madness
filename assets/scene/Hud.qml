import QtQuick 2.2
import "hud"

Item {
    id:root
    anchors.fill: parent
    property alias power: power_bar.power
    property alias direction: direction_bar.direction
    property alias score: score_display.score
    property alias phase: indications.phase

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
        winner_display.team = root.score[0] > root.score[1] ? 0 : 1
        winner_display.visible = true
    }

    function initialize() {
        winner_display.visible = false
        score_display.clear()
    }
}

