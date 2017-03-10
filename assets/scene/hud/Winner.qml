import QtQuick 2.2

Item {
    id: root
    anchors.fill: parent
    property int team: 0
    property var names: ["Yellow", "Red", "Green", "Blue"]
    property var colors: ["#ffff55", "#cc2020", "#55ff55", "#5555ff"]

    Rectangle{
        anchors.fill: parent
        color: root.team == -1 ? "#55ffff" : root.colors[team]
        opacity: 0.8
    }

    Text {
        id: title_part_2
        text: root.team == -1 ? "Draw..." : root.names[team] + " Team wins !"
        font.family: "PaintyPaint"
        font.pixelSize: 130
        anchors.centerIn: parent
        color: "#101010"
        opacity: 0.9
    }

}
