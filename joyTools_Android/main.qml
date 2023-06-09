import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import CNetTools 1.0
import CFileTools 1.0

Window {

    id : root
    objectName: "rootWindow"
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true
    title: qsTr("My Android App")
    color: "#FFFFFF"

    CNetTools{
        id : tcpTools
        objectName: "tcpTools"
        onConnected: {
            seting.connectStatus(true)
        }
        onDisconnected: {
            seting.connectStatus(false)
        }
    }

    CFileTools{
        id: fileTools
        objectName: "fileTools"
    }

    Handle{
        id: handle
        objectName: "handle"
        visible: false
        setingItem:seting
        onOperateKeys: function(p_bIsPress,p_nKeyValue){
            tcpTools.operateKeys(p_bIsPress,p_nKeyValue)
        }
        onOperateMouseMove: function(p_nAbsoluteValueX,p_nAbsoluteValueY){
            tcpTools.operateMouseMove(p_nAbsoluteValueX,p_nAbsoluteValueY)
        }
    }

    Seting{
        id: seting
        objectName: "seting"
        visible: true

        onOpenHandle: {
            seting.visible = false
            handle.visible = true
        }
        onOpenControllerOption: {
            seting.visible = false
            controllerOption.visible = true
        }
        onOpenFlieChoseWindow:{
            fileDialog.open()
        }
        onOpenFlieOption: {
            seting.visible = false
            fileOption.visible = true
        }
        onHandleChangeMode: {
            handle.convertToEditMode()

        }
        onCleanLayout: {
            handle.cleanControllerArray()
            handle.resetSetingButton()
        }
    }

    ControllerOption{
        id:controllerOption
        visible: false
        onOpenSeting: {
            seting.visible = true
            controllerOption.visible = false
        }
        onAddButton:function(p_Type,p_fWidth,p_fHeight,p_nPosionX,p_nPosionY,
                             p_nKeyValue1,p_nKeyValue2,p_nKeyValue3,p_nKeyValue4,p_sShowText){
            controllerOption.visible = false
            handle.visible = true
            handle.addButton(p_Type,p_fWidth,p_fHeight,p_nPosionX,p_nPosionY,
                             p_nKeyValue1,p_nKeyValue2,p_nKeyValue3,p_nKeyValue4,p_sShowText)
        }
    }

    FileOption{
        id:fileOption
        visible: false
        fileTools: fileTools
        onOpenSeting: {
            fileOption.visible = false
            seting.visible = true
        }
        onCleanLayout:{
            handle.cleanControllerArray()
        }
    }

    Component.onCompleted:{
        //console.debug("width = " + root.width + ", height = " + root.height)//查看屏幕参数
    }
}

