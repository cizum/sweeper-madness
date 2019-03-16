TEMPLATE = app

QT += qml quick

CONFIG += qtquickcompiler

HEADERS += \
    translator.h

SOURCES += main.cpp \
    translator.cpp

# Default rules for deployment.
include(deployment.pri)

RESOURCES += \
    res.qrc

# English
TRANSLATIONS += language/en.ts
# Français
TRANSLATIONS += language/fr.ts

DISTFILES +=
