import QtQuick 2.2
import "../styles/classic"
import "../styles/neon"
import "../tools.js" as Tools

Item {
    id: root
    width: 31
    height: 15
    x: xC - width / 2
    y: yC - height /2
    z: 1
    property double xC: 0
    property double yC: 0
    property int style: 0
    property int team: 0
    property int side: 0
    property double xStart: 0
    property double yStart: 0
    property double xEnd: 0
    property double yEnd: 0
    property double xStone: 0
    property double yStone: 0
    property double xOff: 0
    property double yOff: 0
    property double angle: 90
    property double oldxC: 0
    property double oldyC: 0

    Behavior on angle {
        RotationAnimation {
            duration: 150
            direction: RotationAnimation.Shortest
        }
    }

    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height / 2
        angle: root.angle
    }

    SweeperClassic {
        id: sweeper_classic
        anchors.fill: parent
        team: root.team
        visible: root.style == 0
    }

    SweeperNeon {
        id: sweeper_neon
        anchors.fill: parent
        team: root.team
        visible: root.style == 1
    }

    function update(phase, current_team, stone) {
        root.nextPosition(phase, current_team, stone)
        root.nextAngle(stone)
    }

    function nextAngle(stone) {
        var tmpangle = 0
        if (root.nearFrom(root.xStone, root.yStone)) {
            tmpangle = stone.direction + (root.side == 0 ? 0 : 180)
            if (tmpangle > 180)
                root.angle = tmpangle - 360
            else if (tmpangle < - 180)
                root.angle = tmpangle + 360
            else
                root.angle = tmpangle
        }
        else if (root.closeTo(root.xEnd, root.yEnd) || root.closeTo(root.xStart, root.yStart)) {
            tmpangle = root.slope(root.xStone, root.yStone) * 180 / Math.PI + 90
            if (tmpangle > 180)
                root.angle = tmpangle - 360
            else if (tmpangle < - 180)
                root.angle = tmpangle + 360
            else
                root.angle = tmpangle
        }
        else if (root.closeTo(root.xOff, root.yOff)) {
            root.angle = root.side == 0 ? 0 : 180
        }
        else {
            tmpangle = root.slope(root.oldxC, root.oldyC) * 180 / Math.PI - 90
            if (tmpangle > 180)
                root.angle = tmpangle - 360
            else if (tmpangle < - 180)
                root.angle = tmpangle + 360
            else
                root.angle = tmpangle
        }
        root.oldxC = root.xC
        root.oldyC = root.yC
    }

    function nextPosition(phase, current_team, stone) {
        if (root.team === current_team) {
            if (phase < 4)
                root.moveTo(root.xStart, root.yStart, 4)
            else if (phase > 4)
                root.moveTo(root.xEnd, root.yEnd, 4)
            else
                root.moveTo(root.xStone, root.yStone, stone.speed * 2)
        }
        else {
            if (phase < 4)
                root.moveTo(root.xOff, root.yOff, 5)
            else
                root.moveTo(root.xStart, root.yStart, 1)
        }
    }

    function moveTo(x, y, speed) {
        var sgn = 1
        if (root.xC !== x && root.yC !== y) {
            var a = root.slope(x, y)
            var sx = speed * Math.cos(a)
            var sy = speed * Math.sin(a)
            root.xC = Tools.getClose(root.xC, x, sx)
            root.yC = Tools.getClose(root.yC, y, sy)
        }
        else if (root.xC !== x) {
            sgn = Tools.sign(x - root.xC)
            root.xC = Tools.getClose(root.xC, x, sgn * speed)
        }
        else if (root.yC !== y) {
            sgn = Tools.sign(y - root.yC)
            root.yC = Tools.getClose(root.yC, y, sgn * speed)
        }
    }

    function slope(x, y) {
        return Math.atan2(y - root.yC, x - root.xC)
    }

    function closeTo(x, y) {
        return root.xC > x - 3 && root.xC < x + 3 && root.yC > y - 3 && root.yC < y + 3
    }
    function nearFrom(x, y) {
        return root.xC > x - 20 && root.xC < x + 20 && root.yC > y - 20 && root.yC < y + 20
    }

    function sweep() {
        if (root.style == 0)
            sweeper_classic.sweep()
        else
            sweeper_neon.sweep()
    }
}
