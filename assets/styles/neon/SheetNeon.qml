import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
    id: root
    height: 261
    width: 1181
    property int start_line: 210
    property int end_sweep_line: 920
    property int d_target: root.height - 40
    property int x_target: root.width - 20 - root.r_target
    property int y_target: root.height / 2
    property int r_target: root.d_target / 2
    property string lines_color: "#ffffff"
    property string inside_lines_color: "#303030"

    Rectangle {
        id: middle_line
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 3
        color: root.inside_lines_color
        visible: false
    }

    Glow {
        anchors.fill: middle_line
        source: middle_line
        color: root.inside_lines_color
        samples: 17
        spread: 0.1
    }

    Rectangle {
        id: start_line_rec
        anchors.verticalCenter: parent.verticalCenter
        x: root.start_line
        width: 2
        height: parent.height - 4
        color: root.lines_color
        visible: false
    }

    Glow {
        anchors.fill: start_line_rec
        source: start_line_rec
        color: root.lines_color
        samples: 17
        spread: 0.1
    }

    Rectangle {
        id: end_sweep_line_rec
        anchors.verticalCenter: parent.verticalCenter
        x: root.end_sweep_line
        width: 1
        height: parent.height
        color: root.inside_lines_color
        visible: false
    }

    Glow {
        anchors.fill: end_sweep_line_rec
        source: end_sweep_line_rec
        color: root.inside_lines_color
        samples: 17
        spread: 0.1
    }

    Rectangle {
        id: middle_target
        anchors.verticalCenter: parent.verticalCenter
        x: target.x + target.width / 2 - 1
        width: 3
        height: parent.height
        color: root.inside_lines_color
        visible: false
    }

    Glow {
        anchors.fill: middle_target
        source: middle_target
        color: root.inside_lines_color
        samples: 17
        spread: 0.1
    }

    Rectangle {
        id: target
        x: root.x_target - root.r_target
        anchors.verticalCenter: parent.verticalCenter
        height: root.d_target
        width: root.d_target
        radius: width / 2
        border.width: 45
        color: "transparent"
        border.color: "transparent"
        visible: false
        Rectangle {
            anchors.centerIn: parent
            height: root.d_target -  2 * parent.border.width
            width: root.d_target - 2 * parent.border.width
            radius: width / 2
            border.width: 1
            color: "transparent"
            border.color: "#0040ff"
        }
        Rectangle {
            anchors.centerIn: parent
            height: root.d_target
            width: root.d_target
            radius: width / 2
            border.width: 1
            color: "transparent"
            border.color: "#0040ff"
        }
    }

    Glow {
        anchors.fill: target
        source: target
        color: "#0040ff"
        samples: 17
        spread: 0.3
    }

    Rectangle {
        id: core_target
        anchors.centerIn: target
        height: target.width/3
        width: target.height/3
        radius: width/2
        border.width: 25
        color: "transparent"
        border.color: "transparent"
        visible: false
        Rectangle {
            anchors.centerIn: parent
            height: core_target.width -  2 * parent.border.width
            width: core_target.height - 2 * parent.border.width
            radius: width / 2
            border.width: 1
            color: "transparent"
            border.color: "#ff0000"
        }
        Rectangle {
            anchors.centerIn: parent
            height: core_target.width
            width: core_target.height
            radius: width / 2
            border.width: 1
            color: "transparent"
            border.color: "#ff0000"
        }
    }

    Glow {
        anchors.fill: core_target
        source: core_target
        color: "#ff0000"
        samples: 17
        spread: 0.3
    }

    Rectangle {
        id: border_sheet
        anchors.fill: parent
        color: "transparent"
        border.color: root.lines_color
        border.width: 2
        visible: false
    }

    Glow {
        anchors.fill: border_sheet
        source: border_sheet
        color: root.lines_color
        samples: 17
        spread: 0.1
    }
}
