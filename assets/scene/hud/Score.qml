import QtQuick 2.2

Item {
    id: root
    width: 100
    height: 550
    property var total_score: [0, 0]
    property var score: [0, 0]
    property int current_end: 0
    property int ends: 1
    property string color:"#101010"

    TextNum {
        id: total_score_text_1
        text: root.total_score[1] + root.score[1]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: root.color
    }

    TextNum {
        id: total_score_text_2
        text: root.total_score[0] + root.score[0]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: root.color
    }

    function clear() {
        root.total_score[0] = 0
        root.total_score[1] = 0
        root.score[0] = 0
        root.score[1] = 0
    }
}

