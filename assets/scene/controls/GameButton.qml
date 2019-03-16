import QtQuick 2.9
import QtGraphicalEffects 1.0

import krus.morten.style 1.0

MultiPointTouchArea {
    id: root

    width: 120
    height: 120

    property int textSize: 90
    property color textColor: Style.buttonTextColor
    property color textColorHover: Style.buttonTextHoverColor
    property color textColorDown: Style.buttonTextDownColor
    property string text: ""
    property string iconState: "IDLE"
    property real radius: width / 2 + 1
    property bool focused: false
    property bool selected: false

    Rectangle {
        id: background

        color: Style.buttonBackgroundColor
        border.color: root.selected ?  Style.buttonBorderSelectedColor : Style.buttonBorderColor
        border.width: root.selected ? 4 : 1
        anchors.fill: parent
        radius: root.radius
        visible: false
    }

    DropShadow {
        id: shadow

        anchors.fill: background
        horizontalOffset: 0
        verticalOffset: 8
        radius: 8.0
        samples: 17
        color: Style.buttonShadowColor
        source: background
    }

    Rectangle {
        id: focusedRec

        color: "transparent"
        border.color: Style.buttonFocusedBorderColor
        border.width: 5
        anchors.fill: parent
        radius: root.radius
        visible: root.focused
    }

    Text {
        id: label

        text: root.text
        font.pixelSize: root.textSize
        anchors.centerIn: parent
        color: root.textColor
        font.family: "I AM A PLAYER"

        Behavior on color { ColorAnimation { duration: 50 } }
    }

    ButtonIcon {
        id: icon

        anchors.centerIn: parent
        state: root.iconState
    }

    states: [
        State {
            name: "up"
        },
        State {
            name: "down"
            PropertyChanges {
                target: shadow
                verticalOffset: 1
                radius: 4.0
            }
            PropertyChanges {
                target: icon
                color: Style.buttonIconDownColor
            }
        },
        State {
            name: "disabled"
            when: !root.enabled
            PropertyChanges {
                target: shadow
                verticalOffset: 1
                radius: 0.0
                scale: 0
            }
            PropertyChanges {
                target: icon
                scale: 0
            }
            PropertyChanges {
                target: label
                scale: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation { properties: "verticalOffset, radius, scale"; duration: 50}
            ColorAnimation { duration: 50}
        }
    ]

    onPressed: if (root.enabled) root.state = "down"
    onReleased: if (root.enabled) root.state = "up"
    onCanceled: if (root.enabled) root.state = "up"
}

