import QtQuick 2.0

import krus.morten.style 1.0

Rectangle {
    id: root

    property bool sun: false
    property int rayHeight: 0
    property int rays: 5

    width: 32
    height: 32
    radius: width
    color: Style.buttonTextColor

    Repeater {
        id: repeater

        model: root.rays

        Rectangle {
            width: 2
            height: root.rayHeight
            anchors.centerIn: parent
            color: Style.buttonTextColor
            rotation: index * 180 / root.rays
            antialiasing: true
        }
    }

    Rectangle {
        id: mask

        x: -8
        y: -3
        width: 32
        height: 32
        radius: height
        color: Style.buttonBackgroundColor
    }

    states: [
        State {
            name: "SUN"
            when: root.sun
            PropertyChanges {
                target: mask
                x: 2
                y: 2
                width: 28
                height: 28
            }
            PropertyChanges {
                target: root
                rayHeight: 42
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation {
                target: mask
                properties: "x, y, width, height"
                duration: 300
            }
            NumberAnimation {
                target: root
                property: "rayHeight"
                duration: 400
            }
        }
    ]
}
