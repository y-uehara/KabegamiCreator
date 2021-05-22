#ifndef KCIMAGE_H
#define KCIMAGE_H

#include <QImage>
#include <QPixmap>
#include <QString>
#include <QUrl>

class KCImage
{
public:
    KCImage();
    ~KCImage();

    QPixmap getPixmap(QSize *size, QString fileName, int brightness);
    void loadFile(QString fileName);
    bool saveFile(QString fileName, int clipX, int clipY, int clipWidth, int clipHeight);

private:
    void generateImage();

    QImage  m_originalImage;
    QImage  m_image;
    QString m_fileName;
    int     m_brightness;
};

#endif // KCIMAGE_H
