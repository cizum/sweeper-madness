import QtQuick 2.2
import "../styles/classic"
import "../styles/neon"

Item {
    id:root
    height: 261
    width: 1181
    property int style: 0
    property int start_line: 210
    property int end_sweep_line: 920
    property int d_target: root.height - 40
    property int x_target: root.width - 20 - root.r_target
    property int y_target: root.height / 2
    property int r_target: root.d_target / 2

    SheetClassic{
        id: sheet_classic
        anchors.fill: parent
        start_line: root.start_line
        end_sweep_line: root.end_sweep_line
        d_target: root.d_target
        x_target: root.x_target
        y_target: root.y_target
        r_target: root.r_target
        visible: root.style == 0
    }

    SheetNeon{
        id: sheet_neon
        anchors.fill: parent
        start_line: root.start_line
        end_sweep_line: root.end_sweep_line
        d_target: root.d_target
        x_target: root.x_target
        y_target: root.y_target
        r_target: root.r_target
        visible: root.style == 1
    }
}


