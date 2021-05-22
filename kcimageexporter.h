#ifndef KCIMAGEEXPORTER_H
#define KCIMAGEEXPORTER_H

#include <QObject>
#include "kcimage.h"

class KCImageExporter : public QObject
{
    Q_OBJECT
public:
    explicit KCImageExporter(QObject *parent = nullptr);
    KCImageExporter(KCImage *image);

    Q_INVOKABLE bool exportFile(const QUrl &url, int clipX, int clipY, int clipWidth, int clipHeight);

signals:

private:
    KCImage *m_image;
};

#endif // KCIMAGEEXPORTER_H
