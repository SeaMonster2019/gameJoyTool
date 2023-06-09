#include "joytools.h"
#include "ui_joytools.h"

void CScoketContainer::do_TcpConnectJudge()
{
    QByteArray byteArray = this->socket->readAll();
    if(byteArray == "Yes")
    {
        this->socket->write("Ok");
        QObject::disconnect(this->socket, &QTcpSocket::readyRead, this, &CScoketContainer::do_TcpConnectJudge);
        QObject::connect(this->socket,&QTcpSocket::readyRead,this,&CScoketContainer::do_TcpReadData);
        this->bIsConnect = true;
        emit this->reallyConnect(this->socket->peerAddress().toString().mid(7)+":" +QString::number(this->socket->peerPort()));
    }
}

void CScoketContainer::do_TcpReadData()
{
    QByteArray byteArray = this->socket->readAll();
    int nLength = byteArray.length();
    int i = 0;
    for(int flag = 0;i<nLength;++i)
    {
        switch(flag)
        {
        case 0:
        {
            if(byteArray[i] == 'K')
            {
                flag = 10;
            }
            if(byteArray[i] == 'M')
            {
                flag = 20;
            }
            break;
        }
        case 10:
        {
            if(byteArray[i] == 'p')
            {
                flag = 101;
            }
            else if(byteArray[i] == 'r')
            {
                flag = 111;
            }
            break;
        }
        case 101:
        {
            if(byteArray[i] == '_')
            {
                flag = 102;
            }
            break;
        }
        case 111:
        {
            if(byteArray[i] == '_')
            {
                flag = 112;
            }
            break;
        }
        case 102:
        {
            keybd_event(byteArray[i],0,0,0);
            flag = 0;
            break;
        }
        case 112:
        {
            keybd_event(byteArray[i],0,2,0);
            flag = 0;
            break;
        }
        case 20:
        {
            if(byteArray[i] == 'm')
            {
                flag = 201;
            }
            break;
        }
        case 201:
        {
            if(byteArray[i] == '_')
            {
                flag = 202;
            }
            break;
        }
        case 202:
        {
            int nNumberX = 0;
            int nNumberY = 0;
            int nX = 0;
            int nY = 0;

            nNumberX = QString(byteArray[i]).toInt();
            if(i + nNumberX + 2 > nLength )
            {
                flag = 0;
                break;
            }

            nNumberY = QString(byteArray[i + nNumberX + 1]).toInt();
            if(i + nNumberX + nNumberY +  2 > nLength )
            {
                flag = 0;
                break;
            }

            nX = QString(byteArray.sliced(i + 1,nNumberX)).toInt();
            nY = QString(byteArray.sliced(i + nNumberX + 2,nNumberY)).toInt();

            CMouseMoveThread* mouseMoveThread = CMouseMoveThread::getInstance(); 
            if( nX != 0 || nY != 0)
            {
                if(mouseMoveThread->isRuning())
                {
                    mouseMoveThread->setMoveDistance(nX,nY);
                }
                else
                {
                    mouseMoveThread->setMoveDistance(nX,nY);
                    mouseMoveThread->startRun();
                }
            }
            else if(mouseMoveThread->isRuning())
            {
                mouseMoveThread->stopRun();
            }

            i = i + nNumberX + nNumberY + 1;
            flag = 0;
            break;
        }
        default:
        {
            flag = 0;
            break;
        }
        }
    }

}

void CScoketContainer::do_disconnect()
{
    if(this->bIsConnect)
    {
        emit this->disconnected(this->socket->peerAddress().toString().mid(7)+":" +QString::number(this->socket->peerPort()));
    }
    this->socket->disconnect();
    this->disconnect();
    this->bIsConnect = false;
}

int CSocketContainerList::getConnectionlessScoketContainer()
{
    for(int i = 0;i < this->list.size();i++)
    {
        if(this->list.at(i)->socket->state() == QTcpSocket::UnconnectedState && this->list.at(i)->bIsConnect == false)
        {
            return i;
        }
    }
    return -1;
}

int CSocketContainerList::getConnectStatus(const QTcpSocket *const p_socketPtr)
{
    for(int i = 0;i < this->list.size();i++)
    {
        if(p_socketPtr == this->list.at(i)->socket)
        {
            if(this->list.at(i)->bIsConnect)
            {
                return CSocketContainerList::CONNECT;
            }
            else
            {
                return CSocketContainerList::DISCONNECT;
            }
        }
    }
    return CSocketContainerList::INVALID_PTR;
}

void CSocketContainerList::releaseSocket(const QTcpSocket *const p_socketPtr)
{
    for(int i = 0;i < this->list.size();i++)
    {
        if(p_socketPtr == this->list.at(i)->socket)
        {
            this->list.at(i)->socket->disconnect();
            delete *(this->list.begin()+i);
            this->list.erase(this->list.begin()+i);
            break;
        }
    }
}

void CSocketContainerList::releaseAllSocket()
{
    for(;0 < this->list.size();)
    {
        this->list.at(0)->socket->disconnect();
        delete this->list.at(0);
        this->list.erase(this->list.begin());
    }
}

joyTools::joyTools(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::joyTools)
{
    ui->setupUi(this);
     this->m_mouseMoveThread = CMouseMoveThread::getInstance();
    this->m_mouseMoveThread->setParent(this);

}

joyTools::~joyTools()
{
    delete ui;
}

void joyTools::on_myButton_clicked()
{
    if(this->myServer == nullptr)
    {
        this->myServer = new QTcpServer(this);
        connect(this->myServer,&QTcpServer::newConnection,this,&joyTools::serverNewConnect);
        this->myServer->listen(QHostAddress::Any,16666);
        ui->textEdit->insertPlainText(QTime::currentTime().toString("hh:mm:ss") +": 服务器启动，开始监听\n");
    }
}

void joyTools::on_myButton_2_clicked()
{
    if(this->myServer != nullptr)
    {
        ui->textEdit->insertPlainText(QTime::currentTime().toString("hh:mm:ss") +": 服务器关闭，取消监听\n");
        this->socketContainerList.releaseAllSocket();
        this->myServer->close();
        this->myServer = nullptr;
    }
}

void joyTools::serverNewConnect()
{

    CScoketContainer *scoketContainer;

    int number = socketContainerList.getConnectionlessScoketContainer();
    if(number == -1)
    {
       scoketContainer  = new CScoketContainer;
       this->socketContainerList.list.push_back(scoketContainer);
    }
    else
    {
        scoketContainer = socketContainerList.list.at(number);
    }

    scoketContainer->socket = myServer->nextPendingConnection();//分配套接字
    //设置连接暗号
    scoketContainer ->bIsConnect = false;
    scoketContainer->socket->write("AreU");//向客户端确认信息
    QObject::connect(scoketContainer->socket, &QTcpSocket::readyRead,scoketContainer, &CScoketContainer::do_TcpConnectJudge);
    QObject::connect(scoketContainer, &CScoketContainer::reallyConnect, this, &joyTools::do_TcpReallyConnect);
    QObject::connect(scoketContainer, &CScoketContainer::disconnected, this, &joyTools::do_TcpDisconnected);
    QObject::connect(scoketContainer->socket,&QTcpSocket::disconnected,scoketContainer,&CScoketContainer::do_disconnect);
    QTimer::singleShot (10000, this, [&](){    //如果到时间时并没有回应，断开连接
        if(this->socketContainerList.getConnectStatus(scoketContainer->socket) == CSocketContainerList::DISCONNECT)
        {
            scoketContainer->socket->disconnectFromHost();
            scoketContainer->socket->disconnect();
            this->socketContainerList.releaseSocket(scoketContainer->socket);
        }
    });

}

void joyTools::do_TcpReallyConnect(QString p_sIp)
{
    ui->textEdit->insertPlainText(QTime::currentTime().toString("hh:mm:ss") + ": 手机端Ip " + p_sIp + " 连接成功\n");
    qDebug() << "size" << this->socketContainerList.list.size();
}

void joyTools::do_TcpDisconnected(QString p_sIp)
{
    ui->textEdit->insertPlainText(QTime::currentTime().toString("hh:mm:ss") + ": 手机端Ip " + p_sIp + " 连接断开\n");

}








