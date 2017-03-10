
function x1_gap(ax, ay, angle) {
    return ax * Math.cos(angle) - ay * Math.sin(angle)
}

function y1_gap(ax, ay, angle) {
    return ax * Math.sin(angle) + ay * Math.cos(angle)
}

function x2_gap(ax, ay, angle) {
    return ax * Math.cos(angle) + ay * Math.sin(angle)
}

function y2_gap(ax, ay, angle) {
    return ax * Math.sin(angle) - ay * Math.cos(angle)
}

function slope(x0, y0, x1, y1) {
    var a = Math.atan2(y1 - y0, x1 - x0)
    return a / Math.PI * 180
}

function compare(a, b) {
    if (a[1] === b[1]) {
        return 0
    }
    else {
        return (a[1] < b[1]) ? -1 : 1
    }
}

function dsquare(x0, y0, x1, y1) {
    return (x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0)
}

function solve_collision(stone_a, stone_b) {
    var a = slope(stone_b.xC, stone_b.yC, stone_a.xC, stone_a.yC)
    var s1 = stone_a.speed
    var s2 = stone_b.speed
    var th1rad = (stone_a.direction - a - 90) * Math.PI / 180
    var th2rad = (stone_b.direction - a - 90) * Math.PI / 180
    var cs11 = s1 * Math.cos(th1rad)
    var cs12 = s2 * Math.sin(th2rad)
    var cs21 = s1 * Math.sin(th1rad)
    var cs22 = s2 * Math.cos(th2rad)
    stone_a.speed = Math.sqrt(cs11 * cs11 + cs12 * cs12)
    stone_b.speed = Math.sqrt(cs21 * cs21 + cs22 * cs22)
    stone_a.direction = Math.atan2(cs12, cs11) * 180 / Math.PI + (a + 90)
    stone_b.direction = Math.atan2(cs21, cs22) * 180 / Math.PI + (a + 90)
}
