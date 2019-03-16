import QtQuick 2.9

import krus.morten.style 1.0

Rectangle {
    id: root

    width: 8
    height: 0
    radius: width / 2 + 1
    antialiasing: true

    property bool laid: false

    SequentialAnimation on height {
        id: legAnim

        NumberAnimation{
            duration: 100
            from: 0
            to: 25
        }

        NumberAnimation{
            duration: 300
            from: 25
            to: 0
        }
    }

    Rectangle {
        id: foot

        width: 8
        height: 5
        radius: width / 2 + 1
        anchors.horizontalCenter: root.horizontalCenter
        color: Style.playerFootColor
        border.color: root.border.color
    }

    function move() {
        legAnim.restart()
    }

    states: [
        State {
            name: "LAID"
            when: root.laid
            PropertyChanges {
                target: root
                height: 24
                anchors.bottomMargin: -36
                anchors.rightMargin: 0
            }
            PropertyChanges {
                target: foot
                y: root.height - foot.height
            }
        }
    ]

    Behavior on height {
        NumberAnimation {
            duration: 100
        }
    }
}
