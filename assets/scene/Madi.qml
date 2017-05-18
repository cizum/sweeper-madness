/* Mad intelligence */
import QtQuick 2.0
import "../tools.js" as Tools

Item {
    id: root
    property bool playing: false
    property bool ready: false
    property int position_target: 0
    property int direction_target: 0
    property int power_target: 0
    signal pressDown()
    signal pressUp()
    signal pressSpace()
    signal releaseDown()
    signal releaseUp()
    property bool down: false
    property bool up: false
    property bool down_pressable: true
    property bool up_pressable: true
    property double x_wanted: 0
    property double y_wanted: 0
    property double x_house: 0
    property double y_house: 0
    property double r_house: 0

    property bool has_last_throw: false
    property int own_stones_in_house: 0
    property int rival_stones_in_house: 0

    property int strategy: 0 // 0 point 1 freeze 2 centered shoot 3 left shoot 4 right shoot

    onPressDown: root.down = true
    onReleaseDown: root.down = false
    onPressUp: root.up = true
    onReleaseUp: root.up = false

    function think(phase, position, direction, power, stones, stone) {
        switch(phase) {
        case 1:
            if (!root.ready) {
                root.analyze_situtation(stones)
                root.define_strategy(stones)
                root.choose(position, stone)
            }
            else {
                if (Math.abs(position - root.position_target) < 1) {
                    if (root.down)
                        root.releaseDown()
                    if (root.up)
                        root.releaseUp()
                    root.pressSpace()
                }
                else if (position < root.position_target){
                    if (root.up)
                        root.releaseUp()
                    if (!root.down)
                        root.pressDown()
                }
                else {
                    if (root.down)
                        root.releaseDown()
                    if (!root.up)
                        root.pressUp()
                }
            }
            break
        case 2:
            if (near(direction, root.direction_target, 4)) {
                root.pressSpace()
            }
            break
        case 3:
            if (near(power, root.power_target, 6)) {
                root.pressSpace()
            }
            break
        case 4:
            adapt(stone)
            break
        }
    }

    function choose(position, stone) {
        var s = 0
        var d = 0
        switch(root.strategy) {
        case 0:
            root.direction_target = root.smart_random_direction(root.y_wanted - position)
            root.power_target = root.random_power(false)
            s = root.power_target < 60 ? 2 : root.power_target / 30
            d = root.direction_target * Math.PI / 180
            root.position_target = stone.find_y_start(root.y_wanted, s, d)
            break
        case 1:
            root.direction_target = root.smart_random_direction(root.y_wanted - position)
            root.power_target = root.random_power(false)
            root.position_target = position + Math.random() * 60 - 30
            s = root.power_target < 60 ? 2 : root.power_target / 30
            d = root.direction_target * Math.PI / 180
            root.position_target = stone.find_y_start(root.y_wanted, s, d)
            break
        case 2:
            root.direction_target = root.smart_random_direction(root.y_wanted - position)
            root.power_target = root.random_power(true)
            root.position_target = position + Math.random() * 60 - 30
            s = root.power_target < 60 ? 2 : root.power_target / 30
            d = root.direction_target * Math.PI / 180
            root.position_target = stone.find_y_start_shoot(root.y_wanted, s, d)
            break
        case 3:
            root.direction_target = root.smart_random_direction(root.y_wanted - position)
            root.power_target = root.random_power(true)
            root.position_target = position + Math.random() * 60 - 30
            s = root.power_target < 60 ? 2 : root.power_target / 30
            d = root.direction_target * Math.PI / 180
            root.position_target = stone.find_y_start_shoot(root.y_wanted, s, d)
            break
        case 4:
            root.direction_target = root.smart_random_direction(root.y_wanted - position)
            root.power_target = root.random_power(true)
            root.position_target = position + Math.random() * 60 - 30
            s = root.power_target < 60 ? 2 : root.power_target / 30
            d = root.direction_target * Math.PI / 180
            root.position_target = stone.find_y_start_shoot(root.y_wanted, s, d)
            break
        }
        root.ready = true
    }

    function near(value, target, offset) {
        if (value > target - offset && value < target + offset){
            if (Math.random() < 0.15)
                return true
        }
        return false
    }

    function adapt(stone) {
        switch(root.strategy) {
        case 0:
            root.adapt_point(stone, root.x_wanted, root.y_wanted)
            break
        case 1:
            root.adapt_point(stone, root.x_wanted - 2 * stone.radius, root.y_wanted)
            break
        case 2:
            root.adapt_shoot(stone, root.x_wanted, root.y_wanted)
            break
        case 3:
            root.adapt_shoot(stone, root.x_wanted, root.y_wanted - stone.radius)
            break
        case 4:
            root.adapt_shoot(stone, root.x_wanted, root.y_wanted + stone.radius)
            break
        }
    }

    function adapt_point(stone, x, y) {
        if (stone.speed > 0 && stone.direction > -60 && stone.direction < 60) {
            var xf = stone.xC_future
            var yf = stone.yC_future
            if (xf <  x) {
                if (yf <  y - 20) {
                    sweep_up()
                }
                else if (yf > y + 20) {
                    sweep_down()
                }
                else {
                    sweep_up()
                    sweep_down()
                }
            }
        }
    }

    function adapt_shoot(stone, x, y) {
        var far = true
        if (stone.speed > 0 && stone.direction > -60 && stone.direction < 60) {
            var end_time = stone.end_time()
            for (var i = 0; i < 20; i++) {
                var future_pos = stone.future_position(i * end_time / 20)
                if (future_pos[0] > x - 20 && future_pos[0] < x + 20) {
                    far = false
                    if (future_pos[1] < y) {
                        sweep_up()
                        break
                    }
                    else if (future_pos[1] > y) {
                        sweep_down()
                        break
                    }
                }
            }
            if (far) {
                sweep_up()
                sweep_down()
            }
        }
    }

    function analyze_situtation(stones) {
        root.own_stones_in_house = 0
        root.rival_stones_in_house = 0
        for (var s = 0; s < stones.count; s++) {
            var stone = stones.children[s]
            if (stone.area !== -1) {
                if (stone.team === 0) {
                    root.own_stones_in_house ++
                }
                else {
                    root.rival_stones_in_house ++
                }
            }
        }
    }

    function define_strategy(stones) {
        var s = 0
        var bad_stone = -1
        var best = -1
        var stone
        if (root.has_last_throw) {
            if (root.rival_stones_in_house > 0) {
                bad_stone = -1
                best = -1
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === 1) {
                        if (stone.area === 3 || stone.area === 4) {
                            best = 3
                            bad_stone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 8 && best < 3) {
                            best = 2
                            bad_stone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 2 && best < 2){
                            best = 1
                            bad_stone = s
                            root.strategy = 3
                        }
                        else if (stone.area === 5 && best < 2){
                            best = 1
                            bad_stone = s
                            root.strategy = 4
                        }
                        else if (stone.area !== -1 && best < 1){
                            best = 0
                            bad_stone = s
                            root.strategy = 1
                        }
                    }
                }
                root.x_wanted = stones.children[bad_stone].xC
                root.y_wanted = stones.children[bad_stone].yC
            }
            else if (root.own_stones_in_house > 0) {
                root.strategy = 0
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === 0) {
                        if (stone.area === 4 || stone.area === 5 || stone.area === 6) {
                            root.x_wanted = root.x_house
                            root.y_wanted = root.y_house + 0.7 * root.r_house
                        }
                        else if (stone.area === 3 || stone.area === 2 || stone.area === 1) {
                            root.x_wanted = root.x_house
                            root.y_wanted = root.y_house - 0.7 * root.r_house
                        }
                        else if (stone.area !== -1){
                            root.x_wanted = root.x_house
                            root.y_wanted = root.y_house
                        }
                    }
                }
            }
            else {
                root.strategy = 0
                root.x_wanted = root.x_house
                root.y_wanted = root.y_house - 0.7 * root.r_house
            }
        }
        else {
            if (root.rival_stones_in_house > 0) {
                bad_stone = -1
                best = -1
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === 1) {
                        if (stone.area === 3 || stone.area === 4) {
                            best = 3
                            bad_stone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 8 && best < 3) {
                            best = 2
                            bad_stone = s
                            root.strategy = 2
                        }
                        else if (stone.area === 2 && best < 2){
                            best = 1
                            bad_stone = s
                            root.strategy = 3
                        }
                        else if (stone.area === 5 && best < 2){
                            best = 1
                            bad_stone = s
                            root.strategy = 4
                        }
                        else if (stone.area !== -1 && best < 1){
                            best = 0
                            bad_stone = s
                            root.strategy = 1
                        }
                    }
                }
                root.x_wanted = stones.children[bad_stone].xC
                root.y_wanted = stones.children[bad_stone].yC
            }
            else if (root.own_stones_in_house > 0) {
                root.strategy = 0
                for (s = 0; s < stones.count; s++) {
                    stone = stones.children[s]
                    if (stone.team === 0) {
                        if (stone.area === 4 || stone.area === 5) {
                            root.x_wanted = root.x_house - 0.8 * root.r_house
                            root.y_wanted = root.y_house + 0.2 * root.r_house
                        }
                        else if (stone.area === 3 || stone.area === 2) {
                            root.x_wanted = root.x_house - 0.8 * root.r_house
                            root.y_wanted = root.y_house - 0.2 * root.r_house
                        }
                        else if (stone.area !== -1){
                            root.x_wanted = root.x_house - root.r_house
                            root.y_wanted = root.y_house
                        }
                    }
                }
            }
            else {
                root.strategy = 0
                root.x_wanted = root.x_house - root.r_house
                root.y_wanted = root.y_house
            }
        }
    }

    function sweep_up() {
        if (root.up_pressable) {
            root.pressUp()
            root.releaseUp()
            up_cooldown.restart()
        }
    }
    function sweep_down() {
        if (root.down_pressable) {
            root.pressDown()
            root.releaseDown()
            down_cooldown.restart()
        }
    }

    Timer{
        id: up_cooldown
        interval: 100
        triggeredOnStart: true
        onTriggered: root.up_pressable = ! root.up_pressable
    }
    Timer{
        id: down_cooldown
        interval: 100
        triggeredOnStart: true
        onTriggered: root.down_pressable = ! root.down_pressable
    }

    function smart_random_direction(y_delta) {
        if (y_delta > 0)
            return - 5 - Math.random() * 10
        else
            return 5 + Math.random() * 10
    }

    function random_power(shoot) {
        if (shoot)
            return 100 - Math.random() * 5
        else
            return 80 + Math.random() * 15
    }
}
