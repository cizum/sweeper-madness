import QtQuick 2.2
import QtGraphicalEffects 1.0
import "menu"

Item {
    id: root
    width: 1280
    height: 720
    visible: root.opacity > 0
    property bool started: false
    signal start(int ends, int stones, int players)
    signal resume()

    Behavior on opacity {
        NumberAnimation {duration: 300}
    }

    Title {
        id: title
        text: "Sweeper Madness"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -180
        opacity: 0.8
    }

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 20
        width: paramters_row.width
        spacing: 20

        Row {
            id: paramters_row
            spacing: 10

            ChoiceList {
                id: stones_choicelist
                name: "stones"
                index: 2
                model: [2, 4, 8, 12, 16]
            }

            ChoiceList {
                id: end_choicelist
                name: index === 0 ? "end" : "ends"
                index: 3
                model: [1, 2, 3, 4, 5, 6, 7, 8]
            }
        }

        ChoiceList{
            id: players_choicelist
            name: index === 0 ? "player" : "players"
            index: 1
            model: [1, 2]
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Button {
        id: start_button
        text: "START"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 250
        onClicked: root.start(end_choicelist.current, stones_choicelist.current, players_choicelist.current)
        visible: root.started == false
    }

    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 250
        spacing: 20
        Button {
            id: newstart_button
            text: "NEW"
            onClicked: root.start(end_choicelist.current, stones_choicelist.current, players_choicelist.current)
        }
        Button {
            id: resume_button
            text: "RESUME"
            onClicked: root.resume()
        }
        visible: root.started == true
    }
}

