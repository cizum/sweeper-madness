import QtQuick 2.9
import "skins"
import "../tools.js" as Tools

import krus.morten.style 1.0

Item {
    id: root

    width: 35
    height: 15
    x: xC - width / 2
    y: yC - height /2
    z: 1

    property double xC: 0
    property double yC: 0
    property int team: 0
    property double xStart: 0
    property double yStart: 0
    property double xEnd: 0
    property double yEnd: 0
    property double xStone: 0
    property double yStone: 0
    property double xOff: 0
    property double yOff: 0
    property double angle: 0
    property double oldxC: 0
    property double oldyC: 0
    property int startStoneIndex: -1
    property int endStoneIndex: -1

    Behavior on angle {
        RotationAnimation {
            duration: 150
            direction: RotationAnimation.Shortest
        }
    }

    Behavior on width {
        NumberAnimation {
            duration: 100
        }
    }

    Behavior on height {
        NumberAnimation {
            duration: 100
        }
    }

    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height / 2
        angle: root.angle
    }

    ProviderSkin {
        id: providerSkin

        anchors.fill: parent
        team: root.team
    }

    function update(phase, currentTeam) {
        if (phase !== 4) {
            root.nextPosition(phase, currentTeam)
            root.nextAngle()
        }
    }

    function nextAngle() {
        if (root.closeTo(root.xStart, root.yStart)) {
            root.angle = root.team === Style.teamHome ? -90 : 90
        }
        else if (root.closeTo(root.xStone, root.yStone)) {
            root.angle = root.team === Style.teamHome ? -90 : 90
        }
        else if (root.closeTo(root.xEnd, root.yEnd)) {
            root.angle = root.team === Style.teamHome ? -90 : 90
        }
        else if (root.closeTo(root.xOff, root.yOff)) {
            root.angle = root.team === Style.teamHome ? -90 : 90
        }
        else {
            var tmpangle = root.slope(root.oldxC, root.oldyC) * 180 / Math.PI - 90
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

    function nextPosition(phase, currentTeam) {
        if (phase < 4)
            root.moveTo(root.xStart, root.yStart, 2)
        else if (team !== currentTeam)
            root.moveTo(root.xEnd, root.yEnd, 2)
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

    function shoot() {
        providerSkin.shoot()
    }
}
