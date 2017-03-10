import QtQuick 2.2
import QtGraphicalEffects 1.0
import "menu"

Item {
    id: root
    width: 1280
    height: 720
    visible: root.opacity > 0
    signal start(int ends, int stones)

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

    Column{
        anchors.centerIn: parent
        width: end_choicelist.width
        ChoiceList{
            id: end_choicelist
            name: "Number of ends"
            index: 0
            model: [1, 2, 3, 4, 5, 6, 7, 8]
        }

        ChoiceList{
            id: stones_choicelist
            name: "Number of stones"
            index: 4
            model: [2, 4, 8, 12, 16]
        }
    }

    Button {
        id: start_button
        text: "START"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 200
        onClicked: root.start(end_choicelist.current, stones_choicelist.current)
    }
}

