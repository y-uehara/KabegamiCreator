#include "kcimageprovider.h"

#include <QDebug>

KCImageProvider::KCImageProvider(KCImage *image) :
    QQuickImageProvider(QQuickImageProvider::Pixmap),
    m_image(image)
{
}

KCImageProvider::~KCImageProvider()
{
}

QPixmap KCImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(requestedSize);

    auto params = id.split("&");
    QString fileName = params[0];
    int brightness = params[1].toInt();

    return m_image->getPixmap(size, fileName, brightness);
}
