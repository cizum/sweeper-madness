import QtQuick 2.2

Item {
    id: root
    width: 350
    height: 80
    property var model: []
    property string name: ""
    property int index: 0
    property color colorText: "#8989aa"
    property int current: model[index]

    Row {
        height: root.height
        anchors.centerIn: parent
        spacing: 40

        Text {
            id: value_text
            width: 60
            text: (index >= 0 && index < model.length) ? root.model[root.index] : ""
            color: root.colorText
            font.pixelSize: 60
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "PaintyPaint"
            style: Text.Outline
            styleColor: "#8989aa"
        }

        Text {
            id: name_text
            width: 150
            color: "#8989aa"
            text: root.name
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 50
            font.family: "PaintyPaint"
        }

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

