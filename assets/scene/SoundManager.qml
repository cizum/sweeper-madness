import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: root
    property int gameState: 0

    signal applauseForPoint()

    onGameStateChanged: {
        if(root.gameState) {
            startSound.play()
        }
        else{
            startSound.stop()
        }
    }

    onApplauseForPoint: pointApplause.play()


    Audio{
        id: startSound
        source: "../../sounds/gamestart.ogg"
    }

    Audio{
        id: pointApplause
        source: "../../sounds/applause.ogg"
    }



}

