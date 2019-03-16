import QtQuick 2.9

import krus.morten.style 1.0

Rectangle{
    id: root

    property int sex: Style.sexFemale
    property bool laid: false

    width: 33
    height: 13
    radius: 8

    states: [
        State {
            name: "LAID"
            when: root.laid
            PropertyChanges {
                target: root
                width: 22
                height: 26
                anchors.verticalCenterOffset: 8
            }
        }
    ]

    Behavior on width {
        NumberAnimation {
            duration: 100
        }
    }

    Behavior on height {
        NumberAnimation {
            duration: 100
        }
    }
}

