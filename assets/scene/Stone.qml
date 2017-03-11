import QtQuick 2.2

Rectangle {
    id: root
    width: 25
    height: 25
    radius: width / 2 + 1
    color: "#aaaaaa"
    border.color: "#101010"
    x: xC - width / 2
    y: yC - height / 2
    property double xC: 0
    property double yC: 0
    property int team: 0
    property var colors: ["#ffff55", "#cc2020", "#55ff55", "#5555ff"]
    property string main_color: colors[team]
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

    Rectangle {
        width: 3 * parent.width / 4
        height: 3 * parent.height / 4
        radius: width / 2 + 1
        anchors.centerIn: parent
        color: root.main_color
        border.color: "#aaaaee"
    }
    Rectangle {
        id: handle
        width: 10
        height: 5
        radius: width / 2 + 1
        anchors.centerIn: parent
        color: root.main_color
        border.color: "#303030"

        Rectangle {
            width: parent.height - 2
            height: parent.height - 2
            radius: width / 2 + 1
            anchors.right: parent.right
            anchors.rightMargin: -1
            anchors.verticalCenter: parent.verticalCenter
            color: root.main_color
        }
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

