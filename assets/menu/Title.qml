import QtQuick 2.2

Item {
    id: root
    width: front_text.width
    height: front_text.height
    property string text: ""
    property string fontName: "PaintyPaint"
    property int fontSize: 150

    Text {
        id: back_text
        text: "Sweeper Madness"
        font.family: root.fontName
        font.pixelSize: root.fontSize
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -5
        anchors.horizontalCenterOffset: -5
        color: "#8989aa"
    }

    Text {
        id: front_text
        text: "Sweeper Madness"
        font.family: root.fontName
        font.pixelSize: root.fontSize
        anchors.centerIn: parent
        color: "#ffffff"
    }
}
