#include "kcmaskprovider.h"

KCMaskProvider::KCMaskProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap)
{

}

QPixmap KCMaskProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    auto params = id.split("&");
    int imageWidth = params[0].toInt();
    int imageHeight = params[1].toInt();

    int maskX = params[2].toInt();
    int maskY = params[3].toInt();
    int maskWidth = params[4].toInt();
    int maskHeight = params[5].toInt();

    auto image = QImage(imageWidth, imageHeight, QImage::Format_ARGB32);
    image.fill(qRgba(0x00, 0x00, 0x00, 0x80));

    for(int i = maskX; i < maskX + maskWidth; i++) {
        for(int j = maskY; j < maskY + maskHeight; j++) {
            image.setPixel(i, j, qRgba(0, 0, 0, 0));
        }
    }

    return QPixmap::fromImage(image);
}
