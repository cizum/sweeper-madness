import QtQuick 2.2

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

    Keys.onPressed: {
        if (!event.isAutoRepeat){
            if (event.key === Qt.Key_F3) {
                root.debug()
            }
            else if (event.key === Qt.Key_M) {
                root.mute()
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
}

