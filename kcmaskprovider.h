#ifndef KCMASKPROVIDER_H
#define KCMASKPROVIDER_H

#include <QQuickImageProvider>
#include <QPixmap>

class KCMaskProvider : public QQuickImageProvider
{
public:
    KCMaskProvider();

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) Q_DECL_OVERRIDE;
};

#endif // KCMASKPROVIDER_H
