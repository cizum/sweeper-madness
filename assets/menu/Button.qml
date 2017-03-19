import QtQuick 2.2

MouseArea {
    id: root
    width: 350
    height: 180
    property int textsize: 90
    property color textcolor: "#8989aa"
    property color textcolorHover: "#ccccdd"
    property color textcolorDown: "#eeeeff"
    property string text: ""
    hoverEnabled: true

    Text {
        id: label
        text: root.text
        font.pixelSize: root.textsize
        anchors.centerIn : parent
        color: root.textcolor
        font.bold: true
        font.family: "PaintyPaint"

        Behavior on color {
            ColorAnimation {
                duration: 100
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
                target: label
                color: root.textcolorDown
                style: Text.Outline
                styleColor: "#aaaadd"
            }
        },
        State {
            name: "hover"
            PropertyChanges {
                target: label
                color: root.textcolorHover
                style: Text.Outline
                styleColor: "#aaaadd"
            }
        }
    ]

    onPressed: root.state="down"
    onReleased: root.state="up"
    onCanceled: root.state="up"
    onEntered: root.state="hover"
    onExited: root.state="up"
}

