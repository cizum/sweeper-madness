import QtQuick 2.2

Item{
    id: root
    anchors.fill: parent
    property int count: 16
    property int current_n: 0
    property var current: root.children[current_n]

    Repeater{
        model: root.count
        Stone{
            team: index % 2 == 0 ? 1 : 0
        }
    }
    function initialize(){
        var t0 = 0
        var t1 = 0
        for (var p = 0; p < root.count; p++){
            var team = root.children[p].team
            var t = 0;
            if (team === 0){
                t = t0
                t0 ++
            }
            else{
                t = t1
                t1 ++
            }
            var w = root.children[p].width
            root.children[p].speed = 0
            root.children[p].angle = 0
            root.children[p].xC = piste.x + 10 + t * (w + 10)
            root.children[p].yC = team === 1 ? piste.y - 50 : piste.y + piste.height + 50
        }
    }
    function update(){
        for (var p = 0; p < root.count; p++){
            root.children[p].update()
        }
    }

    function immobile(){
        for (var p = 0; p < root.count; p++){
            if (root.children[p].speed > 0 )
                return false
        }
        return true
    }

}
