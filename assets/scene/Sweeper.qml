import QtQuick 2.2
import "../styles/classic"
import "../styles/neon"

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

    Behavior on x {
        id: move_smooth_x
        enabled: false
        NumberAnimation {
            duration: 2000
            easing.type: "OutCubic"
            NumberAnimation on duration {
                running: move_smooth_x.enabled
                from: 2000
                to: 0
                duration: 2000
                easing.type: "OutCubic"
                onStopped: move_smooth_x.enabled = false
            }
        }
    }

    Behavior on y {
        id: move_smooth_y
        enabled: false
        NumberAnimation {
            duration: 2000
            NumberAnimation on duration {
                running: move_smooth_y.enabled
                from: 2000
                to: 0
                duration: 2000
                easing.type: "OutCubic"
                onStopped: move_smooth_y.enabled = false
            }
        }
    }

    function move_smooth(){
        move_smooth_x.enabled = true;
        move_smooth_y.enabled = true;
    }

    function sweep() {
        if (root.style == 0)
            sweeper_classic.sweep()
        else
            sweeper_neon.sweep()
    }
}
