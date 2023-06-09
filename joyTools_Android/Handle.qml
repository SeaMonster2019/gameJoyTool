import QtQuick 2.15
import QtQuick.Controls 2.15


Rectangle{
    id:handle
    anchors.fill: parent
    color: "#FFFFFF"
    property var controllerList : new Array
    property Item setingItem
    property BaseController tempController

    signal addButton(int p_Type,
                     real p_fWidth,
                     real p_fHeight,
                     real p_nPosionX,
                     real p_nPosionY,
                     int p_nKeyValue1,
                     int p_nKeyValue2,
                     int p_nKeyValue3,
                     int p_nKeyValue4,
                     string p_sShowText)
    signal sendDate(string p_sDate)
    signal operateKeys(bool p_bIsPress,int p_nKeyValue)
    signal operateMouseMove(int p_nAbsoluteValueX,int p_nAbsoluteValueY)
    signal savaControllerDate()

    MultiPointTouchArea{
        id: nomalTouchArea
        anchors.fill: parent
        visible: true
        mouseEnabled: true
        touchPoints: [
            NomalTouchPoint{
                id:point1
                controllerList: handle.controllerList
            },
            NomalTouchPoint{
                id:point2
                controllerList: handle.controllerList
            },
            NomalTouchPoint{
                id:point3
                controllerList: handle.controllerList
            },
            NomalTouchPoint{
                id:point4
                controllerList: handle.controllerList
            }
        ]
    }

    MultiPointTouchArea{
        id: editTouchArea
        anchors.fill : parent
        visible: false
        mouseEnabled: false
        touchPoints: [
            EditTouchPoint{
                id: editTouchPoint1
                controllerList: handle.controllerList
            }
        ]

        Button{
            id:confirm_button
            width:100
            height:50
            x:parent.width/2 - width/2
            y:parent.height - 80
            text: "确认布局"
            font.bold: true
            onClicked: {
                convertToNomalMode()
            }
        }
    }

    BaseController{
        id: editButton
        visible: false
        z:100
        type: BaseController.ControllerType.EditButton
        width: handle.width/8
        height: width/5
        source: "/Ui/Resources/editButton.png"
        x:-1000
        y:-1000

        boundLeft: -1000
        boundUp: -1000
        boundRight: -1000
        boundDown: -1000

        onPressEditButton:function(p_positionX,p_positionY,p_arrNumber) {
            var relativeX = p_positionX - editButton.boundLeft
            var relativeY = p_positionY - editButton.boundUp
            var proportion = controllerList[p_arrNumber].height/controllerList[p_arrNumber].width
            var previousHeight = controllerList[p_arrNumber].height
            if(relativeX < width/5){
                controllerList[p_arrNumber].width  = controllerList[p_arrNumber].width + 5
                controllerList[p_arrNumber].height = proportion*controllerList[p_arrNumber].width
                controllerList[p_arrNumber].resetBound()
                controllerList[p_arrNumber].sizeChange(5,controllerList[p_arrNumber].height - previousHeight)
                editTouchPoint1.openEdit(p_arrNumber)//重置设置菜单位置
            }else if(relativeX >= width/5 && relativeX < width*2/5){

                controllerList[p_arrNumber].width  = controllerList[p_arrNumber].width - 5
                controllerList[p_arrNumber].height = proportion*controllerList[p_arrNumber].width
                controllerList[p_arrNumber].resetBound()
                controllerList[p_arrNumber].sizeChange(-5,controllerList[p_arrNumber].height - previousHeight)
                editTouchPoint1.openEdit(p_arrNumber)//重置设置菜单位置
            }else if(relativeX >= width*2/5 && relativeX < width*3/5){
                controllerList[p_arrNumber].x  =  handle.width/2 - controllerList[p_arrNumber].width/2
                controllerList[p_arrNumber].y  =  handle.height/2 - controllerList[p_arrNumber].height/2
                controllerList[p_arrNumber].width = handle.width/8
                controllerList[p_arrNumber].height = controllerList[p_arrNumber].width
                editTouchPoint1.openEdit(p_arrNumber)//重置设置菜单位置
            }else if(relativeX >= width*3/5 &&relativeX < width*4/5){
                var dsetroyController = controllerList[p_arrNumber]
                controllerList.splice(p_arrNumber,1)
                dsetroyController.destroy()
                editButton.visible = false
                editButton.x = -1000
                editButton.y = -1000
                editTouchPoint1.keyNumber = -1
            }else{
                editButton.visible = false
                editButton.x = -1000
                editButton.y = -1000
                editTouchPoint1.keyNumber = -1
            }
        }
    }

    BaseController{
        id: setingButton
        z:99
        type: BaseController.ControllerType.BaseButton
        width: 40
        height: 40
        x: 20
        y: handle.height/2-40
        visible: true
        source: "/Ui/Resources/set.png"

        boundLeft: x
        boundUp: y
        boundRight: x + width
        boundDown: y + height

        onPressOperation: {
            setingButton.bIsPress = true
            handle.releaseAllOperation()
        }

        onReleaseOperation:{
            handle.visible = false
            setingItem.visible = true
            setingButton.bIsPress = false
            console.debug("length = " + controllerList.length)
        }
    }

    onAddButton:function(p_Type,p_fWidth,p_fHeight,p_nPosionX,p_nPosionY,
                         p_nKeyValue1,p_nKeyValue2,p_nKeyValue3,p_nKeyValue4,p_sShowText){
        var component = Qt.createComponent("BaseController.qml")
        if (component.status === Component.Ready) {
            var newController = component.createObject(handle)
            if(p_nPosionX < 0 || p_nPosionY < 0)
            {
                newController.controllerInit(p_Type,p_fWidth,p_fHeight,handle.width/2,handle.height/2,
                                             p_nKeyValue1,p_nKeyValue2,p_nKeyValue3,p_nKeyValue4,p_sShowText)
            }else{
                newController.controllerInit(p_Type,p_fWidth,p_fHeight,p_nPosionX,p_nPosionY,
                                             p_nKeyValue1,p_nKeyValue2,p_nKeyValue3,p_nKeyValue4,p_sShowText)
            }
            newController.operateKeys.connect(handle.operateKeys)
            newController.operateMouseMove.connect(handle.operateMouseMove)
            handle.controllerList.push(newController)
            convertToEditMode()
        }
    }

    function addControllerDate(p_Type,p_fWidth,p_fHeight,p_nPosionX,p_nPosionY,p_nKeyValue1,p_nKeyValue2,p_nKeyValue3,p_nKeyValue4,p_sShowText){
        if(p_Type >= 0 && p_Type <= 7){
            var component = Qt.createComponent("BaseController.qml")
            if (component.status === Component.Ready) {
                var newController = component.createObject(handle)
                newController.controllerInit(p_Type,p_fWidth,p_fHeight,p_nPosionX,p_nPosionY,
                                             p_nKeyValue1,p_nKeyValue2,p_nKeyValue3,p_nKeyValue4,p_sShowText)
                newController.operateKeys.connect(handle.operateKeys)
                newController.operateMouseMove.connect(handle.operateMouseMove)

                handle.controllerList.push(newController)
                }
        }else if(p_Type === 8){
            handle.controllerList[1].width = p_fWidth
            handle.controllerList[1].height = p_fHeight
            handle.controllerList[1].x = p_nPosionX
            handle.controllerList[1].y = p_nPosionY
        }

    }

    function releaseAllOperation(){
        for(var i = 2;i<controllerList.length;i++){
            controllerList[i].releaseOperation()
        }
    }

    function convertToEditMode(){
        editTouchArea.visible = true
        editTouchArea.mouseEnabled = true
        nomalTouchArea.visible = false
        nomalTouchArea.mouseEnabled = false
    }

    function convertToNomalMode(){
        editTouchArea.visible = false
        editTouchArea.mouseEnabled = false
        nomalTouchArea.visible = true
        nomalTouchArea.mouseEnabled = true

        editButton.visible = false
        editButton.x = -1000
        editButton.y = -1000
        editButton.boundLeft =  -1000
        editButton.boundUp =  -1000
        editButton.boundRight =  -1000
        editButton.boundDown =  -1000
    }

    function cleanControllerArray(){
        for(var i = controllerList.length - 1;controllerList.length > 2;i--){
            var controller =  controllerList[i]
            controllerList.pop()
            controller.destroy()
        }
    }

    function resetSetingButton(){
        setingButton.width = 40
        setingButton.height = 40
        setingButton.x = 20
        setingButton.y = handle.height/2-40
        setingButton.boundLeft = setingButton.x
        setingButton.boundUp = setingButton.y
        setingButton.boundRight = setingButton.x + setingButton.width
        setingButton.boundDown = setingButton.y + setingButton.height
    }

    Component.onCompleted:{
        handle.controllerList.push(editButton)
        handle.controllerList.push(setingButton)
    }

}
