#ifndef CFILETOOLS_H
#define CFILETOOLS_H

#include <QObject>
#include <QWidget>
#include <QString>
#include <QUrl>
#include <QJsonObject>
#include <QVariant>
#include <QFileDialog>
#include <QJniObject>
#include <CrossQFile.h>
#include <QStandardPaths>
#include <QStringList>
#include <QDir>


class CFileTools:public QObject{
    Q_OBJECT
public:
    Q_PROPERTY(QString saveFileDir READ saveFileDir WRITE setSaveFileDir NOTIFY saveFileDirChanged)
    Q_PROPERTY(QString readFilePath READ readFilePath WRITE setReadFilePath NOTIFY readFilePathChanged)

public:
    Q_INVOKABLE QStringList getDateFilePathList();
    Q_INVOKABLE bool removeFile(const QString& p_sFileName);
    Q_INVOKABLE bool saveBegin(float p_fSetButtonWidth,float p_fSetButtonHeight,
                               float p_fSetButtonPosionX,float p_fSetButtonPosionY);
    Q_INVOKABLE void saveControllerDateOnce(int p_nType,float p_fWidth,float p_fHeight,
                                            float p_fPosionX,float p_fPosionY,
                                            int p_nKeyValue1,int p_nKeyValue2,int p_nKeyValue3,int p_nKeyValue4,
                                            QString p_sShowText);
    Q_INVOKABLE void saveEnd(const QString& p_sFileName);
    Q_INVOKABLE bool readControllerDate(const QString& p_sFileName);

public:
    explicit CFileTools(QObject *parent = nullptr);
    QString saveFileDir();
    void setSaveFileDir(const QUrl& p_saveFileDirUrl);
    QString readFilePath();
    void setReadFilePath(const QUrl& p_readDatePathUrl);

signals:
    void saveFileDirChanged(const QString& source);
    void readFilePathChanged(const QString& source);
    void addControllerDate(QVariant p_nType,QVariant p_fWidth,QVariant p_fHeight,
                           QVariant p_fPosionX,QVariant p_fPosionY,
                           QVariant p_nKeyValue1, QVariant p_nKeyValue2,QVariant p_nKeyValue3,QVariant p_nKeyValue4,
                           QVariant p_sShowText);

private:
    int _controllerAmount;
    QJsonObject _saveJsonObject;
    QString _saveFileDir;
    QString _readFilePath;
};

#endif // CFILETOOLS_H
