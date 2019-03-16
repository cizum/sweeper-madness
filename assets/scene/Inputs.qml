import QtQuick 2.9
import "../tools.js" as Tools

QtObject {
    id: root

    property double position: 50
    property double power: 0
    property double direction: -20
    property double speed: Tools.powerToSpeed(root.power)
    property double positionMin: 0
    property double positionMax: 100
    property int positionDirection: 0
    property int positionVelocity: 2
    readonly property double powerMax: 100
    property int powerDirection: 1
    property double powerGap: 0.75
    property double directionRad: direction * Math.PI / 180
    readonly property double directionMax: 25
    property int directionDirection: 1
    property double directionGap: 0.4

    function updatePosition() {
        root.position = Math.min(Math.max(root.position + root.positionDirection * root.positionVelocity, root.positionMin), root.positionMax)
    }

    function updateDirection() {
        var evoSpeed = root.directionGap + 0.1 * (root.directionMax - Math.abs(root.direction))
        var newDir = root.direction + root.directionDirection * evoSpeed
        if (newDir >= root.directionMax) {
            root.directionDirection = -1
            if (root.directionGap < 0.8)
                root.directionGap = root.directionGap + 0.2
            root.direction = root.directionMax
        }
        else if (newDir <= - root.directionMax) {
            root.directionDirection = 1
            root.direction = - root.directionMax
        }
        else
            root.direction = newDir
    }

    function updatePower() {
        var velocity = root.powerGap + 0.05 * root.power
        var newPower = root.power + root.powerDirection * velocity
        if (newPower >= root.powerMax) {
            root.powerDirection = -1
            if (root.powerGap < 4)
                root.powerGap = root.powerGap + 1
            root.power = root.powerMax
        }
        else if (newPower <= 0) {
            root.powerDirection = 1
            root.power = 0
        }
        else
            root.power = newPower
    }

    function initialize() {
        root.position = (root.positionMin + root.positionMax) / 2
        root.positionDirection = 0
        root.power = 0
        root.powerDirection = 1
        root.powerGap = 1
        root.direction = -20
        root.directionDirection = 1
        root.directionGap = 1
    }
}
