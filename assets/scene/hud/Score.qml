import QtQuick 2.2

Item {
    id: root
    width: 100
    height: 600
    property var score: [0, 0]
    property int current_end: 0
    property int ends: 1

    TextNum {
        id: score_text_1
        text: root.score[1]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
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
    }

    function clear() {
        root.score[0] = 0
        root.score[1] = 0
    }
}

