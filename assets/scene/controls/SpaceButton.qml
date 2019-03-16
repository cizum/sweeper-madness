import QtQuick 2.9
import QtGraphicalEffects 1.0

import krus.morten.style 1.0

MultiPointTouchArea {
    id: root

    width: 120
    height: 120

    Rectangle {
        id: background

        color: Style.spaceButtonMinColor
        anchors.fill: parent

        SequentialAnimation on color {
            id: backgroundAnim

            loops: Animation.Infinite
            running: root.enabled

            ColorAnimation {
                from: Style.spaceButtonMinColor
                to: Style.spaceButtonMaxColor
                duration: 1000
            }

            ColorAnimation {
                from: Style.spaceButtonMaxColor
                to: Style.spaceButtonMinColor
                duration: 1000
            }
        }
    }

    Connections {
        target: Style
        onDarkModeChanged: backgroundAnim.restart()
    }

    states: [
        State {
            name: "up"
        },
        State {
            name: "down"
            PropertyChanges {
                target: background
                color: Style.spaceButtonDownColor
            }
        },
        State {
            name: "disabled"
            when: !root.enabled
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            ColorAnimation {duration: 200}
        }
    ]

    onPressed: root.state = "down"
    onReleased: root.state = "up"
    onCanceled: root.state = "up"
}

