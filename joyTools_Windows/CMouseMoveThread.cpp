#include "CMouseMoveThread.h"

CMouseMoveThread* CMouseMoveThread::getInstance()
{
    static CMouseMoveThread* instance = new CMouseMoveThread;
    return instance;
}

void CMouseMoveThread::startRun()
{
    m_mutex.lock();
    this->m_bRuning = true;
    m_mutex.unlock();
    this->start();
}

void CMouseMoveThread::stopRun()
{
    m_mutex.lock();
    this->m_bRuning = false;
    m_mutex.unlock();
}

void CMouseMoveThread::setMoveDistance(const int p_nDx,const int p_nDy)
{
    m_mutex.lock();
    this->m_nMoveDx = p_nDx;
    this->m_nMoveDy = p_nDy;
    m_mutex.unlock();
}

void CMouseMoveThread::run()
{
    while(m_bRuning)
    {
        m_mutex.lock();
        mouse_event(MOUSEEVENTF_MOVE,this->m_nMoveDx,this->m_nMoveDy,0,0);
        m_mutex.unlock();
        msleep(1);
    }
}

bool CMouseMoveThread::isRuning()
{
    m_mutex.lock();
    bool bRuning = this->m_bRuning;
    m_mutex.unlock();
    return bRuning;
}
