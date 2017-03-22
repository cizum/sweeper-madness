import QtQuick 2.2
import "controls"

Item {
    id:root
    objectName: "controls"
    anchors.fill: parent
    focus:true
    property bool playing: true
    signal pressUp()
    signal pressDown()
    signal pressSpace()
    signal releaseUp()
    signal releaseDown()
    signal restart()
    signal debug()
    signal menu()
    signal mute()
    signal changeStyle()
    property bool mobile: version === "mobile"
    property int phase: 0

    Keys.onPressed: {
        if (!event.isAutoRepeat){
            if (event.key === Qt.Key_F3) {
                root.debug()
            }
            else if (event.key === Qt.Key_M) {
                root.mute()
            }
            else if (event.key === Qt.Key_S) {
                root.changeStyle()
            }
            else if (root.playing) {
                if (event.key === Qt.Key_Up) {
                    root.pressUp()
                }
                else if (event.key === Qt.Key_Down) {
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
                if (event.key === Qt.Key_Up) {
                    root.releaseUp()
                }
                else if (event.key === Qt.Key_Down) {
                    root.releaseDown()
                }
            }
        }
    }

    GameButton {
        id: left_button
        x: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        text: "⇧"
        onPressed: root.pressUp()
        onReleased: root.releaseUp()
        visible: root.mobile
    }

    GameButton {
        id: right_button
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        text: "⇩"
        onPressed: root.pressDown()
        onReleased: root.releaseDown()
        visible: root.mobile
    }

    GameButton {
        id: space_button
        width: 650
        height: 170
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        text: ""
        onPressed: root.pressSpace()
        visible: root.mobile
    }

    GameButton {
        id: menu_button
        width: 110
        height: 80
        x: 20
        y: 15
        text: "Menu"
        textsize: 25
        onPressed: root.menu()
        visible: root.mobile
    }
}

