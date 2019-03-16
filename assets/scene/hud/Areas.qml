import QtQuick 2.9

Item {
    id: root

    x: xC - r
    y: yC - r
    width: 2 * r + 1
    height: 2 * r + 1

    property double xC: 0
    property double yC: 0
    property double r: 100
    property double ir: r / 3
    property int nSlices: 8

    Rectangle {
        id: borderCircle

        anchors.centerIn: parent
        width: 2 * root.r + 1
        height: 2 * root.r + 1
        radius: root.r
        border.width: 3
        color: "transparent"
        border.color: "#ffffff"
    }

    Rectangle {
        id: insideCircle

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
            model: root.nSlices

            Item {
                width: root.r
                height: 3
                antialiasing: true
                transform: Rotation {
                    origin {x: 0; y: 0; z: 0}
                    axis {x: 0; y: 0; z: 1}
                    angle: index * 360 / root.nSlices
                }

                Rectangle {
                    anchors.right: parent.right
                    width: root.r - root.ir
                    height: 3
                    color: "#ffffff"
                }
            }
        }
    }
}
