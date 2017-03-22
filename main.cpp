#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QString version = "desktop";
    #ifdef MOBILE
    version = "mobile";
    #endif

    engine.rootContext()->setContextProperty("version", version);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
