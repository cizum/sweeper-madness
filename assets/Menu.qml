import QtQuick 2.2
import QtGraphicalEffects 1.0
import "Menu"

Item {
    id: root
    width: 1280
    height: 720
    visible: opacity > 0
    signal start()

    Behavior on opacity {
        NumberAnimation {duration: 500}
    }

    Rectangle{
        id: background
        anchors.fill: parent
        color: "#ddddee"
    }

    Text {
        id: title_part_2
        text: "Sweeper Madness"
        font.family: "PaintyPaint"
        font.pixelSize: 120
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -205
        anchors.horizontalCenterOffset: -5
        color: "#8989aa"
        opacity: 0.8
    }

    Text {
        id: title_part_1
        text: "Sweeper Madness"
        font.family: "PaintyPaint"
        font.pixelSize: 120
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -200
        color: "#ffffff"
        opacity: 0.8
    }

    ButtonMenu {
        id: start_button
        text: "START"
        width: 350
        height: 180
        textsize: 110
        textcolor: "#8989aa"
        textcolorHover: "#aaaadd"
        textcolorDown: "#aaaaee"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 95
        onClicked: root.start()
    }
}

