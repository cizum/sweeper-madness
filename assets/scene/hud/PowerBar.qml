import QtQuick 2.2
import "../../styles/classic"
import "../../styles/neon"

Item {
    id: root
    width: 300
    height: 15
    property double power: 0
    property int style: 0

    PowerBarClassic {
        id: powerbar_classic
        power: root.power
        visible: root.style == 0
    }

    PowerBarNeon {
        id: powerbar_neon
        power: root.power
        visible: root.style == 1
    }
}
