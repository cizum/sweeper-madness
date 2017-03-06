import QtQuick 2.2

Rectangle {
    id: root
    width: 25
    height: 25
    z: 1
    radius: width / 2 + 1
    color: "#aaaaaa"
    border.color: "#101010"
    x: xC - width / 2
    y: yC - height /2
    property double xC: 0
    property double yC: 0
    property var colors: ["#ffff55", "#cc2020", "#55ff55", "#5555ff"]
    property string main_color: colors[team]
    property int team: 0
    property double speed: 0
    property double angle: 0
    property bool move_up: false
    property bool move_down: false
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
        width: parent.width / 2
        height: 1 * parent.height / 5
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
        if (Math.random() > 0.8){
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

    function custom_move(speed, angle){
        var angle_rad = angle * Math.PI / 180
        xC = xC + speed * Math.cos(angle_rad);
        yC = yC + speed * Math.sin(angle_rad);
    }

    function move(){
        var angle_rad = root.angle * Math.PI / 180
        xC = xC + root.speed * Math.cos(angle_rad);
        yC = yC + root.speed * Math.sin(angle_rad);
    }

    function friction(f){
        var new_speed = root.speed - f
        if (new_speed < 0)
            root.speed = 0
        else
            root.speed = new_speed
    }

    function update(){
        move()
        friction(0.005)
    }

    function stop(){
        root.move_up = false
        root.move_down = false
    }
    function update_phase1(){
        root.yC = root.yC + ((root.move_up ? -1 : 0) + (root.move_down ? 1 : 0) )
    }
}

