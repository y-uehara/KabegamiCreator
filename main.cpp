#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QLocale>
#include <QTranslator>

#include "kcimage.h"
#include "kcimageexporter.h"
#include "kcimageprovider.h"
#include "kcmaskprovider.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    app.setOrganizationName("sample");
    app.setOrganizationDomain("example.org");

    KCImage kcImage;
    KCImageExporter kcImageExporter(&kcImage);
    auto kcImageProvider = new KCImageProvider(&kcImage);
    auto kcMaskProvider = new KCMaskProvider();

//    QTranslator translator;
//    const QStringList uiLanguages = QLocale::system().uiLanguages();
//    for (const QString &locale : uiLanguages) {
//        const QString baseName = "KabegamiCreator_" + QLocale(locale).name();
//        if (translator.load(":/i18n/" + baseName)) {
//            app.installTranslator(&translator);
//            break;
//        }
//    }

    QQmlApplicationEngine engine;

    engine.addImageProvider(QLatin1String("kcImageProvider"), kcImageProvider);
    engine.addImageProvider(QLatin1String("kcMaskProvider"), kcMaskProvider);
    engine.rootContext()->setContextProperty("kcImageExporter", &kcImageExporter);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
