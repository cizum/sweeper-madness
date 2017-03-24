#include "imagepix.h"

ImagePix::ImagePix()
{
    qImage = new QImage(1280,720,QImage::Format_ARGB32);
    qImage->fill(QColor(0,0,0,0));
}

void ImagePix::setPixel(unsigned int x, unsigned int y, int rgba){
    QRgb* px = (QRgb* )(qImage->scanLine(y) + x*4);
    *px = rgba;
}

void ImagePix::setPixel(unsigned int x, unsigned int y, unsigned int r, unsigned int g, unsigned int b, unsigned int a){
    QRgb* px = (QRgb* )(qImage->scanLine(y) + x*4);
    *px = QColor(r, g, b, a).rgba();
}

void ImagePix::clear(){
    qImage->fill(QColor(0,0,0,0));
}
