import QtQuick 2.9
import "../scene/controls"

import krus.morten.style 1.0

Item {
    id: root

    width: 570
    height: 80

    property var model: []
    property string name: ""
    property int index: 0
    property color colorText: Style.choiceListColor
    property int current: model[index]
    property bool focused: false

    GameButton{
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: 80
        height: 80
        textSize: 40
        text: "+"
        enabled: root.index < (root.model.length - 1)
        focused: root.focused
        onPressed: root.index = Math.min(root.index + 1, root.model.length - 1)
    }

    GameButton{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 80
        height: 80
        textSize: 40
        text: "-"
        enabled: root.index > 0
        focused: root.focused
        onPressed: root.index = Math.max(root.index - 1, 0)
    }

    Row {
        id: row
        height: root.height
        anchors.centerIn: parent
        spacing: 30

        Text {
            id: valueText

            width: 60
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 50
            horizontalAlignment: Text.AlignHCenter
            font.family: "I AM A PLAYER"
            color: root.colorText
            text: (root.index >= 0 && root.index < root.model.length) ? root.model[root.index] : ""
        }

        Text {
            id: nameText

            width: 130
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            font.family: "I AM A PLAYER"
            color: Style.choiceListColor
            text: root.name
        }
    }
}

