import QtQuick 2.2
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    anchors.fill: parent
    anchors.margins: -1
    color: "#ddddee"
    border.color: "#50000000"
    border.width: 1
    layer.enabled: true
    layer.effect: InnerShadow {
            radius: 30
            samples: 32
            spread: 0.3
            color: "#000000"
        }
}
