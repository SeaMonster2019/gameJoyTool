#include "CNetTools.h"

CNetTools::CNetTools(QObject *object)
{
    this->setParent(object);
    this->nWaiteFlag = 0;
    QObject::connect(this, &QTcpSocket::connected,this,[p_ObjectPtr = this](){
        if(p_ObjectPtr != nullptr)
        {
            QObject::connect(p_ObjectPtr,&QTcpSocket::readyRead,p_ObjectPtr,&CNetTools::onReadyConnect);
        }
    });

    QObject::connect(this, &QTcpSocket::disconnected,this,[p_ObjectPtr = this](){
        if(p_ObjectPtr != nullptr)
        {
            QObject::connect(p_ObjectPtr,&QTcpSocket::readyRead,p_ObjectPtr,&CNetTools::onReadyConnect);
        }
   });
}

void CNetTools::doConnect(const QString &address, const QString port, QIODeviceBase::OpenMode openMode)
{
    this->connectToHost(address,port.toUInt(),openMode);
}

void CNetTools::doDisconnect()
{
    if(this->state() == QAbstractSocket::ConnectedState)
    {
        this->disconnectFromHost();
    }
}

void CNetTools::onReadyConnect()
{
    if(nWaiteFlag == 0)
    {
        QByteArray byteArray = this->readAll();
        if(byteArray == "AreU")
        {
            this->write("Yes");
            nWaiteFlag = 1;
        }
    }else if(nWaiteFlag == 1)
    {
        QByteArray byteArray = this->readAll();
        if(byteArray == "Ok")
        {
            QObject::connect(this, &QTcpSocket::readyRead,this,&CNetTools::onReceiveDate);
            qDebug() << "Connect success.\n";
            nWaiteFlag = 2;
        }
    }else
    {
        nWaiteFlag = 0;
    }
}

void CNetTools::doSendDate(QString p_sDate)
{
    this->write(p_sDate.toUtf8());
    qDebug() << p_sDate;
}

void CNetTools::operateKeys(bool p_pbIsPress,int p_nKeyValue){
    if(p_pbIsPress)
    {
        QString date = "Kp_" + QString(char(p_nKeyValue)).toUtf8();
        this->write(date.toUtf8());
        qDebug() << date;

    }else
    {

        QString date = "Kr_" + QString(char(p_nKeyValue)).toUtf8();
        this->write(date.toUtf8());
        qDebug() << date;
    }
}

void CNetTools::operateMouseMove(int p_nAbsoluteValueX,int p_nAbsoluteValueY)
{
    QString sX = QString::number(p_nAbsoluteValueX);
    QString sY = QString::number(p_nAbsoluteValueY);
    QString date = "Mm_" + QString::number(sX.length()) + sX + QString::number(sY.length()) + sY;
    this->write(date.toUtf8());
    qDebug() << date;
}

void CNetTools::onReceiveDate()
{
    ;
}
