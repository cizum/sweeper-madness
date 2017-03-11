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

    onPressDown: root.down = true
    onReleaseDown: root.down = false
    onPressUp: root.up = true
    onReleaseUp: root.up = false

    function think(phase, position, direction, power, stone, piste) {
        switch(phase) {
        case 1:
            if (!root.ready) {
                choose(position, direction, power)
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
            if (near(direction, root.direction_target, 3)) {
                root.pressSpace()
            }
            break
        case 3:
            if (near(power, root.power_target, 5)) {
                root.pressSpace()
            }
            break
        case 4:
            analyze(stone, piste)
            break
        }
    }

    function choose(position, direction, power) {
        root.position_target = position + 100 - Math.random() * 200
        root.direction_target = 15 - Math.random() * 30
        root.power_target = 100 - Math.random() * 35
        root.ready = true
    }

    function near(value, target, offset) {
        if (value > target - offset && value < target + offset){
            if (Math.random() < 0.15)
                return true
        }
        return false
    }

    function analyze(stone, piste) {
        if (stone.speed > 0 && stone.direction > -60 && stone.direction < 60) {
            var x = stone.xC_future
            var y = stone.yC_future
            var d = Tools.dsquare(piste.x, piste.y, x, y)
            if (x < piste.x + piste.x_target) {
                if (y < piste.y + piste.y_target - 20) {
                    sweep_up()
                }
                else if (y > piste.y + piste.y_target + 20) {
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
