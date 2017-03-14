import QtQuick 2.2
import "../styles/classic"
import "../styles/neon"

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
    property double f_curl: 0.05
    property int f_curl_dir: 1
    property double xC_future: 0
    property double yC_future: 0

    transform: Rotation{
        origin.x: root.width / 2 + 1
        origin.y: root.height / 2 + 1
        angle: root.angle
    }

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
        friction(0.005)
    }

    function curl(){
        if (root.speed > 0 && root.f_curl > 0){
            root.direction = root.direction + root.f_curl_dir *  root.f_curl
            root.angle = root.angle + root.f_curl_dir * root.f_curl * 100
            var new_f_curl = root.f_curl - 0.0001
            root.f_curl = new_f_curl > 0 ? new_f_curl : 0
        }
    }

    function prevision(){
        var s = root.speed
        var d = root.direction
        var x = root.xC
        var y = root.yC
        var fc = root.f_curl

        while(s > 0) {
            var d_rad = d * Math.PI / 180
            x = x + s * Math.cos(d_rad);
            y = y + s * Math.sin(d_rad);
            s = s - 0.005
            d = d + root.f_curl_dir * fc
            fc = fc - 0.0001
            if (fc < 0) fc = 0
        }
        root.xC_future = x
        root.yC_future = y
    }
}

