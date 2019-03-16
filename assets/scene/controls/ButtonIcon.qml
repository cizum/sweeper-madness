import QtQuick 2.9
import QtGraphicalEffects 1.0

import krus.morten.style 1.0

Item {
    id: root

    width: 85
    height: 85

    property string color: Style.buttonTextColor

    Item {
        id: movingItem
        anchors.fill: parent

        Rectangle {
            id: bar

            width: parent.width * 0.75
            height: parent.height / 10
            anchors.centerIn: parent
            color: root.color

            ArrowPart {
                id: arrowPart1

                width: root.width * 0.60
                height: root.height / 10
                anchors.centerIn: bar
                color: root.color
            }

            ArrowPart {
                id: arrowPart2

                width: root.width * 0.60
                height: root.height / 10
                anchors.centerIn: bar
                color: root.color
            }

            Rectangle {
                id: broomPart

                width: 0
                height: root.height * 0.4
                anchors.centerIn: parent
                color: root.color
            }
        }
        visible: false
    }

    DropShadow {
        anchors.fill: movingItem
        source: movingItem
        horizontalOffset: 1
        verticalOffset: 1
        radius: 4.0
        samples: 17
        color: "#80252525"
    }

    states: [
        State {
            name: "IDLE"
            PropertyChanges {
                target: root
                opacity: 0
            }
        },
        State {
            name: "ARROW_LEFT"
            PropertyChanges {
                target: arrowPart1
                side: 0
                anchors.horizontalCenterOffset: - bar.width / 2
                rotation: -45
            }
            PropertyChanges {
                target: arrowPart2
                side: 0
                anchors.horizontalCenterOffset: - bar.width / 2
                rotation: 45
            }

        },
        State {
            name: "ARROW_RIGHT"
            PropertyChanges {
                target: arrowPart1
                side: 1
                anchors.horizontalCenterOffset: bar.width / 2
                rotation: -45
            }
            PropertyChanges {
                target: arrowPart2
                side: 1
                anchors.horizontalCenterOffset: bar.width / 2
                rotation: 45
            }
        },
        State {
            name: "BROOM_LEFT"
            PropertyChanges {
                target: bar
                rotation: - 135
            }
            PropertyChanges {
                target: arrowPart1
                side: 0
                anchors.horizontalCenterOffset: - bar.width / 2
                rotation: -90
            }
            PropertyChanges {
                target: arrowPart2
                side: 0
                anchors.horizontalCenterOffset: - bar.width / 2
                rotation: 90
            }
            PropertyChanges {
                target: broomPart
                anchors.horizontalCenterOffset: - bar.width / 2  - arrowPart1.height / 2
                width: root.width / 5
            }
        },
        State {
            name: "BROOM_RIGHT"
            PropertyChanges {
                target: bar
                rotation: 135
            }
            PropertyChanges {
                target: arrowPart1
                side: 1
                anchors.horizontalCenterOffset: bar.width / 2
                rotation: -90
            }
            PropertyChanges {
                target: arrowPart2
                side: 1
                anchors.horizontalCenterOffset: bar.width / 2
                rotation: 90
            }
            PropertyChanges {
                target: broomPart
                anchors.horizontalCenterOffset: bar.width / 2 + arrowPart1.height / 2
                width: root.width / 5
            }
        }
    ]

    transitions: [
        Transition { to: "BROOM_LEFT"; animations: arrowToBroom},
        Transition { to: "BROOM_RIGHT"; animations: arrowToBroom},
        Transition { to: "ARROW_LEFT"; animations: broomToArrow},
        Transition { to: "ARROW_RIGHT"; animations: broomToArrow}
    ]

    SequentialAnimation {
        id: arrowToBroom

        NumberAnimation { property: "anchors.horizontalCenterOffset"; duration: 0}
        NumberAnimation{ targets: [arrowPart1, arrowPart2]; property: "rotation"; duration: 200 }
        NumberAnimation{ target: broomPart; property: "width"; duration: 300 }
        NumberAnimation{ target: bar; property: "rotation"; easing.type: Easing.OutQuart; duration: 400}
    }
    SequentialAnimation {
        id: broomToArrow

        NumberAnimation{ target: broomPart; property: "width"; duration: 200 }
        NumberAnimation{ targets: [arrowPart1, arrowPart2]; property: "rotation"; duration: 300 }
        NumberAnimation{ target: bar; property: "rotation"; easing.type: Easing.OutQuart; duration: 400}
        NumberAnimation { property: "anchors.horizontalCenterOffset"; duration: 0}
    }
}
