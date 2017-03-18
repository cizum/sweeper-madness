import QtQuick 2.3
import QtGraphicalEffects 1.0
import "tools.js" as Tools
import "scene"

Item {
    id: root
    width: 1280
    height: 720
    property int phase: 0 // phases : 0-start 1-position 2-direction 3-power 4-sweeping 5-score 6-winner
    property int players: 2
    property int ends: 1
    property int current_end: 0
    property int stones_count: 2
    property int current_stone: 0
    property var colors: ["#ffff55", "#cc2020", "#55ff55", "#5555ff"]
    property int current_team: (root.current_stone + 1) % 2
    property int gameState: 0
    property bool ready: false
    property int style: 0
    signal menu()

    Inputs {
        id: inputs
        position: sheet.y + sheet.height / 2
        position_min: sheet.y + stone.height
        position_max: sheet.y + sheet.height - stone.height
    }

    Madi {
        id: madi
        playing: (root.players == 1 && root.current_team == 0)
        onPressSpace: root.onSpacePressed()
        onPressUp: root.onUpPressed()
        onPressDown: root.onDownPressed()
        onReleaseUp: root.onUpReleased()
        onReleaseDown: root.onDownReleased()
    }

    Background {
        id: background
        anchors.fill: parent
        style: root.style
    }

    Sheet {
        id: sheet
        anchors.centerIn: parent
        style: root.style
    }

    Hud {
        id: hud
        power: inputs.power
        direction: inputs.direction
        phase: root.phase
        current_end: root.current_end
        ends: root.ends
        opacity: 0.8
        style: root.style
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
        style: root.style
    }

    Stones {
        id: stones
        count: root.stones_count
        onMark: marks.add(x, y, a)
        style: root.style
    }
    property alias stone: stones.current

    Item {
        id: launchers
        anchors.fill: parent
        Repeater {
            model: 2
            Launcher{
                id: launcher
                style: root.style
                team: index
                xC: root.width / 2
                yC: 0
                xStart: sheet.x
                yStart: sheet.y + sheet.height / 2 - stone.height / 3
                xEnd: sheet.x + sheet.start_line + 20
                yEnd: sheet.y + sheet.height / 2 - stone.height / 3
                xStone: stone.xC - 3 * stone.width / 4
                yStone: stone.yC - stone.height / 3
                xOff: 500
                yOff: 200
            }
        }
    }

    Sweeper {
        id: sweeper_1
        xC: root.xcsw1()
        yC: root.ycsw1()
        style: root.style
        team: root.current_team
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
        style: root.style
        team: root.current_team
        transform: Rotation {
            origin.x: sweeper_2.width / 2
            origin.y: sweeper_2.height / 2
            angle: (root.phase > 3 ? stone.direction : 0) + 180
        }
    }

    Controls {
        id: controls
        playing: ! madi.playing
        onRestart: root.restart()
        onMute: soundManager.mute = ! soundManager.mute
        onDebug: hud.debug = ! hud.debug
        onMenu: if (root.phase == 6) root.menu()
        onPressSpace: root.onSpacePressed()
        onPressUp: root.onUpPressed()
        onPressDown: root.onDownPressed()
        onReleaseUp: root.onUpReleased()
        onReleaseDown: root.onDownReleased()
        onChangeStyle: root.style = (root.style + 1) % 2
    }

    function update() {

        launchers.children[0].update(root.phase, root.current_team)
        launchers.children[1].update(root.phase, root.current_team)
        if (madi.playing)
            madi.think(root.phase, inputs.position, inputs.direction, inputs.power, stone, sheet)
        switch(root.phase) {
        case 0:
            root.p_start_update()
            break
        case 1:
            root.p_position_update()
            break
        case 2:
            root.p_direction_update()
            break
        case 3:
            root.p_power_update()
            break
        case 4:
            root.p_sweep_update()
            break
        case 5:
            root.p_score_update()
            break
        case 6:
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

    function onSpacePressed() {
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

    function onUpPressed() {
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

    function onDownPressed() {
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
    function onUpReleased() {
        switch(root.phase) {
        case 1:
            inputs.position_sense = 0
            break
        }

    }
    function onDownReleased() {
        switch(root.phase) {
        case 1:
            inputs.position_sense = 0
            break
        }
    }

    function p_start_update() {
        if (!root.ready)
            root.initialize(root.current_stone)
        root.phase = 1
    }

    function p_position_update() {
        inputs.update_position()
        stone.yC = inputs.position
    }

    function p_direction_update() {
        stone.custom_move(0.5 - Math.random() * 0.3, 0)
        inputs.update_direction()
        if (stone.xC > sheet.x + sheet.start_line)
            root.phase = 4
    }

    function p_power_update() {
        stone.custom_move(0.5 - Math.random() * 0.3, stone.direction)
        inputs.update_power()
        if (stone.xC > sheet.x + sheet.start_line)
            root.phase = 4
    }

    function p_sweep_update() {
        stone.prevision()
        hud.update_ghost(stone.xC_future, stone.yC_future)
        stones.update()
        collisions()
        if (stone.xC > sheet.x + sheet.end_sweep_line || ! stones.moving())
            root.phase = 5
    }

    function p_score_update() {
        stone.prevision()
        hud.update_ghost(stone.xC_future, stone.yC_future)
        stones.update()
        collisions()
        if (! stones.moving()) {
            root.score()
            if (root.current_stone >= stones.count - 1) {
                hud.total_score = [hud.total_score[0] + hud.score[0], hud.total_score[1] + hud.score[1]]
                hud.score = [0, 0]
                if (root.current_end == root.ends - 1) {
                    root.phase = 6
                    stones.current_n = 0
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

    function initialize(n) {
        root.phase = 0
        inputs.initialize()
        stones.current_n = n
        if ( n === 0)
            stones.initialize(sheet)
        stone.xC = sheet.x + 20
        stone.yC = sheet.y + sheet.height / 2
        madi.ready = false
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
        root.current_end = 0
        root.current_stone = 0
        root.ready = false
        root.phase = 0
    }

    function score() {
        var scores = [0, 0]
        var dmax = sheet.r_target + stone.radius
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
                    if (stones.children[i].speed > 0 || stones.children[j].speed > 0)
                        soundManager.collide()
                    Tools.solve_collision(stones.children[j], stones.children[i])
                }
            }
        }
    }

    function dsquare_target(xc, yc) {
        var xt = sheet.x + sheet.x_target
        var yt = sheet.y + sheet.y_target
        return Tools.dsquare(xc, yc, xt, yt)
    }

    function xcsw1(){
        if (root.phase < 4) {
            return sheet.x + 200
        }
        else if (root.phase == 4) {
            return stone.xC + Tools.x1_gap(stone.width + 4, stone.height + 5, stone.direction_rad)
        }
        else {
            return sheet.x + 1100
        }
    }

    function ycsw1(){
        if (root.phase < 4) {
            return sheet.y + sheet.height - 20
        }
        else if (root.phase == 4) {
            return stone.yC + Tools.y1_gap(stone.width + 4, stone.height + 5, stone.direction_rad)
        }
        else {
            return sheet.y + sheet.height + 40
        }
    }

    function xcsw2(){
        if (root.phase < 4)
            return sheet.x + 200
        else if (root.phase == 4)
            return stone.xC + Tools.x2_gap(stone.width + 15, stone.height + 5, stone.direction_rad)
        else
            return sheet.x + 1100
    }

    function ycsw2(){
        if (root.phase < 4)
            return sheet.y + 20
        else if (root.phase == 4)
            return stone.yC + Tools.y2_gap(stone.width + 15, stone.height + 5, stone.direction_rad)
        else
            return sheet.y - 40
    }
}
