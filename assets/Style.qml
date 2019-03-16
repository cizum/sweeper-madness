pragma Singleton
import QtQuick 2.9

QtObject {
    id: root

    readonly property int teamHome: 0
    readonly property int teamVisitor: 1

    readonly property int specieHuman: 0
    readonly property int specieAlien: 1

    readonly property int sexFemale: 0
    readonly property int sexMale: 1

    readonly property int hairCutBald: 0
    readonly property int hairCutLong: 1
    readonly property int hairCutPonyTail: 2
    readonly property int hairCutShort: 3

    /** Background */
    property color backgroundColor: "#ddddee"
    property color backgroundBorderColor: "#50000000"
    property color backgroundShadowColor: "#000000"

    /** Menu */
    property color redColor: "#901515"
    property color blueColor: "#151590"
    property color greenColor: "#159015"
    property color titleShadowColor: "#80252525"

    /** Players */
    property color yellowPlayerColor: "#ffff55"
    property color redPlayerColor: "#cc2020"
    property color neutralPlayerColor: "#55ffff"
    property color playerBorderColor: "#101010"
    property color playerBroomColor: "#808090"
    property color playerBroomFrontColor: "#505050"
    property color playerBroomBrushColor: "#202020"
    property color playerFootColor: "#dddddd"

    /** Buttons */
    property color buttonBackgroundColor: "#ddddee"
    property color buttonTextColor: "#505050"
    property color buttonTextHoverColor: "#cccccc"
    property color buttonTextDownColor: "#aaaaaa"
    property color buttonBorderColor: "#eeeeff"
    property color buttonBorderSelectedColor: "#ff0000"
    property color buttonShadowColor: "#80151515"
    property color buttonFocusedBorderColor: "#ffffff"
    property color buttonIconDownColor: "#707070"
    property color spaceButtonMinColor: "#00eeeeff"
    property color spaceButtonMaxColor: "#b0eeeeff"
    property color spaceButtonDownColor: "#b0eeeeff"
    property color helpButtonSelectedColor: "#ff2020"
    property color choiceListColor: "#8989aa"

    /** DirectionPowerBar */
    property color directionBarColor: "#a0353535"
    property color directionBarBorderColor: "#ffffff"
    property color powerBarColor: "#ffffff"

    /** FuturePath */
    property color futurePathColor: "#50aaaaaa"
    property color futurePathBorderColor: "#aa101010"

    /** Score */
    property color endColor: "#303030"

    /** Stone */
    property color stoneColor: "#aaaaaa"
    property color stoneBorderColor: "#101010"
    property color stoneCenterBorderColor: "#aaaaee"
    property color stoneHandleBorderColor: "#303030"

    /** Winner */
    property color winnerTextColor: "#ffffff"
    property color winnerShadowColor: "#d0252525"

    /** Sheet */
    property color sheetColor: "#dddaee"
    property color sheetBorderColor: "#50505050"
    property color lineColor: "#cccccc"
    property color startLineColor: "#50505080"

    function teamColor(team) {
        switch(team) {
        case 0:
            return yellowPlayerColor
        case 1:
            return redPlayerColor
        case 2:
            return "white"
        default:
            return neutralPlayerColor
        }
    }

    function hairColor() {
        var r = Math.random()
        if (r < 0.30)
            return "#202020"
        else if (r < 0.50)
            return "#e0de24"
        else if (r < 0.80)
            return "#604035"
        else
            return "#bd5f10"
    }

    function hairCut(sex) {
        if (sex === root.sexFemale) {
            if (Math.random() < 0.5) {
                return root.hairCutPonyTail
            } else {
                return root.hairCutShort
            }
        } else {
            if (Math.random() < 0.95) {
                return root.hairCutShort
            } else {
                return root.hairCutBald
            }
        }
    }

    function specie() {
        if (Math.random() < 0.01)
            return root.specieAlien
        else
            return root.specieHuman
    }

    function sex() {
        if (Math.random() < 0.5)
            return root.sexFemale
        else
            return root.sexMale
    }

    function skinColor(specie) {
        if (specie === root.specieAlien)
            return "#108a10"

        var r = Math.random()
        if (r < 0.5) {
            r = 0.25 + Math.random() * 0.65
            return Qt.rgba(r, r * 0.8, r * 0.6, 1.0)
        } else {
            r = 0.7 + Math.random() * 0.2
            return Qt.rgba(r, r * 0.8, r * 0.6, 1.0)
        }
    }

    function targetInColor(mode) {
        switch (mode) {
        case 0:
            return root.blueColor
        case 1:
            return root.redColor
        case 2:
            return root.greenColor
        case 3:
        default:
            return root.blueColor
        }
    }

    function targetExColor(mode) {
        switch (mode) {
        case 0:
            return root.redColor
        case 1:
            return root.blueColor
        case 2:
            return root.blueColor
        case 3:
        default:
            return root.greenColor
        }
    }

    property bool darkMode: false

    function switchMode() {
        darkMode = !darkMode
    }

    property StateGroup stateGroup: StateGroup {
        states: [
            State {
                when: root.darkMode
                name: "DARK"
                PropertyChanges {
                    target: root
                    /** Background */
                    backgroundColor: "#151515"
                    backgroundBorderColor: "#50000000"
                    backgroundShadowColor: "#000000"

                    /** Menu */
                    redColor: "#b04040"
                    blueColor: "#4040b0"
                    greenColor: "#40b040"
                    titleShadowColor: "#80020202"

                    /** Players */
                    yellowPlayerColor: "#ffff55"
                    redPlayerColor: "#cc2020"
                    neutralPlayerColor: "#55ffff"
                    playerBorderColor: "#656565"
                    playerBroomColor: "#808090"
                    playerBroomFrontColor: "#505050"
                    playerBroomBrushColor: "#202020"
                    playerFootColor: "#dddddd"

                    /** Buttons */
                    buttonBackgroundColor: "#151515"
                    buttonTextColor: "#c5c5c5"
                    buttonTextHoverColor: "#d0d0d0"
                    buttonTextDownColor: "#d0d0d0"
                    buttonBorderColor: "#606060"
                    buttonBorderSelectedColor: "#ff0000"
                    buttonShadowColor: "#90020202"
                    buttonFocusedBorderColor: "#ffffff"
                    buttonIconDownColor: "#d0d0d0"
                    spaceButtonMinColor: "#00050505"
                    spaceButtonMaxColor: "#b0050505"
                    spaceButtonDownColor: "#b0000000"
                    helpButtonSelectedColor: "#ff2020"
                    choiceListColor: "#c0c0c0"

                    /** DirectionBar */
                    directionBarColor: "#a0353535"
                    directionBarBorderColor: "#ffffff"
                    powerBarColor: "#ffffff"

                    /** FuturePath */
                    futurePathColor: "#50000000"
                    futurePathBorderColor: "#b0ffffff"

                    /** Score */
                    endColor: "#c5c5c5"

                    /** Stone */
                    stoneColor: "#aaaaaa"
                    stoneBorderColor: "#656565"
                    stoneCenterBorderColor: "#aaaaee"
                    stoneHandleBorderColor: "#303030"

                    /** Winner */
                    winnerTextColor: "#ffffff"
                    winnerShadowColor: "#d0252525"

                    /** Sheet */
                    sheetColor: "#171719"
                    sheetBorderColor: "#50707070"
                    lineColor: "#303030"
                    startLineColor: "#80707090"
                }
            }
        ]
    }
}
