import QtQuick 2.9
import "skins"
import "../tools.js" as Tools

Item {
    id: root

    width: 25
    height: 25
    x: xC - width / 2
    y: yC - height / 2
    rotation: root.angle

    property int radius: root.width / 2
    property double xC: 0
    property double yC: 0
    property int team: 0
    property double speed: 0
    property double direction: 0
    property double directionRad: root.direction * Math.PI / 180
    property double angle: 0
    property double fFriction: 0.005
    property double fCurl: 0.02
    property int fCurlDir: 1
    property double xCFuture: 0
    property double yCFuture: 0
    property double d2Target: -1
    property int area: -1

    StoneSkin {
        anchors.fill: parent
        team: parent.team
    }

    function initialize(xc, yc) {
        root.xC = sheet.x + sheet.width / 2
        root.yC = sheet.y + sheet.height - 20
        root.fCurl = 0.02
        root.fFriction = 0.005
    }

    function customMove(speed, direction) {
        var directionRad = direction * Math.PI / 180
        xC = xC + speed * Math.cos(directionRad);
        yC = yC + speed * Math.sin(directionRad);
    }

    function move() {
        xC = xC + root.speed * Math.cos(directionRad);
        yC = yC + root.speed * Math.sin(directionRad);
    }

    function friction(f) {
        var newSpeed = root.speed - f
        if (newSpeed < 0)
            root.speed = 0
        else
            root.speed = newSpeed
    }

    function update() {
        move()
        curl()
        friction(root.fFriction)
    }

    function curl() {
        if (root.speed > 0 && root.fCurl > 0) {
            var fcv = root.fCurlDir * root.fCurl  * root.speed
            root.direction = root.direction + fcv
            root.angle = root.angle + fcv * 100
        }
    }

    function futurePosition(t) {
        var s = root.speed
        var d = root.direction
        var x = root.xC
        var y = root.yC
        var ff = root.fFriction
        var cv = Math.PI / 180
        var fcr = root.fCurlDir * root.fCurl * cv
        var dRad = d * cv
        var cosd = Math.cos(dRad)
        var sind = Math.sin(dRad)
        var nx = x + 1 / fcr * (- sind + sind * Math.cos(fcr * (- s * t + 1 / 2 * ff * t * t))
                                       - cosd * Math.sin(fcr * (- s * t + 1 / 2 * ff * t * t)))
        var ny = y + 1 / fcr * (cosd - sind * Math.sin(fcr * (- s * t + 1 / 2 * ff * t * t))
                                     - cosd * Math.cos(fcr * (- s * t + 1 / 2 * ff * t * t)))
        return [nx, ny]
    }

    function endTime() {
        return root.speed / root.fFriction
    }

    function prevision() {
        var r = futurePosition(endTime())
        root.xCFuture = r[0]
        root.yCFuture = r[1]
        return r
    }

    function findXStart(x0, s0, d0) {
        var t = s0 / root.fFriction
        var ff = root.fFriction
        var cv = Math.PI / 180
        var fcr = (d0 > 0 ? 1 : -1) * root.fCurl * cv
        var dRad = d0 * cv
        var cosd = Math.cos(dRad)
        var sind = Math.sin(dRad)

        var xStart = x0 - 1 / fcr * (cosd - sind * Math.sin(fcr * (- s0 * t + 1 / 2 * ff * t * t))
                                          - cosd * Math.cos(fcr * (- s0 * t + 1 / 2 * ff * t * t)))
        if (xStart > 400)
            xStart = 400
        else if (xStart < 300)
            xStart = 300
        return xStart
    }

    function findXStartShoot(x0, s0, d0) {
        var t = 0.5 * s0 / root.fFriction
        var ff = root.fFriction
        var cv = Math.PI / 180
        var fcr = (d0 > 0 ? 1 : -1) * root.fCurl * cv
        var dRad = d0 * cv
        var cosd = Math.cos(dRad)
        var sind = Math.sin(dRad)

        var xStart = x0 - 1 / fcr * (cosd - sind * Math.sin(fcr * (- s0 * t + 1 / 2 * ff * t * t))
                                          - cosd * Math.cos(fcr * (- s0 * t + 1 / 2 * ff * t * t)))
        if (xStart > 440)
            xStart = 440
        else if (xStart < 260)
            xStart = 260
        return xStart
    }

    function target(tx, ty) {
        root.speed = Math.sqrt(2 * fFriction * Math.sqrt(Tools.dsquare(root.xC, root.yC, tx, ty)))
        root.direction = Tools.slope(root.xC, root.yC, tx, ty)
        root.fCurl = 0
    }
}

