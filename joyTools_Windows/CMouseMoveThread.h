#ifndef CMOUSEMOVETHREAD_H
#define CMOUSEMOVETHREAD_H
#include <QObject>
#include <QThread>
#include <QMutex>
#include <windows.h>


class CMouseMoveThread : public QThread
{
Q_OBJECT
public:
    static CMouseMoveThread* getInstance();
    void startRun();
    void stopRun();
    void setMoveDistance(const int p_nDx,const int p_nDy);
    void run();
    bool isRuning();

private:
    int m_nMoveDx;
    int m_nMoveDy;
    bool m_bRuning;
    QMutex m_mutex;
//单例模式
private:
    CMouseMoveThread(){};
    ~CMouseMoveThread(){};
    CMouseMoveThread(const CMouseMoveThread& t);
    CMouseMoveThread operator=(const CMouseMoveThread& t);
};

#endif // CMOUSEMOVETHREAD_H
