#include <QDebug>

#include "kcimage.h"

KCImage::KCImage() :
    m_originalImage(QImage()),
    m_image(QImage()),
    m_brightness(100)
{
}

KCImage::~KCImage()
{
}

void KCImage::generateImage()
{
    m_image = QImage(m_originalImage.size(), QImage::Format_RGB32);

    // adjust brightness
    double factor = (double)m_brightness / 100.0;

    for(int i = 0; i < m_image.width(); i++) {
        for(int j = 0; j < m_image.height(); j++) {
            QRgb rgb = m_originalImage.pixel(i, j);
            double alpha = qAlpha(rgb) / 255.0;
            double background = 1 - alpha;
            rgb = qRgb((0xff * background + qRed(rgb) * alpha) * factor,
                       (0xff * background + qGreen(rgb) * alpha) * factor,
                       (0xff * background + qBlue(rgb) * alpha) * factor);
            m_image.setPixel(i, j, rgb);
        }
    }
}


QPixmap KCImage::getPixmap(QSize *size, QString filePath, int brightness)
{
    QString fileName = QUrl(filePath).toLocalFile();

    if(fileName != m_fileName) {
        loadFile(fileName);
        m_brightness = 100;
    }

    m_brightness = brightness;

    generateImage();

    *size = QSize(m_image.width(), m_image.height());
    return QPixmap::fromImage(m_image);
}

void KCImage::loadFile(QString fileName)
{
    m_originalImage = QImage(fileName);
    m_fileName = fileName;
}

bool KCImage::saveFile(QString fileName, int clipX, int clipY, int clipWidth, int clipHeight)
{
    if(m_image.isNull()) {
        return false;
    }
    QImage exportImage = m_image.copy(clipX, clipY, clipWidth, clipHeight);
    return exportImage.save(fileName);
}
