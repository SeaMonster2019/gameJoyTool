#ifndef CNETTOOLS_H
#define CNETTOOLS_H

#include <QObject>
#include <QTcpSocket>
#include <QDebug>

class CNetTools : public QTcpSocket
{
     Q_OBJECT
public:
    CNetTools(QObject *object = nullptr);
    Q_INVOKABLE void doConnect(const QString &address, const QString port, QIODeviceBase::OpenMode openMode = ReadWrite);
    Q_INVOKABLE void doDisconnect();
    Q_INVOKABLE void doSendDate(QString p_sDate);
    Q_INVOKABLE void operateKeys(bool p_pbIsPress,int p_nKeyValue);
    Q_INVOKABLE void operateMouseMove(int p_nAbsoluteValueX,int p_nAbsoluteValueY);

private:
    int  nWaiteFlag;

public slots:
    void onReadyConnect();
    void onReceiveDate();

};
#endif // CNETTOOLS_H
