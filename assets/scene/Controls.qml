import QtQuick 2.9
import "controls"

import krus.morten.style 1.0

Item {
    id:root
    objectName: "controls"

    anchors.fill: parent
    focus:true

    property bool playing: true
    property bool helpSelected: false
    property int phase: 0
    property real directionBarXOffset: 0
    property real directionBarYOffset: 0
    property alias direction: directionBar.direction
    property int power: 0

    signal pressUp()
    signal pressDown()
    signal pressSpace()
    signal releaseUp()
    signal releaseDown()
    signal restart()
    signal debug()
    signal menu()
    signal mute()
    signal help()

    Keys.onPressed: {
        if (!event.isAutoRepeat){
            if (event.key === Qt.Key_F3) {
                root.debug()
            }
            else if (event.key === Qt.Key_M) {
                root.mute()
            }
            else if (root.playing) {
                if (event.key === Qt.Key_Left) {
                    root.pressUp()
                }
                else if (event.key === Qt.Key_Right) {
                    root.pressDown()
                }
                else if (event.key === Qt.Key_Space) {
                    root.pressSpace()
                }
            }
        }
    }

    Keys.onReleased: {
        if (!event.isAutoRepeat){
            if (event.key === Qt.Key_R) {
                root.restart()
            }
            else if (event.key === Qt.Key_Escape) {
                root.menu()
            }
            else if (root.playing) {
                if (event.key === Qt.Key_Left) {
                    root.releaseUp()
                }
                else if (event.key === Qt.Key_Right) {
                    root.releaseDown()
                }
            }
        }
    }

    GameButton {
        id: leftButton

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: spaceButton.verticalCenter
        iconState: root.phase === 4 ? "BROOM_LEFT" : "ARROW_LEFT"
        onPressed: root.pressUp()
        onReleased: root.releaseUp()
        visible: root.playing
        enabled: root.phase < 5
    }

    GameButton {
        id: rightButton

        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: spaceButton.verticalCenter
        iconState: root.phase === 4 ? "BROOM_RIGHT" : "ARROW_RIGHT"
        onPressed: root.pressDown()
        onReleased: root.releaseDown()
        visible: root.playing
        enabled: root.phase < 5
    }

    SpaceButton {
        id: spaceButton

        width: 252
        height: 204
        anchors.horizontalCenter: parent.horizontalCenter
        y: 1022
        onPressed: root.pressSpace()
        visible: root.playing && root.phase < 4
        enabled: root.phase < 4
    }

    DirectionPowerBar {
        id: directionBar

        power: root.power
        x: root.directionBarXOffset - width / 2
        y: 960 + root.directionBarYOffset
        phase: root.phase
        visible: root.phase > 1 && root.phase < 5 ? 1 : 0
    }

    GameButton {
        id: menuButton

        anchors.right: parent.right
        anchors.rightMargin: 110
        y: 320
        width: 70
        height: 70
        radius: 35
        onPressed: root.menu()

        Column {
            spacing: 4
            anchors.centerIn: parent

            Repeater {
                model: 3

                Rectangle {
                    color: Style.buttonTextColor
                    width: menuButton.width * 0.5
                    height: 5
                }
            }
        }
    }

    GameButton {
        id: helpButton

        text: "?"
        width: 70
        height: 70
        radius: 35
        textSize: 40
        anchors.left: menuButton.right
        anchors.leftMargin: 15
        y: 320
        onPressed: root.help()
        textColor: root.helpSelected ? Style.helpButtonSelectedColor : Style.buttonTextColor
        selected: root.helpSelected
    }
}

