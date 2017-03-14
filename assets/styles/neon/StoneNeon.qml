import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 25
    height: 25
    property int team: 0
    property var colors: ["#ffbb00", "#00bbff", "#ffffff"]
    property string main_color: colors[team]

    property int samples: 17
    property double spread: 0.1

    Rectangle {
        id: outside_circle
        anchors.fill: parent
        radius: width / 2 + 1
        color: "#000000"
        border.width: 2
        border.color: root.main_color
    }

    Glow {
        anchors.fill: outside_circle
        source: outside_circle
        color:root.main_color
        samples: root.samples
        spread: root.spread
    }

    Rectangle {
        id: inside_circle
        anchors.centerIn: parent
        width: parent.width - 6
        height: parent.height - 6
        radius: width / 2 + 1
        color: "black"
        border.width: 2
        border.color: root.main_color
        visible: false
    }

    Glow {
        anchors.fill: inside_circle
        source:inside_circle
        color: root.main_color
        samples: root.samples
        spread: root.spread
    }

    Rectangle {
        id: bar
        anchors.centerIn: parent
        width: parent.width -14
        height: 2
        radius: 2
        color: root.main_color
        visible: false
        antialiasing: true
    }

    Glow {
        anchors.fill: bar
        source: bar
        color: root.main_color
        samples: root.samples
        spread: root.spread
        antialiasing: true
    }
}

