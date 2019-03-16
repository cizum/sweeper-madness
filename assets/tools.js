
function x1Gap(ax, ay, angle) {
    return ax * Math.cos(angle) - ay * Math.sin(angle)
}

function y1Gap(ax, ay, angle) {
    return ax * Math.sin(angle) + ay * Math.cos(angle)
}

function x2Gap(ax, ay, angle) {
    return ax * Math.cos(angle) + ay * Math.sin(angle)
}

function y2Gap(ax, ay, angle) {
    return ax * Math.sin(angle) - ay * Math.cos(angle)
}

function slope(x0, y0, x1, y1) {
    var a = Math.atan2(y1 - y0, x1 - x0)
    return a / Math.PI * 180
}

function sign(a) {
    return a / Math.abs(a)
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

function getClose(a0, a1, speed) {
    var d = Math.abs(a1 - a0)
    if (d < Math.abs(speed) )
        return a1
    else
        return a0 + speed
}

function solveCollision(stoneA, stoneB) {
    var a = slope(stoneB.xC, stoneB.yC, stoneA.xC, stoneA.yC)
    var s1 = stoneA.speed
    var s2 = stoneB.speed
    var cpi =  Math.PI / 180
    var th1rad = (stoneA.direction - a - 90) * cpi
    var th2rad = (stoneB.direction - a - 90) * cpi
    var cs11 = s1 * Math.cos(th1rad)
    var cs12 = s2 * Math.sin(th2rad)
    var cs21 = s1 * Math.sin(th1rad)
    var cs22 = s2 * Math.cos(th2rad)
    stoneA.speed = Math.sqrt(cs11 * cs11 + cs12 * cs12)
    stoneB.speed = Math.sqrt(cs21 * cs21 + cs22 * cs22)
    stoneA.direction = Math.atan2(cs12, cs11) / cpi + (a + 90)
    stoneB.direction = Math.atan2(cs21, cs22) / cpi + (a + 90)

    var aF = stoneA.futurePosition(1)
    var bF = stoneB.futurePosition(1)
    var dF = dsquare(bF[0], bF[1], aF[0], aF[1])
    var diffF = dF - stoneA.width * stoneA.width
    if (diffF < 0) {
        var anF = slope(bF[0], bF[1], aF[0], aF[1])
        stoneA.xC = stoneB.xC + stoneA.width * Math.cos(anF * cpi);
        stoneA.yC = stoneB.yC + stoneB.width * Math.sin(anF * cpi);
    }
}

function powerToSpeed(power) {
    return Math.max(Math.min(power / 27, 4), 2)
}

function powerToBar(power, index) {

}
