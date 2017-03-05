import QtQuick 2.3

Item {
    id:root
    objectName: "controls"
    anchors.fill: parent
    focus:true

    signal pressL1
    signal pressL2
    signal pressR2
    signal pressR1
    property bool pressedL1: false
    property bool pressedL2: false
    property bool pressedR1: false
    property bool pressedR2: false

    signal releaseL1
    signal releaseL2
    signal releaseR2
    signal releaseR1
    signal restart

    Keys.onPressed: {
        if (!event.isAutoRepeat){
            if (event.key === Qt.Key_Q) {
                pressL1()
                pressedL1 = true
            }
            else if (event.key === Qt.Key_D) {
                pressL2()
                pressedL2 = true
            }
            else if (event.key === Qt.Key_Left) {
                pressR1()
                pressedR1 = true
            }
            else if (event.key === Qt.Key_Right) {
                pressR2()
                pressedR2 = true
            }
            else if (event.key === Qt.Key_R) {
            }
        }
    }

    Keys.onReleased: {
        if (!event.isAutoRepeat){
            if (event.key === Qt.Key_Escape) {
                leaveFullScreen()
            }
            else if (event.key === Qt.Key_M) {
                menuPause()
            }
            else if (event.key === Qt.Key_Q) {
                releaseL1()
                pressedL1 = false
            }
            else if (event.key === Qt.Key_D) {
                releaseL2()
                pressedL2 = false
            }
            else if (event.key === Qt.Key_Left) {
                releaseR1()
                pressedR1 = false
            }
            else if (event.key === Qt.Key_Right) {
                releaseR2()
                pressedR2 = false
            }
            else if (event.key === Qt.Key_Space) {
                restart()
            }
        }
    }
}

