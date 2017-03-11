TEMPLATE = app

QT += qml quick

SOURCES += main.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    assets/scene/hud/PowerBar.qml \
    assets/scene/hud/Score.qml \
    assets/scene/hud/TextNum.qml \
    assets/scene/hud/Winner.qml \
    assets/scene/Controls.qml \
    assets/scene/Hud.qml \
    assets/scene/Launcher.qml \
    assets/scene/Piste.qml \
    assets/scene/Sweeper.qml \
    assets/Menu.qml \
    assets/Scene.qml \
    main.qml \
    assets/menu/Button.qml \
    assets/menu/Title.qml \
    assets/scene/hud/DirectionBar.qml \
    assets/scene/hud/Indications.qml \
    assets/scene/Character.qml \
    assets/scene/Stone.qml \
    assets/scene/Stones.qml \
    assets/scene/Inputs.qml \
    assets/scene/Marks.qml \
    assets/scene/Mark.qml \
    assets/tools.js \
    assets/scene/SoundManager.qml \
    assets/menu/ChoiceList.qml \
    assets/scene/Madi.qml

