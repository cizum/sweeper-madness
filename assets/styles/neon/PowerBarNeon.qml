import QtQuick 2.2
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: 300
    height: 15
    color: "#303030"
    property double power: 0

    Item {
        width: (parent.width - 2) * power / 100
        height: parent.height - 2
        x: 1
        anchors.verticalCenter: parent.verticalCenter
        clip: true
        LinearGradient {
            width: root.width - 2
            height: root.height - 2
            start: Qt.point(0, height / 2)
            end: Qt.point(width, height / 2)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#101010" }
                GradientStop { position: 0.7; color: "#000000" }
                GradientStop { position: 1.0; color: "#101010" }
            }
        }
    }
}
