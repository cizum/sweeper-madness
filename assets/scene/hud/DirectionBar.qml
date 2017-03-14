import QtQuick 2.2
import "../../styles/classic"
import "../../styles/neon"

Item {
    id: root
    width: 100
    height: 100
    property double direction: 0
    property int style: 0

    DirectionBarClassic {
        visible: root.style == 0
        direction: root.direction
    }

    DirectionBarNeon {
        visible: root.style == 1
        direction: root.direction
    }
}
