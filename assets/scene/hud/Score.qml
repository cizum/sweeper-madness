import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 600
    height: 100
    property var total_score: [0, 0]
    property var score: [0, 0]
    property int current_end: 0
    property int ends: 1
    property int style: 0
    property var colors: ["#ffff55", "#cc2020", "#ffbb00", "#00bbff"]

    TextNum {
        id: end_score_text_1
        text: root.score[1]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - root.width / 8
        anchors.verticalCenterOffset: root.height / 4
        color: root.style == 0 ? root.colors[1] : root.colors[3]
        font.pixelSize: 40
    }

    TextNum {
        id: end_score_text_2
        text: root.score[0]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: root.width / 8
        anchors.verticalCenterOffset: root.height / 4
        color: root.style == 0 ? root.colors[0] : root.colors[2]
        font.pixelSize: 40
    }

    Text{
        id: end
        text: (root.current_end + 1) + "/" + root.ends
        color: root.style == 0 ? "#101010" : "#aaaaaa"
        font.pixelSize: 30
        font.family: "PaintyPaint"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: root.height / 4
    }

    TextNum {
        id: total_score_text_1
        text: root.total_score[1]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - root.width / 4
        anchors.verticalCenterOffset:  - root.height / 4
        color: root.style == 0 ? root.colors[1] : root.colors[3]
    }

    TextNum {
        id: total_score_text_2
        text: root.total_score[0]
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: root.width / 4
        anchors.verticalCenterOffset:  - root.height / 4
        color: root.style == 0 ? root.colors[0] : root.colors[2]
    }

    function clear() {
        root.total_score[0] = 0
        root.total_score[1] = 0
        root.score[0] = 0
        root.score[1] = 0
    }
}

