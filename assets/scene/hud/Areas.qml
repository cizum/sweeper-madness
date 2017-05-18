import QtQuick 2.0

Item {
    id: root
    x: root.xC - root.r
    y: root.yC - root.r
    width: 2 * root.r + 1
    height: 2 * root.r + 1
    property double xC: 0
    property double yC: 0
    property double r: 100
    property double ir: root.r / 3
    property int n_slices: 8

    Rectangle {
        id: border_circle
        anchors.centerIn: parent
        width: 2 * root.r + 1
        height: 2 * root.r + 1
        radius: root.r
        border.width: 3
        color: "transparent"
        border.color: "#ffffff"
    }

    Rectangle {
        id: inside_circle
        anchors.centerIn: parent
        width: 2 * root.ir + 1
        height: 2 * root.ir + 1
        radius: root.ir
        border.width: 3
        color: "transparent"
        border.color: "#ffffff"
    }

    Item {
        id: slices
        anchors.centerIn: parent
        width: 0
        height: 0
        Repeater {
            model: root.n_slices
            Item {
                width: root.r
                height: 3
                antialiasing: true
                Rectangle {
                    anchors.right: parent.right
                    width: root.r - root.ir
                    height: 3
                    color: "#ffffff"
                }
                transform: Rotation {
                    origin.x: 0
                    origin.y: 0
                    origin.z: 0
                    axis.x: 0
                    axis.y: 0
                    axis.z: 1
                    angle: index * 360 / root.n_slices
                }
            }
        }
    }
}
