import QtQuick 2.3
import QtGraphicalEffects 1.0
import "scene"

Item {
    id: root
    width: 1280
    height: 720
    property int phase: 0 // phases : 0-start 1-position 2-direction 3-power 4-sweeping 5-score 6-winner
    property int current_stone: 0
    property bool ready: false

    Inputs {
        id: inputs
        position: piste.y + piste.height / 2
        position_min: piste.y + stone.height
        position_max: piste.y + piste.height - stone.height
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#ddddee"
    }

    Piste {
        id: piste
        anchors.centerIn: parent
    }

    Hud {
        id: hud
        power: inputs.power
        direction: inputs.direction
        phase: root.phase
        opacity: 0.8
    }

    Item{
        id: traces
        anchors.fill: parent
        function clear(){
            var nt = traces.children.length
            for (var t = nt - 1; t >= 0; t--){
                traces.children[t].destroy()
            }
        }
    }

    Stones {
        id: stones
    }
    property alias stone: stones.current

    Launcher{
        id: launcher
        xC: root.phase > 3 ? piste.x + piste.start_line + 20 : stone.xC - 3 * stone.width / 4
        yC: root.phase > 3 ? piste.y + piste.height / 2 - stone.height / 3 : stone.yC - stone.height / 3
        color: stone.main_color
    }

    Sweeper {
        id: sweeper_1
        xC: root.phase > 3 ? (root.phase == 4 ? stone.xC + x1_gap(stone.width + 4, stone.height + 5, stone.direction_rad) : piste.x + 1100) : piste.x + 200
        yC: root.phase > 3 ? (root.phase == 4 ? stone.yC + y1_gap(stone.width + 4, stone.height + 5, stone.direction_rad) : piste.y + piste.height + 40) : piste.y + piste.height - 20
        transform: Rotation {
            origin.x: sweeper_1.width / 2
            origin.y: sweeper_1.height / 2
            angle: root.phase > 3 ? stone.direction : 0
        }
        color: stone.main_color
    }
    function x1_gap(ax, ay, angle) {
        return ax * Math.cos(angle) - ay * Math.sin(angle)
    }
    function y1_gap(ax, ay, angle) {
        return ax * Math.sin(angle) + ay * Math.cos(angle)
    }

    Sweeper {
        id: sweeper_2
        xC: root.phase > 3 ? (root.phase == 4 ? stone.xC + x2_gap(stone.width + 15, stone.height + 5, stone.direction_rad) : piste.x + 1100) : piste.x + 200
        yC: root.phase > 3 ? (root.phase == 4 ? stone.yC + y2_gap(stone.width + 15, stone.height + 5, stone.direction_rad) : piste.y - 40 ) : piste.y + 20
        transform: Rotation {
            origin.x: sweeper_2.width / 2
            origin.y: sweeper_2.height / 2
            angle: (root.phase > 3 ? stone.direction : 0) + 180
        }
        color: stone.main_color
    }
    function x2_gap(ax, ay, angle) {
        return ax * Math.cos(angle) + ay * Math.sin(angle)
    }
    function y2_gap(ax, ay, angle) {
        return ax * Math.sin(angle) - ay * Math.cos(angle)
    }

    Controls {
        id: controls
        onRestart: {
            root.restart()
        }
        onPressSpace: {
            switch(root.phase) {
            case 1:
                root.phase = 2
                break
            case 2:
                root.phase = 3
                break
            case 3:
                root.phase = 4
                break
            }
        }
        onPressUp: {
            switch(root.phase) {
            case 1:
                inputs.position_sense = -1
                break
            case 4:
                sweeper_2.sweep()
                stone.direction = stone.direction + 0.12
                stone.speed = stone.speed + 0.005
                break
            }
        }
        onPressDown: {
            switch(root.phase) {
            case 1:
                inputs.position_sense = 1
                break
            case 4:
                sweeper_1.sweep()
                stone.direction = stone.direction - 0.12
                stone.speed = stone.speed + 0.005
                break
            }
        }
        onReleaseUp: {
            switch(root.phase) {
            case 1:
                inputs.position_sense = 0
                break
            }
        }
        onReleaseDown: {
            switch(root.phase) {
            case 1:
                inputs.position_sense = 0
                break
            }
        }
    }

    function update() {
        switch(phase) {
        case 0:
            root.phase0_update()
            break
        case 1:
            root.phase1_update()
            break
        case 2:
            root.phase2_update()
            break
        case 3:
            root.phase3_update()
            break
        case 4:
            root.phase4_update()
            break
        case 5:
            root.phase5_update()
            break
        case 6:
            root.phase6_update()
            break
        }
    }

    onPhaseChanged: {
        switch(phase) {
        case 3:
            stone.direction = inputs.direction
            break
        case 4:
            launcher.move_smooth()
            sweeper_1.move_smooth()
            sweeper_2.move_smooth()
            stone.speed = inputs.speed
            stone.f_curl_dir = inputs.direction > 0 ? -1 : 1
            stone.f_curl = 0.05
            break
        case 5:
            sweeper_1.move_smooth()
            sweeper_2.move_smooth()
            break
        }
    }

    function phase0_update() {
        if (!root.ready)
            root.initialize(root.current_stone)
        root.phase = 1
    }

    function phase1_update() {
        inputs.update_position()
        stone.yC = inputs.position
    }

    function phase2_update() {
        stone.custom_move(0.5 - Math.random() * 0.3, 0)
        inputs.update_direction()
        if (stone.xC > piste.x + piste.start_line)
            root.phase = 4
    }

    function phase3_update() {
        stone.custom_move(0.5 - Math.random() * 0.3, stone.direction)
        inputs.update_power()
        if (stone.xC > piste.x + piste.start_line)
            root.phase = 4
    }

    function phase4_update() {
        stones.update()
        collisions()
        if (stone.xC > piste.x + piste.end_sweep_line || ! stones.moving())
            root.phase = 5
    }

    function phase5_update() {
        stones.update()
        collisions()
        if (! stones.moving()) {
            root.score()
            if (root.current_stone >= stones.count - 1){
                root.phase = 6
                hud.show_winner()
            }
            else{
                root.current_stone = (root.current_stone + 1) % stones.count
                root.ready = false
                root.phase = 0
            }
        }
    }

    function phase6_update() {
    }

    function initialize(n) {
        root.phase = 0
        inputs.initialize()
        stones.current_n = n
        if ( n === 0)
            stones.initialize(piste)
        stone.xC = piste.x + 20
        stone.yC = piste.y + piste.height / 2
        root.ready = true
    }

    function restart(){
        traces.clear()
        hud.initialize()
        root.current_stone = 0
        root.ready = false
        root.phase = 0
    }

    function score() {
        var scores = [0, 0]
        var dmax = piste.r_target + stone.radius
        var array = []
        var k = 0
        for (var i = 0; i < stones.count; i++){
            var d = d2_target(stones.children[i].xC, stones.children[i].yC)
            if (d < dmax * dmax){
                array[k] = [i, d]
                k ++
            }
        }
        array.sort(compare)
        if (array.length > 0){
            var t = stones.children[array[0][0]].team
            scores[t] = 1
            for (i = 1; i < array.length; i++){
                if (stones.children[array[i][0]].team === t)
                    scores[t] ++
                else
                    break
            }
        }
        hud.score[0] = scores[0]
        hud.score[1] = scores[1]
    }

    function compare(a, b) {
        if (a[1] === b[1]) {
            return 0
        }
        else {
            return (a[1] < b[1]) ? -1 : 1
        }
    }

    function collisions() {
        for (var i = 0; i < 16; i++) {
            for (var j = i + 1; j < 16; j++) {
                var d = d2(stones.children[i].xC, stones.children[i].yC, stones.children[j].xC, stones.children[j].yC)
                if (d < (2 * stone.radius) * (2 * stone.radius)){
                    var a = root.slope(stones.children[i].xC, stones.children[i].yC, stones.children[j].xC, stones.children[j].yC)
                    var a1 = stones.children[i].direction
                    var a2 = stones.children[j].direction
                    var s1 = stones.children[i].speed
                    var s2 = stones.children[j].speed
                    var th1rad = (a1 - a - 90) * Math.PI / 180
                    var th2rad = (a2 - a - 90) * Math.PI / 180
                    var cs11 = s1 * Math.cos(th1rad)
                    var cs12 = s2 * Math.sin(th2rad)
                    var cs21 = s1 * Math.sin(th1rad)
                    var cs22 = s2 * Math.cos(th2rad)
                    stones.children[i].speed = Math.sqrt(cs11 * cs11 + cs12 * cs12)
                    stones.children[j].speed = Math.sqrt(cs21 * cs21 + cs22 * cs22)
                    stones.children[i].direction = Math.atan2(cs12, cs11) * 180 / Math.PI + (a + 90)
                    stones.children[j].direction = Math.atan2(cs21, cs22) * 180 / Math.PI + (a + 90)
                }
            }
        }
    }

    function d2(x0, y0, x1, y1) {
        return (x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0)
    }

    function d2_target(xc, yc) {
        var xt = piste.x + piste.x_target
        var yt = piste.y + piste.y_target
        return d2(xc, yc, xt, yt)
    }

    function slope(x0, y0, x1, y1) {
        var a = Math.atan2(y1 - y0, x1 - x0)
        return a / Math.PI * 180
    }
}
