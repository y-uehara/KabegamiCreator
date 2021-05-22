#ifndef KCIMAGEPROVIDER_H
#define KCIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QPixmap>

#include "kcimage.h"

class KCImageProvider : public QQuickImageProvider
{
public:
    KCImageProvider(KCImage *image);
    ~KCImageProvider();

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) Q_DECL_OVERRIDE;

private:
    KCImage *m_image;
    QString m_fileName;

};

#endif // KCIMAGEPROVIDER_H
