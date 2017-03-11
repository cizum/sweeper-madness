import QtQuick 2.0

Item {
    id: root
    property double position: 50
    property double power: 0
    property double direction: -20
    property double speed: root.power < 60 ? 2 : root.power / 30

    property double position_min: 0
    property double position_max: 100
    property int position_sense: 0
    readonly property double power_max: 100
    property int power_sense: 1
    property double power_gap: 1
    property double direction_rad: direction * Math.PI / 180
    readonly property double direction_max: 25
    property int direction_sense: 1
    property double direction_gap: 0.4

    function update_position() {
        var new_position = root.position + root.position_sense * 2
        if (new_position >= root.position_max) {
            root.position = root.position_max
        }
        else if (new_position <= root.position_min) {
            root.position = root.position_min
        }
        else
            root.position = new_position
    }

    function update_direction() {
        var evo_speed = root.direction_gap + 0.1 * (root.direction_max - Math.abs(root.direction))
        var new_dir = root.direction + root.direction_sense * evo_speed
        if (new_dir >= root.direction_max) {
            root.direction_sense = -1
            if (root.direction_gap < 0.8)
                root.direction_gap = root.direction_gap + 0.2
            root.direction = root.direction_max
        }
        else if (new_dir <= - root.direction_max) {
            root.direction_sense = 1
            root.direction = - root.direction_max
        }
        else
            root.direction = new_dir
    }

    function update_power() {
        var evo_speed = root.power_gap + 0.05 * root.power
        var new_power = root.power + root.power_sense * evo_speed
        if (new_power >= root.power_max) {
            root.power_sense = -1
            if (root.power_gap < 4)
                root.power_gap = root.power_gap + 1
            root.power = root.power_max
        }
        else if (new_power <= 0) {
            root.power_sense = 1
            root.power = 0
        }
        else
            root.power = new_power
    }

    function initialize() {
        root.position = (root.position_min + root.position_max) / 2
        root.position_sense = 0
        root.power = 0
        root.power_sense = 1
        root.power_gap = 1
        root.direction = -20
        root.direction_sense = 1
        root.direction_gap = 1
    }
}
