import QtQuick 2.2

Item {
    id: root
    width: 500
    height: 80
    property var model: []
    property string name: ""
    property int index: 0
    property color colorText: "#8989aa"
    property int current: model[index]

    Text{
        id: name_text
        color: "#8989aa"
        text: root.name
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -parent.width/4
        font.pixelSize: 50
        font.family: "PaintyPaint"
    }

    Text{
        id: value_text
        text: (index >= 0 && index < model.length) ? root.model[root.index] : ""
        color: root.colorText
        font.pixelSize: 60
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: parent.width/4
        font.family: "PaintyPaint"
        style: Text.Outline
        styleColor: "#8989aa"
    }

    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            root.colorText = "#bbbbdd"
        }
        onExited: {
            root.colorText = "#8989aa"
        }
        onClicked: root.index = (root.index + 1) % model.length
    }
}

