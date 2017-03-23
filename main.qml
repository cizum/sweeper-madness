import QtQuick 2.2
import QtQuick.Window 2.1
import "assets"

Window {
    id: root
    visible: true
    width: 1280
    height: 720
    color: "#000000"
    property int game_state: 0
    visibility: version === "mobile" ? "FullScreen" : "Windowed"

    Background {
        id: background
        anchors.fill: parent
        style: scene.style
    }

    FontLoader {source: "fonts/paintypaint.ttf"}

    Timer {
        id: game_timer
        interval: 25
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
        opacity: gameState === 1 ? 1 : 0
        gameState: root.game_state
        scale: Math.min(root.width / width, root.height / height)
        onMenu: {
            menu.started = ! scene.finished
            root.game_state = 0
        }
    }

    Menu {
        id: menu
        anchors.centerIn: parent
        opacity: root.game_state == 0 ? 1 : 0
        scale: Math.min(root.width / width, root.height / height)
        onStart: {
            scene.ends = ends
            scene.stones_count = stones
            scene.players = players
            scene.restart()
            root.game_state = 1
        }
        onResume: {
            root.game_state = 1
        }
    }
}
