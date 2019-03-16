import QtQuick 2.9

import krus.morten.style 1.0

Item {
    id: root

    anchors.fill: parent

    property int count: 16
    property int currentN: 0
    property var current: root.children[currentN]
    property var next: currentN < (count - 1) ? root.children[currentN + 1] : undefined
    property int starter: 0

    Repeater {
        model: root.count

        Stone {
            id: stone
            team: index % 2 == 0 ? root.starter : 1 - root.starter
        }
    }

    function initialize(sheet) {
        var t = [0,0]
        var w = root.children[0].width
        for (var s = 0; s < root.count; s++) {
            var team = root.children[s].team
            root.children[s].speed = 0
            root.children[s].angle = 0
            if (team === Style.teamHome) {
                root.children[s].xC = sheet.x + sheet.width + 30
                root.children[s].yC = sheet.y + sheet.height - 20 - t[0] * (w + 10)
                t[0] = t[0] + 1
            }
            else {
                root.children[s].xC = sheet.x - 30
                root.children[s].yC = sheet.y + sheet.height - 20 - t[1] * (w + 10)
                t[1] = t[1] + 1
            }
        }
    }

    function update() {
        for (var s = 0; s < root.count; s++) {
            root.children[s].update()
        }
    }

    function moving() {
        for (var s = 0; s < root.count; s++) {
            if (root.children[s].speed > 0)
                return true
        }
        return false
    }

    function offside() {
        for (var s = 0; s < root.count; s++) {
            if (root.children[s].speed > 0 && root.children[s].yC >= -30)
                return false
        }
        return true
    }
}
