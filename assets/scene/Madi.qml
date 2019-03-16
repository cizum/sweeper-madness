/* Mad intelligence */
import QtQuick 2.9
import "../tools.js" as Tools

import krus.morten.style 1.0

Item {
    id: root

    property bool playing: false
    property bool ready: false
    property int positionTarget: 0
    property int directionTarget: 0
    property int powerTarget: 0
    property bool down: false
    property bool up: false
    property bool downPressable: true
    property bool upPressable: true
    property double xWanted: 0
    property double yWanted: 0
    property double xHouse: 0
    property double yHouse: 0
    property double rHouse: 0
    property bool hasLastThrow: false
    property int ownStonesInHouse: 0
    property int rivalStonesInHouse: 0
    property int strategy: 0 // 0 point 1 freeze 2 centered shoot 3 left shoot 4 right shoot

    signal pressDown()
    signal pressUp()
    signal pressSpace()
    signal releaseDown()
    signal releaseUp()

    onPressDown: root.down = true
    onReleaseDown: root.down = false
    onPressUp: root.up = true
    onReleaseUp: root.up = false

    function think(phase, position, direction, power, stones, stone) {
        switch(phase) {
        case 1:
            if (!root.ready) {
                root.analyzeSitutation(stones)
                root.defineStrategy(stones)
                root.choose(position, stone)
            }
            else {
                if (Math.abs(position - root.positionTarget) < 1) {
                    if (root.down)
                        root.releaseDown()
                    if (root.up)
                        root.releaseUp()
                    root.pressSpace()
                }
                else if (position < root.positionTarget){
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
            if (near(direction, root.directionTarget, 4)) {
                root.pressSpace()
            }
            break
        case 3:
            if (near(power, root.powerTarget, 6)) {
                root.pressSpace()
            }
            break
        case 4:
            adapt(stone)
            break
        }
    }

    function choose(position, stone) {
        var s = 0
        var d = 0
        switch(root.strategy) {
        case 0:
            root.directionTarget = root.smartRandomDirection(root.xWanted - position)
            root.powerTarget = root.randomPower(false)
            s = Tools.powerToSpeed(root.powerTarget)
            d = (root.directionTarget - 90) * Math.PI / 180
            root.positionTarget = 300 + Math.random() * 100
            break
        case 1:
            root.directionTarget = root.smartRandomDirection(root.xWanted - position)
            root.powerTarget = root.randomPower(false)
            root.positionTarget = position + Math.random() * 60 - 30
            s = Tools.powerToSpeed(root.powerTarget)
            d = (root.directionTarget - 90)  * Math.PI / 180
            root.positionTarget = 300 + Math.random() * 100
            break
        case 2:
            root.directionTarget = root.smartRandomDirection(root.xWanted - position)
            root.powerTarget = root.randomPower(true)
            root.positionTarget = position + Math.random() * 60 - 30
            s = Tools.powerToSpeed(root.powerTarget)
            d = (root.directionTarget - 90)  * Math.PI / 180
            root.positionTarget = 300 + Math.random() * 100
            break
        case 3:
            root.directionTarget = root.smartRandomDirection(root.xWanted - position)
            root.powerTarget = root.randomPower(true)
            root.positionTarget = position + Math.random() * 60 - 30
            s = Tools.powerToSpeed(root.powerTarget)
            d = (root.directionTarget - 90)  * Math.PI / 180
            root.positionTarget = 300 + Math.random() * 100
            break
        case 4:
            root.directionTarget = root.smartRandomDirection(root.xWanted - position)
            root.powerTarget = root.randomPower(true)
            root.positionTarget = position + Math.random() * 60 - 30
            s = Tools.powerToSpeed(root.powerTarget)
            d = (root.directionTarget - 90)  * Math.PI / 180
            root.positionTarget = 300 + Math.random() * 100
            break
        }
        root.ready = true
    }

    function near(value, target, offset) {
        if (value > target - offset && value < target + offset){
            if (Math.random() < 0.15)
                return true
        }
        return false
    }

    function adapt(stone) {
        switch(root.strategy) {
        case 0:
            root.adaptPoint(stone, root.xWanted, root.yWanted)
            break
        case 1:
            root.adaptPoint(stone, root.xWanted, root.yWanted + 2 * stone.radius)
            break
        case 2:
            root.adaptShoot(stone, root.xWanted, root.yWanted)
            break
        case 3:
            root.adaptShoot(stone, root.xWanted - stone.radius, root.yWanted)
            break
        case 4:
            root.adaptShoot(stone, root.xWanted + stone.radius, root.yWanted)
            break
        }
    }

    function adaptPoint(stone, x, y) {
        if (stone.speed > 0 && stone.direction > -150 && stone.direction < -30) {
            var xf = stone.xCFuture
            var yf = stone.yCFuture
            if (yf >  y) {
                if (xf <  x - 20) {
                    sweepUp()
                }
                else if (xf > x + 20) {
                    sweepDown()
                }
                else {
                    sweepUp()
                    sweepDown()
                }
            }
        }
    }

    function adaptShoot(stone, x, y) {
        var far = true
        if (stone.speed > 0 && stone.direction > -150 && stone.direction < -30) {
            var endTime = stone.endTime()
            for (var i = 0; i < 20; i++) {
                var futurePos = stone.futurePosition(i * endTime / 20)
                if (futurePos[1] > y - 20 && futurePos[1] < y + 20) {
                    far = false
                    if (futurePos[0] < x) {
                        sweepUp()
                        break
                    }
                    else if (futurePos[0] > x) {
                        sweepDown()
                        break
                    }
                }
            }
            if (far) {
                sweepUp()
                sweepDown()
            }
        }
    }

    function analyzeSitutation(stones) {
        root.ownStonesInHouse = 0
        root.rivalStonesInHouse = 0
        for (var s = 0; s < stones.count; s++) {
            var stone = stones.children[s]
            if (stone.area !== -1) {
                if (stone.team === Style.teamHome) {
                    root.ownStonesInHouse ++
                }
                else {
                    root.rivalStonesInHouse ++
                }
            }
        }
    }

    function defineStrategy(stones) {
        var s = 0
        var badStone = -1
        var best = -1
        var stone
        if (root.hasLastThrow) {
            if (root.rivalStonesInHouse > 0) {
                badStone = -1
                best = -1
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === Style.teamVisitor) {
                        if (stone.area === 1 || stone.area === 2) {
                            best = 3
                            badStone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 8 && best < 3) {
                            best = 2
                            badStone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 0 && best < 2){
                            best = 1
                            badStone = s
                            root.strategy = 3
                        }
                        else if (stone.area === 3 && best < 2){
                            best = 1
                            badStone = s
                            root.strategy = 4
                        }
                        else if (stone.area !== -1 && best < 1){
                            best = 0
                            badStone = s
                            root.strategy = 1
                        }
                    }
                }
                root.xWanted = stones.children[badStone].xC
                root.yWanted = stones.children[badStone].yC
            }
            else if (root.ownStonesInHouse > 0) {
                root.strategy = 0
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === Style.teamHome) {
                        if (stone.area === 2 || stone.area === 3 || stone.area === 4) {
                            root.xWanted = root.xHouse + 0.6 * root.rHouse
                            root.yWanted = root.yHouse
                        }
                        else if (stone.area === 1 || stone.area === 7|| stone.area === 0) {
                            root.xWanted = root.xHouse - 0.6 * root.rHouse
                            root.yWanted = root.yHouse
                        }
                        else if (stone.area !== -1){
                            root.xWanted = root.xHouse
                            root.yWanted = root.yHouse
                        }
                    }
                }
            }
            else {
                root.strategy = 0
                root.xWanted = root.xHouse
                root.yWanted = root.yHouse
            }
        }
        else {
            if (root.rivalStonesInHouse > 0) {
                badStone = -1
                best = -1
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === Style.teamVisitor) {
                        if (stone.area === 1 || stone.area === 2) {
                            best = 3
                            badStone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 8 && best < 3) {
                            best = 2
                            badStone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 0 && best < 2){
                            best = 1
                            badStone = s
                            root.strategy = 3
                        }
                        else if (stone.area === 3 && best < 2){
                            best = 1
                            badStone = s
                            root.strategy = 4
                        }
                        else if (stone.area !== -1 && best < 1){
                            best = 0
                            badStone = s
                            root.strategy = 1
                        }
                    }
                }
                root.xWanted = stones.children[badStone].xC
                root.yWanted = stones.children[badStone].yC
            }
            else if (root.ownStonesInHouse > 0) {
                root.strategy = 0
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === Style.teamHome) {
                        if (stone.area === 3 || stone.area === 4) {
                            root.xWanted = root.xHouse + 0.15 * root.rHouse
                            root.yWanted = root.yHouse + 0.8 * root.rHouse
                        }
                        else if (stone.area === 0 || stone.area === 7) {
                            root.xWanted = root.xHouse - 0.15 * root.rHouse
                            root.yWanted = root.yHouse + 0.8 * root.rHouse
                        }
                        else if (stone.area !== -1){
                            root.xWanted = root.xHouse
                            root.yWanted = root.yHouse + 0.9 * root.rHouse
                        }
                    }
                }
            }
            else {
                root.strategy = 0
                root.xWanted = root.xHouse
                root.yWanted = root.yHouse
            }
        }
    }

    function sweepUp() {
        if (root.upPressable) {
            root.pressUp()
            root.releaseUp()
            upCooldown.restart()
        }
    }
    function sweepDown() {
        if (root.downPressable) {
            root.pressDown()
            root.releaseDown()
            downCooldown.restart()
        }
    }

    Timer{
        id: upCooldown

        interval: 100
        triggeredOnStart: true
        onTriggered: root.upPressable = ! root.upPressable
    }

    Timer{
        id: downCooldown

        interval: 100
        triggeredOnStart: true
        onTriggered: root.downPressable = ! root.downPressable
    }

    function smartRandomDirection(xDelta) {
        if (xDelta > 0)
            return - 5 - Math.random() * 10
        else
            return 5 + Math.random() * 10
    }

    function randomPower(shoot) {
        if (shoot)
            return 100 - Math.random() * 20
        else
            return 75 + Math.random() * 10
    }
}
