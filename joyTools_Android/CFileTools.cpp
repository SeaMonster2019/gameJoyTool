#include"CFileTools.h"
#include <QFile>
#include <QTextStream>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>


//构造函数
CFileTools::CFileTools(QObject *parent):QObject(parent)
{

}

//读出保存文件目录
QString CFileTools::saveFileDir()
{
    return _saveFileDir;
}

//写入资源参数
void CFileTools::setSaveFileDir(const QUrl& p_saveFileDirUrl)
{
    QString subStr = "/tree/";
    QString objStr = "/document/";
    QString pathStr = p_saveFileDirUrl.toString();
    _saveFileDir = pathStr.replace(pathStr.indexOf(subStr),subStr.size(),objStr);
    qDebug() << _saveFileDir;
}

//读出被读取文件路径
QString CFileTools::readFilePath()
{
    return _readFilePath;
}

//写入被读取文件路径
void CFileTools::setReadFilePath(const QUrl& p_readFilePathUrl)
{
    _readFilePath = p_readFilePathUrl.toString();
    qDebug() << _readFilePath;
}

//开始保存控制器数据
bool CFileTools::saveBegin(float p_fSetButtonWidth,float p_fSetButtonHeight,float p_fSetButtonPosionX,float p_fSetButtonPosionY)
{
    for(;this->_saveJsonObject.isEmpty() != true;)
    {
        this->_saveJsonObject.erase(_saveJsonObject.begin());
    }
    this->_controllerAmount = 0;
    QJsonArray array;
    array.append(QJsonValue(p_fSetButtonWidth));
    array.push_back(QJsonValue(p_fSetButtonHeight));
    array.push_back(QJsonValue(p_fSetButtonPosionX));
    array.push_back(QJsonValue(p_fSetButtonPosionY));
    _saveJsonObject.insert("setButtonDate",array);
    return true;
}

//写入单个控制器数据
void CFileTools::saveControllerDateOnce(int p_nType,float p_fWidth,float p_fHeight,
                                        float p_fPosionX,float p_fPosionY,
                                        int p_nKeyValue1,int p_nKeyValue2,int p_nKeyValue3,int p_nKeyValue4,
                                        QString p_sShowText)
{
    QJsonArray array;
    array.append(QJsonValue(p_nType));
    array.push_back(QJsonValue(p_fWidth));
    array.push_back(QJsonValue(p_fHeight));
    array.push_back(QJsonValue(p_fPosionX));
    array.push_back(QJsonValue(p_fPosionY));
    array.push_back(QJsonValue(p_nKeyValue1));
    array.push_back(QJsonValue(p_nKeyValue2));
    array.push_back(QJsonValue(p_nKeyValue3));
    array.push_back(QJsonValue(p_nKeyValue4));
    array.push_back(QJsonValue(p_sShowText));
    _saveJsonObject.insert("controller" + QString::number(_controllerAmount),array);
    _controllerAmount++;
}

//获取手柄数据文件名列表
QStringList CFileTools::getDateFilePathList()
{
    QStringList basePathList = QStandardPaths::standardLocations(QStandardPaths::CacheLocation);
    QStringList fileList;
    if(basePathList.length() <= 0){
        qDebug() << "at function CFileTools::getDateFilePathList(), get Dir length is 0";
        return fileList;
    }

    QDir dirinfo(basePathList[0]);
    if (!dirinfo.exists()) {
        return fileList;
    }

    dirinfo.setNameFilters(QStringList("*.json"));
    fileList = dirinfo.entryList(QDir::Files);

    if(fileList.length() <= 0)
    {
        qDebug() << "No handle data exists";
    }
    return fileList;
}

//删除指定数据文件
bool CFileTools::removeFile(const QString& p_sFileName)
{
    QStringList basePathList = QStandardPaths::standardLocations(QStandardPaths::CacheLocation);
    if(basePathList.length() <= 0){
        qDebug()<< "at funciton CFileTools::saveEnd(const QString& p_sFileName),Path not found";
    }

    QFile file(basePathList[0] +"/"+ p_sFileName);
    if(!file.exists())
    {
        qDebug()<< "at function CFileTools::removeFile(const QString& p_sFileName), the file not exists! file name:" + p_sFileName;
        return false;
    }

    if(!file.remove())
    {
        qDebug()<< "at function CFileTools::removeFile(const QString& p_sFileName), Failed to delete file! file name:"+ p_sFileName;
    }

    file.close();
    return true;
}

//保存存入的控制器数据
void CFileTools::saveEnd(const QString& p_sFileName)
{
    _saveJsonObject.insert("fileNmae",p_sFileName);
    QJsonDocument doc(this->_saveJsonObject);//将Json对象，转换成Json文档
    QByteArray jsonTextDate = doc.toJson();

    QStringList basePathList = QStandardPaths::standardLocations(QStandardPaths::CacheLocation);
    if(basePathList.length() <= 0){
        qDebug()<< "at funciton CFileTools::saveEnd(const QString& p_sFileName),Path not found";
    }

    QFile file(basePathList[0] +"/"+ p_sFileName);
    if(!file.open(QIODeviceBase::WriteOnly))
    {
        qDebug()<<"open file false, at function CFileTools::saveEnd(const QString& p_sFileName), file: " + p_sFileName;
        return;
    }
    file.write(jsonTextDate);
    file.close();
}

//读取Json文件
bool CFileTools::readControllerDate(const QString& p_sFileName)
{

    QStringList basePathList = QStandardPaths::standardLocations(QStandardPaths::CacheLocation);
    if(basePathList.length() <= 0){
        qDebug()<< "at funciton CFileTools::saveEnd(const QString& p_sFileName),Path not found";
    }

    //打开文件
    CrossQFile file(basePathList[0] + "/" + p_sFileName);
    if(!file.open(QFile::ReadOnly))
    {
        qDebug() << "read file date false, at function CFileTools::readControllerDate(), file:" + _readFilePath;
        return false;
    }
    QByteArray fileTexT = file.readAll();
    qDebug() << "file name" << file.fileName();
    file.close();
    QJsonDocument doc = QJsonDocument::fromJson(fileTexT);//转成Json格式
    if (doc.isObject())//格式判断
    {
        QJsonObject dateObject = doc.object();//得到Json对象
        QStringList keys = dateObject.keys();//得到所有key

        //检查文件格式
        //找到文件名
        QJsonValue fileNameValue =  dateObject["fileName"];
        if(fileNameValue == QJsonValue::Undefined)
        {
            qDebug() << "read file date false, because format error1, file:" + _readFilePath;
            return false;
        }

        //找到设置按钮参数
        fileNameValue =  dateObject["setButtonDate"];
        if(fileNameValue == QJsonValue::Undefined || !fileNameValue.isArray())
        {
            qDebug() << "read file date false, because format error2, file:" + _readFilePath;
            return false;
        }

        //判断控制器参数格式
        for (int i = 0; i < keys.size() - 2; i++)
        {
            QString key = keys.at(i);
            if(key != (QString("controller") + QString::number(i)))
            {
                qDebug() << "read file date false, because format error3, file:" + _readFilePath;
                return false;
            }
            if(dateObject.value(key).toArray().size() != 10)
            {
                qDebug() << "read file date false, because format error4, file:" + _readFilePath;
                return false;
            }
        }

        //读取设置按钮参数
        emit addControllerDate(8,
                    fileNameValue.toArray().at(0),
                    fileNameValue.toArray().at(1),
                    fileNameValue.toArray().at(2),
                    fileNameValue.toArray().at(3),
                    -1,-1,-1,-1,"");

        //循环读取控制器参数
        for (int i = 0; i < keys.size() - 2; i++)
        {
            QString key = keys.at(i);
            QJsonValue value = dateObject.value(key);
            QJsonArray controllerDateArray = value.toArray();
            emit addControllerDate(controllerDateArray.at(0).toInt(),
                              controllerDateArray.at(1).toDouble(),
                              controllerDateArray.at(2).toDouble(),
                              controllerDateArray.at(3).toDouble(),
                              controllerDateArray.at(4).toDouble(),
                              controllerDateArray.at(5).toInt(),
                              controllerDateArray.at(6).toInt(),
                              controllerDateArray.at(7).toInt(),
                              controllerDateArray.at(8).toInt(),
                              controllerDateArray.at(9).toString());
        }
    }else
    {
        qDebug() << "read file date false, because format error, file:" + _readFilePath;
    }

    qDebug() << "read json success";
    return true;
}
