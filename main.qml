import QtQuick 2.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
import "assets"

Window {
    id: root
    visible: true
    width: 1280
    height: 720
    color: "black"
    property int game_state: 0

    FontLoader {source: "fonts/paintypaint.ttf"}

    Timer {
        id: game_timer
        interval: 30
        running: true
        repeat: true
        onTriggered: {
            switch(root.game_state) {
            case 0:
                break
            case 1:
                scene.update()
                break
            default:
                break
            }
        }
    }

    Scene {
        id: scene
        anchors.centerIn: parent
        opacity: root.game_state == 1 ? 1 : 0
    }

    Menu {
        id: menu
        anchors.fill: parent
        opacity: root.game_state == 0 ? 1 : 0
        onStart: root.game_state = 1
    }
}
