import QtQuick 2.2

Item {
    id: root
    width: 100
    height: 600
    property var score: [0, 0]   

    TextNum {
        id: score_text_1
        text: root.score[1]
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
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

