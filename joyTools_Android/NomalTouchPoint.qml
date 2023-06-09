import QtQuick 2.15

TouchPoint {
    id:touchPoint
    property var controllerList
    property int keyNumber: -1

    //按键按下或者释放时槽函数
    onPressedChanged: {
       if(pressed){
            if(keyNumber == -1){
                for(var i = 1;i< controllerList.length;i++){
                    if(controllerList[i].pressCheckArea(x,y)){
                        keyNumber = i
                    }
                }
            }
        }else{
            if(keyNumber > 0){
                controllerList[keyNumber].releaseOperation()
            }
            keyNumber = -1
        }
    }

    //拖动时槽函数
    onAreaChanged: {
        if(keyNumber > 1)
            controllerList[keyNumber].moveCheck(x,y)
    }
}
