import QtQuick 2.9
import QtGraphicalEffects 1.0
import "tools.js" as Tools
import "scene"
import "scene/skins"

import krus.morten.style 1.0

Item {
    id: root

    width: 720
    height: 1280
    visible: root.opacity > 0

    property int phase: 0 // phases : 0-start 1-position 2-direction 3-power 4-sweeping 5-score 6-winner
    property int players: 2
    property int ends: 1
    property int starter: 0
    property int currentEnd: 0
    property int stonesCount: 2
    property int currentStone: 0
    property var colors: ["#ffff55", "#cc2020", "#55ff55", "#5555ff"]
    property int currentTeam: 0
    property int gameState: 0
    property bool ready: false
    property bool finished: true

    signal menu()
    signal tutorial()

    property alias stone: stones.current
    property alias nextStone: stones.next

    Behavior on opacity {
        SequentialAnimation {
            PauseAnimation { duration: 100 }
            NumberAnimation { duration: 300 }
        }
    }

    Inputs {
        id: inputs

        position: sheet.x + sheet.width / 2
        positionMin: sheet.x + stone.width
        positionMax: sheet.x + sheet.width - stone.width
    }

    Madi {
        id: madi

        xHouse: sheet.x + sheet.xTarget
        yHouse: sheet.y + sheet.yTarget
        rHouse: sheet.rTarget
        playing: (root.players === 1 && root.currentTeam === 0)
        hasLastThrow: root.starter === 1
        onPressSpace: root.onSpacePressed()
        onPressUp: root.onUpPressed()
        onPressDown: root.onDownPressed()
        onReleaseUp: root.onUpReleased()
        onReleaseDown: root.onDownReleased()
    }

    Sheet {
        id: sheet

        anchors.centerIn: parent
    }

    Tutorial {
        id: tutorial

        anchors.fill: parent
        phase: root.phase
        madiPlaying: madi.playing
        visible: hud.help
    }

    Hud {
        id: hud

        phase: root.phase
        currentEnd: root.currentEnd
        ends: root.ends
        areas.xC: sheet.x + sheet.xTarget
        areas.yC: sheet.y + sheet.yTarget
        areas.r: sheet.rTarget + stone.radius
        opacity: 0.8
    }

    Controls {
        id: controls

        directionBarXOffset: launchers.children[root.currentTeam].xC + stone.radius
        directionBarYOffset: launchers.children[root.currentTeam].y - (sheet.y + sheet.height)
        direction: inputs.direction
        power: inputs.power
        playing: ! madi.playing
        onRestart: root.restart()
        onDebug: hud.debug = ! hud.debug
        onMenu: root.menu()
        onPressSpace: root.onSpacePressed()
        onPressUp: root.onUpPressed()
        onPressDown: root.onDownPressed()
        onReleaseUp: root.onUpReleased()
        onReleaseDown: root.onDownReleased()
        onHelp: hud.help = ! hud.help
        helpSelected: hud.help
        phase: root.phase
    }

    Stones {
        id: stones

        count: root.stonesCount
        starter: root.starter
    }

    Item {
        id: launchers

        anchors.fill: parent

        Repeater {
            model: 2

            Launcher{
                team: index
                xC: team == root.currentTeam ? xStart : xOff
                yC: team == root.currentTeam ? yStart : yOff
                xStart: sheet.x + sheet.width / 2 - stone.width / 3
                yStart: sheet.y + sheet.height
                xEnd: sheet.x + sheet.width / 2 - stone.width / 3
                yEnd: sheet.y + sheet.startLine - 20
                xStone: stone.xC - stone.width / 3
                yStone: stone.yC + 3 * stone.height / 4
                xOff: team === Style.teamHome ? sheet.x + sheet.width + 40 : sheet.x - 40
                yOff: 880
            }
        }
    }

    Item {
        id: providers

        anchors.fill: parent
        Repeater {
            model: 2

            Provider{
                team: index
                xC: xOff
                yC: yOff
                xOff: team === Style.teamHome ? sheet.x + sheet.width + 40 : sheet.x - 40
                yOff: 1230
            }
        }
    }

    Item {
        id: sweepers
        anchors.fill: parent
        Repeater {
            model: 4
            Sweeper {
                team: index < 2 ? 0 : 1
                side: index % 2
                xC: team == root.currentTeam ? xStart : xOff
                yC: team == root.currentTeam ? yStart : yOff
                xStart: side == 0 ? sheet.x + sheet.width - 20 : sheet.x + 20
                yStart: sheet.y + sheet.height - 200
                xEnd: side == 0 ? sheet.x + sheet.width + 40 : sheet.x - 40
                yEnd: sheet.y + 220
                xStone: side == 0 ? stone.xC + Tools.x1Gap(stone.width + 4, stone.height + 5, stone.directionRad) : stone.xC + Tools.x2Gap(stone.width + 15, stone.height + 5, stone.directionRad)
                yStone: side == 0 ? stone.yC + Tools.y1Gap(stone.width + 4, stone.height + 5, stone.directionRad) : stone.yC + Tools.y2Gap(stone.width + 15, stone.height + 5, stone.directionRad)
                xOff: side == 0 ? sheet.x + sheet.width + 40 : sheet.x - 40
                yOff: 830
            }
        }
    }

    function update() {
        launchers.children[0].update(root.phase, root.currentTeam)
        launchers.children[1].update(root.phase, root.currentTeam)
        providers.children[0].update(root.phase, root.currentTeam)
        providers.children[1].update(root.phase, root.currentTeam)
        for (var s = 0; s < 4; s++)
            sweepers.children[s].update(root.phase, root.currentTeam, stone)
        if (madi.playing)
            madi.think(root.phase, inputs.position, inputs.direction, inputs.power, stones, stone)
        switch(root.phase) {
        case 0:
            root.pStartUpdate()
            break
        case 1:
            root.pPositionUpdate()
            break
        case 2:
            root.pDirectionUpdate()
            break
        case 3:
            root.pPowerUpdate()
            break
        case 4:
            root.pSweepUpdate()
            break
        case 5:
            root.pScoreUpdate()
            break
        case 6:
            break
        }
    }

    onPhaseChanged: {
        switch(phase) {
        case 3:
            stone.direction = inputs.direction - 90
            break
        case 4:
            stone.direction = inputs.direction - 90
            stone.speed = inputs.speed
            stone.fCurlDir = inputs.direction > 0 ? -1 : 1
            if (nextStone) {
                nextStone.target(sheet.x + sheet.width / 2, sheet.y + sheet.height - 20)
            }
            providers.children[1 - root.currentTeam].shoot()
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
            inputs.positionDirection = -1
            break
        case 4:
            sweepers.children[root.currentTeam * 2 + 1].sweep()
            stone.direction = stone.direction + 0.12
            stone.speed = stone.speed + 0.005
            break
        }
    }

    function onDownPressed() {
        switch(root.phase) {
        case 1:
            inputs.positionDirection = 1
            break
        case 4:
            sweepers.children[root.currentTeam * 2].sweep()
            stone.direction = stone.direction - 0.12
            stone.speed = stone.speed + 0.005
            break
        }

    }
    function onUpReleased() {
        switch(root.phase) {
        case 1:
            inputs.positionDirection = 0
            break
        }

    }
    function onDownReleased() {
        switch(root.phase) {
        case 1:
            inputs.positionDirection = 0
            break
        }
    }

    function pStartUpdate() {
        if (!root.ready)
            root.initialize(root.currentStone)
        root.phase = 1
    }

    function pPositionUpdate() {
        inputs.updatePosition()
        stone.xC = inputs.position
    }

    function pDirectionUpdate() {
        stone.customMove(0.5 - Math.random() * 0.3, -90)
        inputs.updateDirection()
        if (stone.yC < sheet.y + sheet.startLine)
            root.phase = 4
    }

    function pPowerUpdate() {
        stone.customMove(0.5 - Math.random() * 0.3, stone.direction)
        inputs.updatePower()
        if (stone.yC < sheet.y + sheet.startLine)
            root.phase = 4
    }

    function pSweepUpdate() {
        stone.prevision()
        hud.updateFuturePath(stone)
        hud.updateGhost(stone.xCFuture, stone.yCFuture)
        stones.update()
        collisions()
        if (stone.yC < sheet.y + sheet.endSweepLine || ! stones.moving())
            root.phase = 5
    }

    function pScoreUpdate() {
        stone.prevision()
        hud.updateFuturePath(stone)
        hud.updateGhost(stone.xCFuture, stone.yCFuture)
        stones.update()
        collisions()
        if (! stones.moving() || stones.offside()) {
            root.score()
            if (root.currentStone >= stones.count - 1) {
                hud.totalScore = [hud.totalScore[0] + hud.score[0], hud.totalScore[1] + hud.score[1]]
                var v = hud.score[1] - hud.score[0]
                if (v > 0)
                    root.starter = 1
                else if (v < 0)
                    root.starter = 0
                else
                    root.currentEnd --
                hud.score = [0, 0]
                if (root.currentEnd == root.ends - 1) {
                    root.phase = 6
                    stones.currentN = 0
                    hud.showWinner()
                    root.finished = true
                }
                else {
                    root.newEnd()
                }
            }
            else{
                root.currentStone = (root.currentStone + 1) % stones.count
                root.currentTeam = (root.currentTeam + 1) % 2
                root.ready = false
                root.phase = 0
            }
        }
    }

    function initialize(n) {
        root.phase = 0
        inputs.initialize()
        stones.currentN = n
        if ( n === 0) {
            stones.initialize(sheet)
            root.currentTeam = root.starter
        }
        stone.initialize(sheet.x + sheet.width / 2, sheet.y + sheet.height - 20)
        nextStone = stones.currentN < (stones.count - 1) ? stones.children[stones.currentN + 1] : undefined
        root.initializeProvider(0)
        root.initializeProvider(1)
        madi.ready = false
        root.ready = true
    }

    function newEnd(){
        root.currentEnd = root.currentEnd + 1
        root.currentStone = 0
        root.currentTeam = root.starter
        root.ready = false
        for (var i = 0; i < stones.count; i++){
            stones.children[i].d2Target = -1
            stones.children[i].area = -1
        }
        root.phase = 0
    }

    function restart(){
        root.finished = false
        hud.help = false
        root.starter = Math.floor(Math.random() * 2)
        sheet.randomColors()
        hud.initialize()
        hud.score = [0, 0]
        hud.totalScore = [0, 0]
        root.currentEnd = 0
        root.currentStone = 0
        for (var i = 0; i < stones.count; i++){
            stones.children[i].d2Target = -1
            stones.children[i].area = -1
        }
        root.ready = false
        root.phase = 0
    }

    function score() {
        var scores = [0, 0]
        var dmax = sheet.rTarget + stone.radius
        var array = []
        var k = 0
        for (var i = 0; i < stones.count; i++){
            var d = root.dsquareTarget(stones.children[i].xC, stones.children[i].yC)
            if (d < dmax * dmax){
                stones.children[i].d2Target = d
                array[k] = [i, d]
                k ++
            }
            else {
                stones.children[i].d2Target = -1
            }
            stones.children[i].area = root.findArea(stones.children[i].xC, stones.children[i].yC)
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
                var diff = d - stone.width * stone.width
                if (diff < 0){
                    Tools.solveCollision(stones.children[j], stones.children[i])
                }
            }
        }
    }

    function dsquareTarget(xc, yc) {
        var xt = sheet.x + sheet.xTarget
        var yt = sheet.y + sheet.yTarget
        return Tools.dsquare(xc, yc, xt, yt)
    }

    function findArea(xc, yc) {
        var xt = sheet.x + sheet.xTarget
        var yt = sheet.y + sheet.yTarget
        var rt = sheet.rTarget + stone.radius
        var a = Tools.slope(xc, yc, xt, yt)
        var r2 = Tools.dsquare(xc, yc, xt, yt)
        if (r2 > rt * rt) {
            return -1
        }
        else if (r2 > rt * rt / 9) {
            return Math.floor(8 * (180 + a) / 360)
        }
        else {
            return 8
        }
    }

    function initializeProvider(team) {
        var startStoneIndex = root.currentStone + 1 + (root.currentTeam === team ? 1 : 0)
        startStoneIndex = startStoneIndex < stones.count ? startStoneIndex : -1
        var endStoneIndex = root.currentStone + 2 + (root.currentTeam === team ? 2 : 1)
        endStoneIndex = endStoneIndex < stones.count ? endStoneIndex : -1
        var xOff = providers.children[team].xOff
        var yOff = providers.children[team].yOff
        providers.children[team].xStart = startStoneIndex != -1 ? stones.children[startStoneIndex].xC + (team === Style.teamHome ? 28 : -28) : xOff
        providers.children[team].yStart = startStoneIndex != -1 ? stones.children[startStoneIndex].yC : yOff
        providers.children[team].xEnd = endStoneIndex != -1 ? stones.children[endStoneIndex].xC + (team === Style.teamHome ? 28 : -28) : xOff
        providers.children[team].yEnd = endStoneIndex != -1 ? stones.children[endStoneIndex].yC : yOff
        providers.children[team].xStone = root.currentStone < stones.count ?  stones.children[root.currentStone].xC : xOff
        providers.children[team].yStone = root.currentStone < stones.count ?  stones.children[root.currentStone].yC : yOff
    }
}
