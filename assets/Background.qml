import QtQuick 2.9
import QtGraphicalEffects 1.0

import krus.morten.style 1.0

Rectangle {
    id: root

    width: 720
    height: 1280
    anchors.margins: -1
    color: Style.backgroundColor
    border.color: Style.backgroundBorderColor
    border.width: 1
    layer.enabled: true
    layer.effect: InnerShadow {
        radius: 30
        samples: 32
        spread: 0.3
        color: Style.backgroundShadowColor
    }
}
