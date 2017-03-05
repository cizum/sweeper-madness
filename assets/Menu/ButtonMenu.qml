import QtQuick 2.2
import QtGraphicalEffects 1.0

MouseArea {
    id: root
    width: 70
    height: 70
    property int textsize: 100
    property color textcolor:"#ccffffff"
    property color textcolorHover:"#ccffffff"
    property color textcolorDown:"#ccffffff"
    property string text: ""
    antialiasing: true
    smooth:true
    hoverEnabled: true
    clip: true
    Rectangle {
        id: background
        anchors.fill: parent
        color:"#20999999"
        border.color: "#eeeeee"
        border.width: 1
        visible: false
    }
    Rectangle {
        id: backgroundDown
        anchors.fill: parent
        color:"#30ee9999"
        border.color: "#ffffff"
        border.width: 1
        opacity:0
        visible: false
    }
    Text {
        id: label
        text:root.text
        font.pixelSize: textsize
        anchors.centerIn : parent
        color: textcolor
        font.bold:true
        font.family: "PaintyPaint"
        antialiasing: true
        smooth:true
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        Behavior on font.pixelSize {
            NumberAnimation {
                duration: 200
            }
        }
    }

    states: [
        State {
            name: "up"
            PropertyChanges {
                target: backgroundDown
                opacity:0
            }
        },
        State {
            name: "down"
            PropertyChanges {
                target: backgroundDown
                opacity:1
            }
            PropertyChanges {
                target: label
                color: textcolorDown
                font.pixelSize: textsize+8
            }
        },
        State {
            name: "hover"
            PropertyChanges {
                target: backgroundDown
                opacity:1
            }
            PropertyChanges {
                target: label
                color: textcolorHover
                font.pixelSize: textsize+8
            }
        }
    ]

    onPressed: state="down"
    onReleased: state="up"
    onCanceled: state="up"
    onEntered: state="hover"
    onExited: state="up"
}

