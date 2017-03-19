import QtQuick 2.2
import "styles/classic"
import "styles/neon"

Item {
    id: root
    width: 1280
    height: 720
    property int style: 0

    BackgroundClassic{
        id: background_classic
        visible: root.style == 0
    }

    BackgroundNeon{
        id: background_neon
        visible: root.style == 1
    }
}
