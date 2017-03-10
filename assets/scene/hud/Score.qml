import QtQuick 2.2

Item {
    id: root
    width: 100
    height: 600
    property var total_score: [0, 0]
    property var score: [0, 0]
    property int current_end: 0
    property int ends: 1

    TextNum {
        id: total_score_text_1
        text: root.total_score[1]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        visible: root.current_end > 0
    }
    TextNum {
        id: score_text_1
        text: root.score[1]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 80
        font.pixelSize: 50
        color:"#505050"
    }

    Text{
        id: end
        text: "End " + (root.current_end + 1) + "/" + root.ends
        color:"#10101010"
        font.pixelSize: 100
        font.family: "PaintyPaint"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset:  - 500
    }

    TextNum {
        id: score_text_2
        text: root.score[0]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
        font.pixelSize: 50
        color:"#505050"
    }
    TextNum {
        id: total_score_text_2
        text: root.total_score[0]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        visible: root.current_end > 0
    }

    function clear() {
        root.total_score[0] = 0
        root.total_score[1] = 0
        root.score[0] = 0
        root.score[1] = 0
    }
}

