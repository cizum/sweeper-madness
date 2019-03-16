import QtQuick 2.9
import QtQuick.Window 2.3

import "assets"

Window {
    id: root

    width: 720
    height: 1280
    color: "#ddddee"
    visible: true
    visibility: Window.FullScreen

    property int gameState: 0

    FontLoader { source: "fonts/iamaplayer.ttf" }

    Background {
        id: background

        anchors.fill: parent
    }

    Timer {
        id: gameTimer

        interval: 25
        running: true
        repeat: true
        onTriggered: {
            switch(root.gameState) {
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
        gameState: root.gameState
        scale: Math.min(root.width / width, root.height / height)
        onMenu: {
            menu.started = ! scene.finished
            root.gameState = 0
        }
        onTutorial: {
            if (root.gameState === 1)
                root.gameState = 2
            else if (root.gameState === 2)
                root.gameState = 1
        }
        opacity: gameState !== 0 ? 1 : 0
    }

    Menu {
        id: menu

        anchors.centerIn: parent
        opacity: root.gameState === 0 ? 1 : 0
        scale: Math.min(root.width / width, root.height / height)
        onStart: {
            scene.ends = ends
            scene.stonesCount = stones
            scene.players = players
            scene.restart()
            root.gameState = 1
        }
        onResume: root.gameState = 1
    }
}
