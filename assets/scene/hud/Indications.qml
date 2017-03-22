import QtQuick 2.2

Text {
    id: root
    font.family: "PaintyPaint"
    font.pixelSize: 28
    property int phase: 0
    property var messages: ["",
                            "Select your position with UP and DOWN, then press SPACE",
                            "Press SPACE to validate your direction",
                            "Press SPACE to release your power",
                            "Press UP and DOWN to sweep !",
                            "Enjoy your dexterity",
                            ""]
    property var mobile_messages: ["",
                            "Select your position with UP and DOWN, then tap above here",
                            "Tap to validate your direction",
                            "Tap to release your power",
                            "Tap UP and DOWN to sweep !",
                            "Enjoy your dexterity",
                            ""]
    property bool mobile: version == "mobile"

    text: root.mobile ? root.mobile_messages[root.phase] : root.messages[root.phase]
}
