import QtQuick 2.2

Rectangle {
    id: root
    width: 25
    height: 25
    radius: width / 2 + 1
    color: "#aaaaaa"
    border.color: "#101010"
    x: xC - width / 2
    y: yC - height /2
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

    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height / 2
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
        width: parent.width / 2
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

    onXChanged: {
        if (Math.random() > 0.8) {
            var newObject = Qt.createQmlObject('
                import QtQuick 2.3;
                Rectangle {
                    color:"#ffffff";
                    radius:3;
                    width: 3;
                    height: 3;
                    x:' + (root.xC-1) + '; y:'+ (root.yC-1) + ';' + '
                    NumberAnimation on opacity{
                        duration:2000;
                        from:1.0; to:0.2
                    }
                }',
                traces,
                "dynamicSnippet1");
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
}

