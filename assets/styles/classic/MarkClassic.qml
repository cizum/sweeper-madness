import QtQuick 2.0

Rectangle {
    id: root
    color: "#ffffff"
    width: 2 + Math.random() * 8
    height: 2
    radius: 2
    NumberAnimation on opacity {
        duration: 2000
        from: 1.0
        to: 0.2
    }
}
