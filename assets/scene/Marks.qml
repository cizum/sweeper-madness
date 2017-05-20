import QtQuick 2.0

Item {
    id: root
    property int style: 0
    property string style_folder: "../styles/"

    Image {
        id: marks_image
        source: "image://provider/0"
        cache: false
        visible: root.style == 0 && version !== "mobile"
    }


    function add(x, y, a) {
        if (root.style == 0 && version !== "mobile") {
            marks_image.source = ""
            var ar = a * Math.PI / 180
            var cosar = Math.cos(ar)
            var sinar = Math.sin(ar)
            for (var i = - 4; i < 4; i++) {
                for (var j = - 1; j < 1; j++) {
                    var xp = Math.floor(x + i * cosar - j * sinar)
                    var yp = Math.floor(y + i * sinar + j * cosar)
                    if (xp >= 0 && xp < 1280 && yp >=0 && yp < 720)
                        imagePix.setPixel(xp, yp, 255, 255, 255, 30)
                }
            }
            marks_image.source = "image://provider/0"
        }
        else if (root.style == 1) {
            var component = Qt.createComponent(root.style_folder + "neon/MarkNeon.qml");
            component.createObject(root, {"x": x, "y": y, "rotation": a});
        }
    }

    function clear() {
        marks_image.source = ""
        imagePix.clear()
        marks_image.source = "image://provider/0"
    }
}
