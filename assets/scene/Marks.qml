import QtQuick 2.0

Item {
    id: root

    function add(x, y, a) {
        var component = Qt.createComponent("Mark.qml");
        component.createObject(root, {"x": x, "y": y, "rotation": a});
    }

    function clear() {
        var n = root.children.length
        for (var m = n - 1; m >= 0; m--){
            root.children[m].destroy()
        }
    }
}
