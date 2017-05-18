import QtQuick 2.2
import "../styles/classic"
import "../styles/neon"
import "../tools.js" as Tools

Item {
    id: root
    width: 25
    height: 25
    x: xC - width / 2
    y: yC - height / 2
    property int style: 0
    property int radius: root.width / 2
    property double xC: 0
    property double yC: 0
    property int team: 0
    property double speed: 0
    property double direction: 0
    property double direction_rad: root.direction * Math.PI / 180
    property double angle: 0
    property double f_friction: 0.005
    property double f_curl: 0.02
    property int f_curl_dir: 1
    property double xC_future: 0
    property double yC_future: 0
    rotation: root.angle

    property double d2_target: -1
    property int area: -1

    StoneClassic{
        anchors.fill: parent
        team: parent.team
        visible: root.style == 0
    }

    StoneNeon{
        anchors.fill: parent
        team: parent.team
        visible: root.style == 1
    }

    function custom_move(speed, direction) {
        var direction_rad = direction * Math.PI / 180
        xC = xC + speed * Math.cos(direction_rad);
        yC = yC + speed * Math.sin(direction_rad);
    }

    function move() {
        xC = xC + root.speed * Math.cos(direction_rad);
        yC = yC + root.speed * Math.sin(direction_rad);
    }

    function friction(f) {
        var new_speed = root.speed - f
        if (new_speed < 0)
            root.speed = 0
        else
            root.speed = new_speed
    }

    function update() {
        move()
        curl()
        friction(root.f_friction)
    }

    function curl() {
        if (root.speed > 0 && root.f_curl > 0) {
            var fcv = root.f_curl_dir * root.f_curl  * root.speed
            root.direction = root.direction + fcv
            root.angle = root.angle + fcv * 100
        }
    }

    function future_position(t) {
        var s = root.speed
        var d = root.direction
        var x = root.xC
        var y = root.yC
        var ff = root.f_friction
        var cv = Math.PI / 180
        var fcr = root.f_curl_dir * root.f_curl * cv
        var d_rad = d * cv
        var cosd = Math.cos(d_rad)
        var sind = Math.sin(d_rad)
        var nx = x + 1 / fcr * (- sind + sind * Math.cos(fcr * (- s * t + 1 / 2 * ff * t * t))
                                       - cosd * Math.sin(fcr * (- s * t + 1 / 2 * ff * t * t)))
        var ny = y + 1 / fcr * (cosd - sind * Math.sin(fcr * (- s * t + 1 / 2 * ff * t * t))
                                     - cosd * Math.cos(fcr * (- s * t + 1 / 2 * ff * t * t)))
        return [nx, ny]
    }

    function end_time() {
        return root.speed / root.f_friction
    }

    function prevision() {
        var r = future_position(end_time())
        root.xC_future = r[0]
        root.yC_future = r[1]
        return r
    }

    function find_y_start(y0, s0, d0) {
        var t = s0 / root.f_friction
        var ff = root.f_friction
        var cv = Math.PI / 180
        var fcr = (d0 > 0 ? 1 : -1) * root.f_curl * cv
        var d_rad = d0 * cv
        var cosd = Math.cos(d_rad)
        var sind = Math.sin(d_rad)

        var y_start = y0 - 1 / fcr * (cosd - sind * Math.sin(fcr * (- s0 * t + 1 / 2 * ff * t * t))
                                          - cosd * Math.cos(fcr * (- s0 * t + 1 / 2 * ff * t * t)))
        if (y_start > 400)
            y_start = 400
        else if (y_start < 300)
            y_start = 300
        return y_start
    }

    function find_y_start_shoot(y0, s0, d0) {
        var t = 0.5 * s0 / root.f_friction
        var ff = root.f_friction
        var cv = Math.PI / 180
        var fcr = (d0 > 0 ? 1 : -1) * root.f_curl * cv
        var d_rad = d0 * cv
        var cosd = Math.cos(d_rad)
        var sind = Math.sin(d_rad)

        var y_start = y0 - 1 / fcr * (cosd - sind * Math.sin(fcr * (- s0 * t + 1 / 2 * ff * t * t))
                                          - cosd * Math.cos(fcr * (- s0 * t + 1 / 2 * ff * t * t)))
        if (y_start > 400)
            y_start = 400
        else if (y_start < 300)
            y_start = 300
        return y_start
    }
}

