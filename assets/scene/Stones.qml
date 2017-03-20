import QtQuick 2.2

Item {
    id: root
    anchors.fill: parent
    property int count: 16
    property int current_n: 0
    property var current: root.children[current_n]
    property int style: 0
    signal mark(int x, int y, int a)
    property int mark_period: 500
    property int mark_time: 0
    property int starter: 0

    Repeater {
        model: root.count

        Stone {
            id: stone
            team: index % 2 == 0 ? root.starter : 1 - root.starter
            style: root.style
            onXCChanged: {
                var r = Math.random()
                var x = 0
                var y = 0
                if (root.style == 0) {
                    if (r < 0.2) {
                        x = xC + (1 - 10 * r)
                        y = yC + (1 - 10 * r)
                        mark(x, y, direction)
                    }
                }
                else {
                    root.mark_time = root.mark_time + 30
                    if (root.mark_time > root.mark_period) {
                        x = xC - 5
                        y = yC - 5
                        mark(x, y, direction)
                        root.mark_time = 0
                    }
                }
            }
        }
    }

    function initialize(sheet) {
        var t = [0,0]
        var w = root.children[0].width
        for (var s = 0; s < root.count; s++) {
            var team = root.children[s].team
            root.children[s].speed = 0
            root.children[s].angle = 0
            if (team === 0) {
                root.children[s].xC = sheet.x + 10 + t[0] * (w + 10)
                root.children[s].yC = sheet.y + sheet.height + 50
                t[0] = t[0] + 1
            }
            else {
                root.children[s].xC = sheet.x + 10 + t[1] * (w + 10)
                root.children[s].yC = sheet.y - 50
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
