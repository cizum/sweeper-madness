TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    src/imagepix.cpp \
    src/imageprovider.cpp

android {
    DEFINES += MOBILE
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

RESOURCES += \
    res.qrc

HEADERS += \
    src/imagepix.h \
    src/imageprovider.h
