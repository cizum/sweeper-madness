import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: root
    anchors.fill: parent
    property int gameState: 0
    property bool mute: false
    signal collide()
    signal sweep()

    onGameStateChanged: {
        if(root.gameState) {
            theme.play()
        }
        else{
            theme.stop()
        }
    }

    onApplauseForPoint: pointApplause.play()
    onCollide: collision.play()
    onSweep: {
        if (sweepIndex == 0)
            sweep1.play()
        else {
            sweep2.play()
        }
        sweepIndex = (sweepIndex + 1) % 2
    }
    onMuteChanged: opacity_mute_anim.restart()

    Audio{
        id: theme
        source: "../../sounds/theme.ogg"
        loops: Audio.Infinite
        muted: true// root.mute
    }

    Audio{
        id: collision
        source: "../../sounds/choc.ogg"
        muted: root.mute
    }

    property int sweepIndex: 0
    Audio{
        id: sweep1
        source: "../../sounds/sweep.ogg"
        muted: root.mute
    }

    Audio{
        id: sweep2
        source: "../../sounds/sweep.ogg"
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

    function update(phase) {
        if (phase == 4)
            sweeping.play()
        else
            sweeping.stop()
    }
}

