#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFileInfo>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    //for reading and writing? JSON file
    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));
    qputenv("QML_XHR_ALLOW_FILE_WRITE", QByteArray("1"));

    QString projectFolder = "/FlashCards";
    QString path = QFileInfo(".").absolutePath();// + projectFolder;
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);
    engine.load(url);

    engine.rootContext()->setContextProperty("path", QVariant::fromValue(&path));
    engine.setOfflineStoragePath(projectFolder);

    return app.exec();
}
