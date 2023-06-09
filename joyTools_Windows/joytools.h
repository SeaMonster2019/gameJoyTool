#ifndef JOYTOOLS_H
#define JOYTOOLS_H

#include <windows.h>
#include <QMainWindow>
#include <QObject>
#include <QTime>
#include <QTimer>
#include <QMessageBox>
#include <QTcpServer>
#include <QTcpSocket>
#include <QByteArray>
#include <QVector>
#include "CMouseMoveThread.h"

//#include "KeyValue.h"
//using namespace VK;

QT_BEGIN_NAMESPACE
namespace Ui
{
    class joyTools;
    class CScoketContainer;
    class CSocketContainerList;
}
QT_END_NAMESPACE

class CScoketContainer:public QObject
{
Q_OBJECT
public:
    CScoketContainer(){}
    ~CScoketContainer(){ if(socket != nullptr){ delete socket;socket = nullptr;}}
    QTcpSocket *socket;
    bool bIsConnect;

signals:
    void reallyConnect(QString p_sIp);
    void disconnected(QString p_sIp);

public slots:
    void do_TcpConnectJudge();
    void do_TcpReadData();
    void do_disconnect();
};

class CSocketContainerList: public QObject
{
Q_OBJECT
public:
    enum connectStatus
    {
        DISCONNECT = 0,
        CONNECT = 1,
        INVALID_PTR = 2
    };
public:
    QList<CScoketContainer*> list;
    int getConnectionlessScoketContainer();
    int getConnectStatus(const QTcpSocket *const p_socketPtr);
    void releaseSocket(const QTcpSocket *const p_socketPtr);
    void releaseAllSocket();
    ~CSocketContainerList()
    {
        for(int i = 0;i<list.size();i++)
        {
            delete list.at(0);
        }
    }

};

class joyTools : public QMainWindow
{
    Q_OBJECT
public:
    joyTools(QWidget *parent = nullptr);
    ~joyTools();

private:
    Ui::joyTools *ui;
    CMouseMoveThread *m_mouseMoveThread;

public:
    QTcpServer *myServer;
    CSocketContainerList socketContainerList;

public slots:
    void on_myButton_clicked();
    void on_myButton_2_clicked();
    void serverNewConnect();
    void do_TcpReallyConnect(QString p_sIp);
    void do_TcpDisconnected(QString p_sIp);

};

#endif // JOYTOOLS_H
