#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/imagepix.h"
#include "src/imageprovider.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    ImageProvider* imageProvider = new ImageProvider();
    ImagePix* imagePix = new ImagePix();
    QString version = "desktop";
    #ifdef MOBILE
    version = "mobile";
    #endif

    imageProvider->qImage = imagePix->qImage;

    engine.addImageProvider(QLatin1String("provider"), imageProvider);
    engine.rootContext()->setContextProperty("imagePix",imagePix);
    engine.rootContext()->setContextProperty("version", version);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
