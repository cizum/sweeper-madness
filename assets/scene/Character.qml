import QtQuick 2.2

Item {
    id: root
    width: 31
    height: 15
    antialiasing: true
    x: xC - width / 2
    y: yC - height /2
    property double xC: 0
    property double yC: 0
    property string color: "#800000"
    property string borderColor: "#101010"
    property int bodyRadius: 8

    Rectangle{
        id: body
        width: root.width
        height: root.height
        radius: root.bodyRadius
        color: root.color
        border.color: root.borderColor
    }

    Rectangle {
        id: head
        width: 17
        height: 17
        radius: width / 2 + 1
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -root.height / 4
        color: root.hair_color()
        border.color: root.borderColor
        antialiasing: true
        SequentialAnimation on anchors.verticalCenterOffset {
            id: head_anim
            NumberAnimation{
                duration: 100
                from: -root.height / 4 + 3
                to: -root.height / 4 - 3
            }
            NumberAnimation{
                duration: 100
                from: -root.height / 4 - 3
                to: -root.height / 4 + 3
            }
        }
    }

    onColorChanged: {
        head.color = root.hair_color()
    }

    function hair_color() {
        var r = Math.random()
        if (r < 0.3)
            return "#202020"
        else if (r < 0.5)
            return "#d0d020"
        else if (r < 0.7)
            return "#a68c24"
        else if (r < 0.85)
            return "#bd5f10"
        else
            return "#c0a080"
    }

    function shake_head() {
        head_anim.restart()
    }
}
