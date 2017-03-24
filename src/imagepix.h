#ifndef IMAGEPIX_H
#define IMAGEPIX_H

#include <QObject>
#include <QImage>
#include <QColor>
#include <QDebug>


class ImagePix: public QObject
{
    Q_OBJECT
public:
    ImagePix();

    Q_INVOKABLE void setPixel(unsigned int x, unsigned int y, int rgba);
    Q_INVOKABLE void setPixel(unsigned int x, unsigned int y, unsigned int r, unsigned int g, unsigned int b, unsigned int a);
    Q_INVOKABLE void clear();

    QImage* qImage;
};

#endif // IMAGEPIX_H
