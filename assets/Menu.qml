import QtQuick 2.9
import QtGraphicalEffects 1.0
import "menu"
import "scene/controls"
import "scene/skins"

import krus.morten.style 1.0

Item {
    id: root

    width: 720
    height: 1280
    visible: root.opacity > 0

    property bool started: false
    signal start(int ends, int stones, int players)
    signal resume()

    Behavior on opacity { NumberAnimation { duration: 250 } }

    Title {
        id: title

        anchors.horizontalCenter: parent.horizontalCenter
        y: 100
        text: "Sweeper Madness"
    }

    Image {
        id: logo

        anchors.horizontalCenter: parent.horizontalCenter
        y: 400
        source: "../sweeper-madness.ico"
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 600
        spacing: 35

        ChoiceList {
            id: stonesChoiceList

            name: qsTr("stones") + translator.up
            index: 4
            model: [2, 4, 6, 8, 10, 12, 14, 16]
            colorText: Style.redColor
        }

        ChoiceList {
            id: endChoiceList

            name: (index === 0 ? qsTr("end") : qsTr("ends")) + translator.up
            index: 3
            model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
            colorText: Style.blueColor
        }

        ChoiceList{
            id: playersChoiceList

            name: (index === 0 ? qsTr("player") : qsTr("players")) + translator.up
            index: 1
            model: [1, 2]
            colorText: Style.greenColor
        }
    }

    GameButton {
        id: startButton

        width: 310
        height: 100
        radius: 0
        anchors.horizontalCenter: parent.horizontalCenter
        y: 1000
        textSize: 50
        text: qsTr("START") + translator.up
        onPressed: root.start(endChoiceList.current, stonesChoiceList.current, playersChoiceList.current)

        visible: ! root.started
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 1000
        spacing: 40

        GameButton {
            id: restartButton

            width: 310
            height: 100
            radius: 0
            textSize: 50
            text: qsTr("NEW") + translator.up
            onPressed: root.start(endChoiceList.current, stonesChoiceList.current, playersChoiceList.current)
        }

        GameButton {
            id: resumeButton

            width: 310
            height: 100
            radius: 0
            textSize: 50
            text:  qsTr("RESUME") + translator.up
            onPressed: root.resume()
        }

        visible: root.started
    }

    GameButton {
        id: languageButton

        width: 70
        height: 70
        radius: 35
        x: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        textSize: 30
        text: translator.language === "en" ? "fr" : "en"
        onReleased: translator.setLanguage(languageButton.text)
    }

    GameButton {
        id: nightButton

        width: 70
        height: 70
        radius: 35
        x: 130
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        textSize: 40
        onReleased: Style.switchMode()

        MoonSkin {
            anchors.centerIn: parent
            sun: Style.darkMode
        }
    }

    GameButton {
        id: quitButton

        width: 70
        height: 70
        radius: 35
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        textSize: 40
        onReleased: Qt.quit()
        text: "❌"
    }
}

