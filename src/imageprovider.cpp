#include "imageprovider.h"

ImageProvider::ImageProvider():
    QQuickImageProvider(QQuickImageProvider::Image)
{
    qImage = new QImage(975, 710, QImage::Format_ARGB32);
    qImage->fill(QColor(0, 0, 0 ,0));
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(id);
    Q_UNUSED(size);
    Q_UNUSED(requestedSize);
    return *qImage;
}
