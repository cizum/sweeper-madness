TEMPLATE = app

QT += qml quick

SOURCES += main.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    main.qml \
    assets/Hud/Score.qml \
    assets/Hud/TextNum.qml \
    assets/Menu/ButtonMenu.qml \
    assets/Sons/Sons.qml \
    assets/Controls.qml \
    assets/Hud.qml \
    assets/Menu.qml \
    assets/Scene.qml \
    assets/WindowBase.qml \
    assets/Scene/Piste.qml \
    assets/Hud/PowerBar.qml \
    assets/Hud/AngleBar.qml \
    assets/Scene/Sweeper.qml \
    assets/Scene/Pierre.qml \
    assets/Scene/Pierres.qml \
    assets/Scene/Launcher.qml \
    assets/Hud/Winner.qml \
    assets/Hud/KeyDisplay.qml
