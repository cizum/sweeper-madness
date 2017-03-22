import QtQuick 2.2

MultiPointTouchArea {
    id: root
    width: 160
    height: 110
    property int textsize: 90
    property color textcolor: "#505050"
    property color textcolorHover: "#cccccc"
    property color textcolorDown: "#aaaaaa"
    property string text: ""

    Rectangle {
        id: background
        color: "transparent"
        border.width: 2
        border.color: root.textcolor
        anchors.fill: parent
        radius: 50
    }

    Text {
        id: label
        text: root.text
        font.pixelSize: root.textsize
        anchors.centerIn: parent
        color: root.textcolor
        style: Text.Outline
        styleColor: "#aaaadd"

        Behavior on color {
            ColorAnimation {
                duration: 50
            }
        }
    }

    states: [
        State {
            name: "up"
        },
        State {
            name: "down"
            PropertyChanges {
                target: background
                border.width: 8
                border.color: root.textcolorDown
            }
            PropertyChanges {
                target: label
                color: root.textcolorDown
                style: Text.Outline
                styleColor: "#aaaadd"
            }
        }
    ]

    onPressed: root.state = "down"
    onReleased: root.state = "up"
    onCanceled: root.state = "up"
}

