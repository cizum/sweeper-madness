import QtQuick 2.2

Item {
    id: root
    anchors.fill: parent
    property int count: 16
    property int current_n: 0
    property var current: root.children[current_n]

    Repeater {
        model: root.count

        Stone {
            team: index % 2 == 0 ? 1 : 0
        }
    }

    function initialize(piste) {
        var t = [0,0]
        var w = root.children[0].width
        for (var s = 0; s < root.count; s++) {
            var team = root.children[s].team
            root.children[s].speed = 0
            root.children[s].angle = 0
            if (team === 0) {
                root.children[s].xC = piste.x + 10 + t[0] * (w + 10)
                root.children[s].yC = piste.y + piste.height + 50
                t[0] = t[0] + 1
            }
            else {
                root.children[s].xC = piste.x + 10 + t[1] * (w + 10)
                root.children[s].yC = piste.y - 50
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
}
