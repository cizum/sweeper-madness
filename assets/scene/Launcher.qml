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

    transform: Rotation{
        origin.x: root.width / 2
        origin.y: root.height / 2
        angle: 90
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

    Behavior on x {
        id: move_smooth_x
        enabled: false
        NumberAnimation {
            NumberAnimation on duration {
                running: move_smooth_x.enabled
                from: 8000
                to: 0
                duration: 8000
                onStopped: move_smooth_x.enabled = false
            }
        }
    }

    Behavior on y {
        id: move_smooth_y
        enabled: false
        NumberAnimation {
            NumberAnimation on duration {
                running: move_smooth_y.enabled
                from: 8000
                to: 0
                duration: 8000
                onStopped: move_smooth_y.enabled = false
            }
        }
    }

    function move_smooth(){
        move_smooth_x.enabled = true;
        move_smooth_y.enabled = true;
    }
}
