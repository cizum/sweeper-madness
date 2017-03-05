import QtQuick 2.2

Item {
    id:root
    width: 100
    height: 600
    property int score0: 0
    property int score1: 0

    TextNum{
        id:score1Text
        text:score1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }
    TextNum{
        id:score0Text
        text:score0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }
    function restart(){
        score0 = 0
        score1 = 0
    }
}

