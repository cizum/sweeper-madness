import QtQuick 2.2
import "../styles/classic"
import "../styles/neon"

Item {
    id: root
    width: 22
    height:22
    x: xC - width / 2
    y: yC - height /2
    z: 1
    property double xC: 0
    property double yC: 0
    property int style: 0
    property int team: 0
    property double xStart: 0
    property double yStart: 0
    property double xEnd: 0
    property double yEnd: 0
    property double xStone: 0
    property double yStone: 0
    property double xOff: 0
    property double yOff: 0
    property int speed: 3
    property double direction: 90

    Behavior on direction {
        NumberAnimation {
            duration: 100
        }
    }

    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height / 2
        angle: root.direction
    }

    LauncherClassic {
        id: launcher_classic
        anchors.fill: parent
        team: root.team
        visible: root.style == 0
    }

    LauncherNeon {
        id: launcher_neon
        anchors.fill: parent
        team: root.team
        visible: root.style == 1
    }

    function update(phase, current_team) {
        root.nextPosition(phase, current_team)
    }

    function nextPosition(phase, current_team) {
        if (root.team === current_team) {
            if (phase < 1)
                root.moveTo(root.xStart, root.yStart, 4)
            else if (phase > 3)
                root.moveTo(root.xEnd, root.yEnd, 2)
            else
                root.moveTo(root.xStone, root.yStone, 3)
        }
        else
            root.moveTo(root.xOff, root.yOff, 4)
    }

    function moveTo(x, y, speed) {
        var sgn = 1
        if (root.xC !== x && root.yC !== y) {
            var a = slope(x, y)
            var sx = speed * Math.cos(a)
            var sy = speed * Math.sin(a)
            root.xC = root.getClose(root.xC, x, sx)
            root.yC = root.getClose(root.yC, y, sy)
        }
        else if (root.xC !== x) {
            sgn = root.sign(x - root.xC)
            root.xC = root.getClose(root.xC, x, sgn * speed)
        }
        else if (root.yC !== y) {
            sgn = root.sign(y - root.yC)
            root.yC = root.getClose(root.yC, y, sgn * speed)
        }
    }

    function getClose(a0, a1, speed) {
        var d = Math.abs(a1 - a0)
        if (d < speed )
            return a1
        else
            return a0 + speed
    }
    function sign(a) {
        return a / Math.abs(a)
    }

    function slope(x,y) {
        return Math.atan2(y - root.yC, x - root.xC)
    }
}
