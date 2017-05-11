/* Mad intelligence */
import QtQuick 2.0
import "../tools.js" as Tools

Item {
    id: root
    property bool playing: false
    property bool ready: false
    property int position_target: 0
    property int direction_target: 0
    property int power_target: 0
    signal pressDown()
    signal pressUp()
    signal pressSpace()
    signal releaseDown()
    signal releaseUp()
    property bool down: false
    property bool up: false
    property bool down_pressable: true
    property bool up_pressable: true
    property var d_stones_target: []
    property int strategy: 0 // 0 score 1 shoot
    property double x_final: 0
    property double y_final: 0

    onPressDown: root.down = true
    onReleaseDown: root.down = false
    onPressUp: root.up = true
    onReleaseUp: root.up = false

    function think(phase, position, direction, power, stones, stone, sheet) {
        switch(phase) {
        case 1:
            if (!root.ready) {
                choose(position, direction, power, stones, sheet)
            }
            else {
                if (Math.abs(position - root.position_target) < 1) {
                    if (root.down)
                        root.releaseDown()
                    if (root.up)
                        root.releaseUp()
                    root.pressSpace()
                }
                else if (position < root.position_target){
                    if (root.up)
                        root.releaseUp()
                    if (!root.down)
                        root.pressDown()
                }
                else {
                    if (root.down)
                        root.releaseDown()
                    if (!root.up)
                        root.pressUp()
                }
            }
            break
        case 2:
            if (near(direction, root.direction_target, 4)) {
                root.pressSpace()
            }
            break
        case 3:
            if (near(power, root.power_target, 6)) {
                root.pressSpace()
            }
            break
        case 4:
            analyze(stone, sheet)
            break
        }
    }

    function choose(position, direction, power, stones, sheet) {
        var shoot_target = -1
        for (var s = 0; s < stones.count; s++) {
            if (stones.children[s].team === 1) {
                var dmax = sheet.r_target / 1.5
                if (root.d_stones_target[s] < dmax * dmax) {
                    if (shoot_target < 0 || root.d_stones_target[s] < root.d_stones_target[shoot_target])
                        shoot_target = s
                }
            }
        }
        if (shoot_target >= 0) {
            root.strategy = 1
            root.x_final = stones.children[shoot_target].xC
            root.y_final = stones.children[shoot_target].yC
        }
        else {
            root.strategy = 0
            root.x_final = sheet.x + sheet.x_target
            root.y_final = sheet.y + sheet.y_target
        }

        root.position_target = position + 70 - Math.random() * 140
        var a = Tools.slope(sheet.x, root.position_target, root.x_final, root.y_final)
        if (a > 0)
            root.direction_target = - a - 7 * Math.random()
        else
            root.direction_target = - a + 7 * Math.random()

        root.power_target = root.strategy == 0 ? 95 - Math.random() * 25 : 100 - 4 * Math.random()
        root.ready = true
    }

    function near(value, target, offset) {
        if (value > target - offset && value < target + offset){
            if (Math.random() < 0.15)
                return true
        }
        return false
    }

    function analyze(stone, sheet) {
        if (stone.speed > 0 && stone.direction > -60 && stone.direction < 60) {
            var xf = stone.xC_future
            var yf = stone.yC_future

            if (xf <  root.x_final || strategy == 1) {
                if (yf <  root.y_final - 20) {
                    sweep_up()
                }
                else if (yf > root.y_final + 20) {
                    sweep_down()
                }
                else {
                    sweep_up()
                    sweep_down()
                }
            }
        }
    }

    function sweep_up() {
        if (root.up_pressable) {
            root.pressUp()
            root.releaseUp()
            up_cooldown.restart()
        }
    }
    function sweep_down() {
        if (root.down_pressable) {
            root.pressDown()
            root.releaseDown()
            down_cooldown.restart()
        }
    }

    Timer{
        id: up_cooldown
        interval: 100
        triggeredOnStart: true
        onTriggered: root.up_pressable = ! root.up_pressable
    }
    Timer{
        id: down_cooldown
        interval: 100
        triggeredOnStart: true
        onTriggered: root.down_pressable = ! root.down_pressable
    }
}
