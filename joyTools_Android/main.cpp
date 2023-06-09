#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QVariant>
#include "CNetTools.h"
#include "CFileTools.h"


int main(int argc, char *argv[])
{
    qmlRegisterType<CFileTools>("CFileTools", 1, 0, "CFileTools");
    qmlRegisterType<CNetTools>("CNetTools",1,0,"CNetTools");

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QObject *rootObject = engine.rootObjects().at(0);
    QObject *handleObject = rootObject->findChild<QObject*>("handle");
    QObject *fileToolsObject = rootObject->findChild<QObject*>("fileTools");

    if(handleObject ==nullptr && fileToolsObject == nullptr)
    {
        qDebug() << " the handleObject or fileToolsObject is nullptr";
    }
    QObject::connect(fileToolsObject,SIGNAL(addControllerDate(QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant)),
                         handleObject,SLOT(addControllerDate(QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant,QVariant)));
    return app.exec();
}
