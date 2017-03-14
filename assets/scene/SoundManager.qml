import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: root
    anchors.fill: parent
    property int gameState: 0
    property bool mute: false
    signal applauseForPoint()
    signal collide()

    onGameStateChanged: {
        if(root.gameState) {
            startSound.play()
        }
        else{
            startSound.stop()
        }
    }
    onApplauseForPoint: pointApplause.play()
    onCollide: collision.play()
    onMuteChanged: opacity_mute_anim.restart()


    Audio{
        id: startSound
        source: "../../sounds/gamestart.ogg"
        muted: root.mute
    }

    Audio{
        id: pointApplause
        source: "../../sounds/applause.ogg"
        muted: root.mute
    }

    Audio{
        id: collision
        source: "../../sounds/choc.ogg"
        muted: root.mute
    }

    Text {
        id: mute_text
        opacity: 0
        text: root.mute ? "Mute" : "Sound on"
        font.family: "PaintyPaint"
        font.pixelSize: 30
        color: "#404040"
        anchors.right: parent.right
        anchors.rightMargin: 15
        y: 5
        SequentialAnimation on opacity {
            id: opacity_mute_anim
            running: false
            NumberAnimation {
                from: 0; to: 1
                duration: 200
            }
            PauseAnimation {
                duration: 1500
            }
            NumberAnimation {
                from: 1; to: 0
                duration: 200
            }
        }
    }
}

