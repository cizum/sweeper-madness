#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "translator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/assets/Style.qml")), "krus.morten.style", 1, 0, "Style");

    Translator translator(&engine);
    engine.rootContext()->setContextProperty("translator", static_cast<QObject*>(&translator));

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
