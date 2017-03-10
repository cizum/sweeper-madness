import QtQuick 2.3
import QtGraphicalEffects 1.0
import "tools.js" as Tools
import "scene"

Item {
    id: root
    width: 1280
    height: 720
    property int phase: 0 // phases : 0-start 1-position 2-direction 3-power 4-sweeping 5-score 6-winner
    property int ends: 1
    property int current_end: 0
    property int stones_count: 2
    property int current_stone: 0
    property var colors: ["#ffff55", "#cc2020", "#55ff55", "#5555ff"]
    property int current_team: (root.current_stone + 1) % 2
    property int gameState: 0
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
        current_end: root.current_end
        ends: root.ends
        opacity: 0.8
    }

    SoundManager{
        id: soundManager
        gameState: root.gameState
        Connections{
            target: hud
            onScoreChanged: soundManager.applauseForPoint()
        }
    }

    Marks {
        id: marks
    }

    Stones {
        id: stones
        count: root.stones_count
        onMark: marks.add(x, y, a)
    }
    property alias stone: stones.current

    Launcher{
        id: launcher
        xC: root.xcl()
        yC: root.ycl()
        color: root.colors[root.current_team]
    }

    Sweeper {
        id: sweeper_1
        xC: root.xcsw1()
        yC: root.ycsw1()
        color: root.colors[root.current_team]
        transform: Rotation {
            origin.x: sweeper_1.width / 2
            origin.y: sweeper_1.height / 2
            angle: root.phase > 3 ? stone.direction : 0
        }
    }

    Sweeper {
        id: sweeper_2
        xC: root.xcsw2()
        yC: root.ycsw2()
        color: root.colors[root.current_team]
        transform: Rotation {
            origin.x: sweeper_2.width / 2
            origin.y: sweeper_2.height / 2
            angle: (root.phase > 3 ? stone.direction : 0) + 180
        }
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
            sweeper_1.move_smooth()
            sweeper_2.move_smooth()
            launcher.move_smooth()
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
            if (root.current_stone >= stones.count - 1) {
                if (root.current_end == root.ends - 1) {
                    root.phase = 6
                    hud.show_winner()
                }
                else {
                    root.new_end()
                }
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

    function new_end(){
        root.current_end = root.current_end + 1
        root.current_stone = 0
        root.ready = false
        root.phase = 0
    }

    function restart(){
        marks.clear()
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
            var d = dsquare_target(stones.children[i].xC, stones.children[i].yC)
            if (d < dmax * dmax){
                array[k] = [i, d]
                k ++
            }
        }
        array.sort(Tools.compare)
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

        if(hud.score[0] !== scores[0] || hud.score[1] !== scores[1])
            hud.score = scores
    }

    function collisions() {
        for (var i = 0; i < stones.count; i++) {
            for (var j = i + 1; j < stones.count; j++) {
                var d = Tools.dsquare(stones.children[i].xC, stones.children[i].yC, stones.children[j].xC, stones.children[j].yC)
                if (d < (2 * stone.radius) * (2 * stone.radius)){
                    soundManager.collide()
                    Tools.solve_collision(stones.children[j], stones.children[i])
                }
            }
        }
    }

    function dsquare_target(xc, yc) {
        var xt = piste.x + piste.x_target
        var yt = piste.y + piste.y_target
        return Tools.dsquare(xc, yc, xt, yt)
    }

    function xcl(){
        if (root.phase < 1)
            return piste.x
        else if (root.phase > 3)
            return piste.x + piste.start_line + 20
        else
            return stone.xC - 3 * stone.width / 4
    }

    function ycl(){
        if (root.phase < 1)
            return piste.y + piste.height / 2 - stone.height / 3
        else if (root.phase > 3)
            return piste.y + piste.height / 2 - stone.height / 3
        else
            return stone.yC - stone.height / 3
    }

    function xcsw1(){
        if (root.phase < 4) {
            return piste.x + 200
        }
        else if (root.phase == 4) {
            return stone.xC + Tools.x1_gap(stone.width + 4, stone.height + 5, stone.direction_rad)
        }
        else {
            return piste.x + 1100
        }
    }

    function ycsw1(){
        if (root.phase < 4) {
            return piste.y + piste.height - 20
        }
        else if (root.phase == 4) {
            return stone.yC + Tools.y1_gap(stone.width + 4, stone.height + 5, stone.direction_rad)
        }
        else {
            return piste.y + piste.height + 40
        }
    }

    function xcsw2(){
        if (root.phase < 4)
            return piste.x + 200
        else if (root.phase == 4)
            return stone.xC + Tools.x2_gap(stone.width + 15, stone.height + 5, stone.direction_rad)
        else
            return piste.x + 1100
    }

    function ycsw2(){
        if (root.phase < 4)
            return piste.y + 20
        else if (root.phase == 4)
            return stone.yC + Tools.y2_gap(stone.width + 15, stone.height + 5, stone.direction_rad)
        else
            return piste.y - 40
    }
}
