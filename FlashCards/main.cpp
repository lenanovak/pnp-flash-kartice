#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFileInfo>
#include <QStandardPaths>
#include "fileio.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    FileIO fileIO;

    //for reading JSON file
    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));
    //qputenv("QML_XHR_ALLOW_FILE_WRITE", QByteArray("1"));

    //QString projectFolder = "/FlashCards";
    //QString path = QFileInfo(".").absolutePath();// + projectFolder;
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);
    engine.load(url);

    //engine.rootContext()->setContextProperty("path", QVariant::fromValue(&path));
    //engine.rootContext()->setContextProperty("path", QString(QCoreApplication::applicationDirPath()));
    //qDebug(qUtf8Printable(path));
    //engine.setOfflineStoragePath(projectFolder);

    engine.rootContext()->setContextProperty("fileio", &fileIO);

    QUrl appPath(QString("%1").arg(app.applicationDirPath()));
    engine.rootContext()->setContextProperty("appPath", appPath);
    QUrl desktopPath;
    const QStringList desktopsLocation = QStandardPaths::standardLocations(QStandardPaths::DesktopLocation);
    if (desktopsLocation.isEmpty())
        desktopPath = appPath.resolved(QUrl("/"));
    else
        desktopPath = QString("%1").arg(desktopsLocation.first());
    engine.rootContext()->setContextProperty("desktopPath", desktopPath);

    return app.exec();
}
