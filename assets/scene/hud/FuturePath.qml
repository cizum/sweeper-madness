import QtQuick 2.0

Item {
    id: root
    property int count: 20

    Repeater {
        model: root.count

        Rectangle {
            color: "#50aaaaaa"
            border.color: "#aa101010"
            width: 5
            height: 5
            radius: 5
            x: xC - width / 2
            y: yC - height / 2
            property double xC: 0
            property double yC: 0
        }
    }
}
