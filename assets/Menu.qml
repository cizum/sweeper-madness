import QtQuick 2.2
import QtGraphicalEffects 1.0
import "menu"

Item {
    id: root
    width: 1280
    height: 720
    visible: root.opacity > 0
    signal start()

    Behavior on opacity {
        NumberAnimation {duration: 500}
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#ddddee"
    }

    Title {
        id: title
        text: "Sweeper Madness"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -180
        opacity: 0.8
    }

    Button {
        id: start_button
        text: "START"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 95
        onClicked: root.start()
    }
}

