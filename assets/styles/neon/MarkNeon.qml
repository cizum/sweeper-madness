import QtQuick 2.0

Item {
    id: root
    width: 11
    height: 11

    Rectangle {
        color: "#ffffff"
        border.width: 2
        border.color: "#ffffff"
        width: root.width
        height: root.height
        radius: width / 2 + 1
        anchors.centerIn: parent
        SequentialAnimation on scale {
            NumberAnimation {
                duration: 2000
                from: 1.0
                to: 0
            }
        }
    }
    NumberAnimation on opacity {
        duration: 2000
        from: 1.0
        to: 0
        onStopped: root.destroy()
    }
}
