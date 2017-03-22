import QtQuick 2.2
import QtQuick.Window 2.2

Item {
    id: root
    anchors.centerIn: parent
    width: Screen.width
    height: Screen.height
    property int style: 0
    property int team: 0
    property var names: root.style == 0 ? ["Yellow", "Red"] : ["Gold", "Turquoise"]
    property var colors: root.style == 0 ? ["#ffff55", "#cc2020"] : ["#ffbb00", "#00bbff"]
    property var colorsNeon: ["#ffbb00", "#00bbff"]

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
