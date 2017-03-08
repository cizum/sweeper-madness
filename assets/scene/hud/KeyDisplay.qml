import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 70
    height: 70
    property int textsize: 60
    property string text: ""
    property bool highlight: false

    Text {
        id: label
        text:root.text
        font.pixelSize: textsize
        anchors.centerIn : parent
        color: "#40202020"
        font.bold:true
    }

    Glow {
        id:glow
        anchors.fill: label
        radius: 20
        samples: 20
        color: "white"
        source: label
        visible: root.highlight
    }
}

