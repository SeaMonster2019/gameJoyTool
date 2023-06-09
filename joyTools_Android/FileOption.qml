import QtQuick 2.15
import CFileTools 1.0
import QtQuick.Controls 2.15
import Qt.labs.platform

Rectangle {

    id: fileOption
    anchors.fill: parent

    signal openSeting()
    signal cleanLayout()

    property real textAndInputWidth: fileNameLable.width + fileNameInput.width + fileOption.height/40
    property CFileTools fileTools

    property int totalWidth: fileOption.width
    property int totalHeight: fileOption.height

    property int totalPixelSize: fileOption.height/20

    Text{
        id:listLable
        visible: true
        height:totalHeight/8
        width:totalWidth/5
        x: totalWidth/2 - (listLable.width + pathComboBox.width + totalWidth/40)/2
        y: totalHeight/8
        text: "已保存文件列表:"
        font.bold: true
        font.pixelSize: totalPixelSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    ComboBox{
        id: pathComboBox
        visible: true
        width: totalWidth/2
        height: totalHeight/8
        x:listLable.x + listLable.width + totalWidth/40
        y:listLable.y
        font.bold: true
        font.pixelSize: totalPixelSize
        displayText: currentIndex + "." +  currentText
        model: ListModel {
            id : pathListModel
        }
    }

    Text{
        id:fileNameLable
        visible: true
        width:totalWidth/5
        height:totalHeight/8
        x: listLable.x
        y: listLable.y + listLable.height + totalHeight/20
        text: "新保存文件名:"
        font.bold: true
        font.pixelSize: totalPixelSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    TextField{
        id: fileNameInput
        visible: true
        width: fileOption.width/2
        height: fileOption.height/8
        x: fileNameLable.x + fileNameLable.width + fileOption.width/40
        y: fileNameLable.y
        placeholderText: qsTr("输入文件名")
        font.bold: true
        font.pixelSize: totalPixelSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        background:
            Rectangle{
            implicitHeight: fileOption.width/3
            implicitWidth: fileOption.height/10 - fileOption.height/10*6/8
            color: "#D6D6D6"
            border.color: "black"
        }
    }

    Button{
        id:saveButton
        visible: true
        text: "新建手柄数据"
        height:fileOption.height/10
        width:totalPixelSize*8
        x: fileOption.width/4 -  width/2
        y: fileNameLable.y + fileNameLable.height +totalHeight/10
        font.bold: true
        font.pixelSize: totalPixelSize
        onClicked: {
            fileTools.saveBegin(handle.controllerList[1].width,handle.controllerList[1].height,handle.controllerList[1].x,handle.controllerList[1].y)
            for(var i = 2;i<handle.controllerList.length;i++){
                fileTools.saveControllerDateOnce(handle.controllerList[i].type,handle.controllerList[i].width,handle.controllerList[i].height,
                                   handle.controllerList[i].x,handle.controllerList[i].y,
                                   handle.controllerList[i].keyValue1,handle.controllerList[i].keyValue2,handle.controllerList[i].keyValue3,handle.controllerList[i].keyValue4,
                                   handle.controllerList[i].showText)
            }
            fileTools.saveEnd(fileNameInput.text + ".json")
            getFileList()
        }
    }

    Button{
        id:readButton
        visible: true
        text: "读取手柄数据"
        width: saveButton.width
        height:saveButton.height
        x: fileOption.width*2/4 -  width/2
        y: saveButton.y
        font.bold: true
        font.pixelSize: totalPixelSize
        onClicked: {

            if(pathComboBox.currentIndex >= 0){
                preparationReadDate()
                fileTools.readControllerDate(pathListModel.get(pathComboBox.currentIndex).text)
            }


        }
    }

    Button{
        id:replaceButton
        visible: true
        text: "写入选中文件"
        width: saveButton.width
        height:saveButton.height
        x: fileOption.width*3/4 -  width/2
        y: saveButton.y
        font.bold: true
        font.pixelSize: totalPixelSize
        onClicked: {
            if(pathComboBox.currentIndex >= 0){
                fileTools.saveBegin(handle.controllerList[1].width,handle.controllerList[1].height,handle.controllerList[1].x,handle.controllerList[1].y)
                for(var i = 2;i<handle.controllerList.length;i++){
                    fileTools.saveControllerDateOnce(handle.controllerList[i].type,handle.controllerList[i].width,handle.controllerList[i].height,
                                       handle.controllerList[i].x,handle.controllerList[i].y,
                                       handle.controllerList[i].keyValue1,handle.controllerList[i].keyValue2,handle.controllerList[i].keyValue3,handle.controllerList[i].keyValue4,
                                       handle.controllerList[i].showText)
                }
                fileTools.saveEnd(pathListModel.get(pathComboBox.currentIndex).text)
                console.debug(pathListModel.get(pathComboBox.currentIndex).text)
            }
        }
    }

    Button{
        id:deleteButton
        visible: true
        text: "删除选中数据"
        width: saveButton.width
        height:saveButton.height
        x: fileOption.width/3 -  width/2
        y: saveButton.y + saveButton.height + totalHeight/10
        font.bold: true
        font.pixelSize: totalPixelSize
        onClicked: {
            if(pathComboBox.currentIndex >= 0){
                fileTools.removeFile(pathListModel.get(pathComboBox.currentIndex).text)
                getFileList()
            }
        }
    }

    Button{
        id:returnButton
        visible: true
        text: "返回"
        width: saveButton.width
        height:saveButton.height
        x: fileOption.width*2/3 -  width/2
        y: deleteButton.y
        font.bold: true
        font.pixelSize: totalPixelSize
        onClicked: {
            openSeting()
        }
    }

    function getFileList(){

        pathListModel.clear()
        var filePathList = fileTools.getDateFilePathList()
        for(var i = 0;i<filePathList.length;i++)
        {
            pathListModel.append({"text":filePathList[i]})
            console.debug(filePathList[i])
        }

    }

    Component.onCompleted:{
        getFileList()
    }

    onVisibleChanged: {
        getFileList()
    }
}
