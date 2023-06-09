import QtQuick 2.15

TouchPoint {
    id:touchPoint
    property var controllerList
    property int keyNumber: -1
    property bool pressing: false


    //按键按下或者释放时槽函数
    onPressedChanged: {
       if(pressed){//如果点击屏幕
            if(touchPoint.controllerList[0].visible === false){
                for(var i = 1;i< touchPoint.controllerList.length;i++){
                    if(touchPoint.controllerList[i].checkArea(x,y)){
                        touchPoint.keyNumber = i
                        touchPoint.openEdit(i)
                        break
                    }
                }
            }else{
                for(i = 0;i< touchPoint.controllerList.length;i++){
                    if(i == 0 && touchPoint.controllerList[i].checkArea(x,y)){
                        touchPoint.controllerList[i].pressEditButton(touchPoint.x,touchPoint.y,keyNumber)
                        break
                    }else if(touchPoint.controllerList[i].checkArea(x,y)){
                        touchPoint.keyNumber = i
                        touchPoint.pressing = true
                        touchPoint.openEdit(i)
                        break
                    }
                }
            }
        }else{//如果松开屏幕
           touchPoint.pressing = false
       }
    }

    //拖动时槽函数
    onAreaChanged: {
        if(touchPoint.keyNumber > 0 && touchPoint.pressing === true){
            touchPoint.controllerList[keyNumber].x =  touchPoint.x - touchPoint.controllerList[keyNumber].width/2
            touchPoint.controllerList[keyNumber].y =  touchPoint.y - touchPoint.controllerList[keyNumber].height/2
            touchPoint.controllerList[keyNumber].resetBound()
            touchPoint.openEdit(keyNumber)
        }
    }

    //打开编辑菜单
    function openEdit(arrNumber){
        //设置编辑按钮的x坐标
        controllerList[0].x = (controllerList[arrNumber].x + controllerList[arrNumber].width/2) - controllerList[0].width/2
        if(controllerList[0].x < 0){
            controllerList[0].x = 0
        }else if(controllerList[0].x > controllerList[0].parent.width){
            controllerList[0].x = controllerList[0].parent.width - controllerList[0].width
        }
        //设置编辑按钮的y坐标
        controllerList[0].y = (controllerList[arrNumber].y + controllerList[arrNumber].height)
        if(controllerList[0].y > controllerList[0].parent.height){
            controllerList[0].y = controllerList[arrNumber].y - controllerList[0].height
        }
        controllerList[0].boundLeft = controllerList[0].x
        controllerList[0].boundUp = controllerList[0].y
        controllerList[0].boundRight = controllerList[0].x + controllerList[0].width
        controllerList[0].boundDown = controllerList[0].y + controllerList[0].height
        controllerList[0].visible = true
    }
}
