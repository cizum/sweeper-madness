import QtQuick 2.0

Item {
    id: root
    property int style: 0
    property string style_folder: "../styles/"
    property string mark: root.style == 1 ? "neon/MarkNeon.qml" : "classic/MarkClassic.qml"

    onStyleChanged: root.clear()

    function add(x, y, a) {
        var component = Qt.createComponent(root.style_folder + root.mark);
        component.createObject(root, {"x": x, "y": y, "rotation": a});
    }

    function clear() {
        var n = root.children.length
        for (var m = n - 1; m >= 0; m--) {
            root.children[m].destroy()
        }
    }
}
