#include <QDebug>

#include "kcimageexporter.h"

KCImageExporter::KCImageExporter(QObject *parent) : QObject(parent)
{

}

KCImageExporter::KCImageExporter(KCImage *image) :
    QObject(), m_image(image)
{

}


bool KCImageExporter::exportFile(const QUrl &url, int clipX, int clipY, int clipWidth, int clipHeight)
{
    return m_image->saveFile(url.toLocalFile(), clipX, clipY, clipWidth, clipHeight);
}
