import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15

Image{

    //操作器类型枚举变量
    enum ControllerType{
        BaseButton = 0,
        DirectionButton_4 = 1,
        DirectionButton_8 = 2,
        DirectionButton_4_gesture = 3,
        DirectionButton_8_gesture = 4,
        Joystick = 5,
        Space = 6,
        MouseJoystick = 7,
        SetingButton = 8,
        EditButton = 9

    }

    id: baseController

    property int type
    property int keyValue1
    property int keyValue2
    property int keyValue3
    property int keyValue4
    property string showText
    property bool bIsPress: false
    property real boundLeft
    property real boundRight
    property real boundUp
    property real boundDown
    property int pressValue: 0

    property Timer timer

    signal operateKeys(bool p_bIsPress,int p_nKeyValue)
    signal operateMouseMove(int p_nAbsoluteValueX,int p_nAbsoluteValueY)

    signal pressOperation(real p_positionX,real p_positionY)//操作器按下操作
    signal movePointOperation(real p_positionX,real p_positionY)//操作器滑动操作
    signal leaveAreaOperation(real p_positionX,real p_positionY)//操作器滑动时离开自身区域时操作
    signal releaseOperation()//操作器松开操作

    signal pressEditButton(real p_positionX,real p_positionY,int p_arrNumber)
    signal sizeChange(real p_fWidthDifference,real p_fHeightDifference)

    Text{
        id: showText
        anchors.fill: parent
        visible: false
        text: ""
        font.pixelSize: baseController.height/2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    /*操作器初始化函数
    参数 p_parentItem：父窗口
    参数 p_Type:BaseController.ControllerType： 操作器类型
    参数 p_fSize：操作器大小
    参数 p_nPosionX：操作器的x坐标
    参数 p_nPosionY：操作器的y坐标
    参数 p_nKeyValue： 操作器的键值（用于按键类型的操作器）*/
    function controllerInit(p_Type:BaseController.ControllerType,
                            p_fWidth:real,
                            p_fHeight:real,
                            p_nPosionX:real,
                            p_nPosionY:real,
                            p_nKeyValue1:int,
                            p_nKeyValue2:int,
                            p_nKeyValue3:int,
                            p_nKeyValue4:int,
                            p_sShowText:string){

        baseController.type = p_Type
        baseController.width = p_fWidth
        baseController.height = p_fHeight
        baseController.x = p_nPosionX
        baseController.y = p_nPosionY
        baseController.showText = p_sShowText

        baseController.boundLeft = p_nPosionX
        baseController.boundUp = p_nPosionY
        baseController.boundRight = p_nPosionX + baseController.width
        baseController.boundDown = p_nPosionY + baseController.height
        baseController.visible = true

        switch(p_Type){
        case BaseController.ControllerType.BaseButton:{//单个按键
            keyValue1 = p_nKeyValue1
            baseController.source = "/Ui/Resources/Button.png"
            baseController.pressOperation.connect(baseController.buttonPress)
            baseController.releaseOperation.connect(baseController.buttonRelease)
            baseController.leaveAreaOperation.connect(baseController.buttonRelease)
            if(p_sShowText !== ""){
                showText.text = qsTr(p_sShowText)
                showText.visible = true
            }
            break
            }
        case BaseController.ControllerType.DirectionButton_4:{//4方向按钮型
            keyValue1 = p_nKeyValue1
            keyValue2 = p_nKeyValue2
            keyValue3 = p_nKeyValue3
            keyValue4 = p_nKeyValue4
            baseController.source = "/Ui/Resources/DirectionButton.png"
            baseController.pressOperation.connect(baseController.direction_4_ButtonPress)
            baseController.movePointOperation.connect(baseController.direction_4_ButtonMove)
            baseController.releaseOperation.connect(baseController.directionButtonRelease)
            baseController.leaveAreaOperation.connect(baseController.directionButtonRelease)
            break
        }
        case BaseController.ControllerType.DirectionButton_8:{//8方向按钮型
            keyValue1 = p_nKeyValue1
            keyValue2 = p_nKeyValue2
            keyValue3 = p_nKeyValue3
            keyValue4 = p_nKeyValue4
            baseController.source = "/Ui/Resources/DirectionButton.png"
            baseController.pressOperation.connect(baseController.direction_8_ButtonPress)
            baseController.movePointOperation.connect(baseController.direction_8_ButtonMove)
            baseController.releaseOperation.connect(baseController.directionButtonRelease)
            baseController.leaveAreaOperation.connect(baseController.directionButtonRelease)
            break
        }
        case BaseController.ControllerType.DirectionButton_4_gesture:{//4方向滑动型
            keyValue1 = p_nKeyValue1
            keyValue2 = p_nKeyValue2
            keyValue3 = p_nKeyValue3
            keyValue4 = p_nKeyValue4
            baseController.source = "/Ui/Resources/DirectionButton.png"
            baseController.pressOperation.connect(baseController.direction_4_ButtonPress)
            baseController.movePointOperation.connect(baseController.direction_4_ButtonMove)
            baseController.releaseOperation.connect(baseController.directionButtonRelease)
            baseController.leaveAreaOperation.connect(baseController.directionButtonRelease)
            break
        }
        case BaseController.ControllerType.DirectionButton_8_gesture:{//8方向滑动型
            keyValue1 = p_nKeyValue1
            keyValue2 = p_nKeyValue2
            keyValue3 = p_nKeyValue3
            keyValue4 = p_nKeyValue4
            baseController.source = "/Ui/Resources/DirectionButton.png"
            baseController.pressOperation.connect(baseController.direction_8_ButtonPress)
            baseController.movePointOperation.connect(baseController.direction_8_ButtonMove)
            baseController.releaseOperation.connect(baseController.directionButtonRelease)
            baseController.leaveAreaOperation.connect(baseController.directionButtonRelease)
            break
        }
        case BaseController.ControllerType.Joystick:{
            keyValue1 = p_nKeyValue1
            keyValue2 = p_nKeyValue2
            keyValue3 = p_nKeyValue3
            keyValue4 = p_nKeyValue4
            baseController.source = "/Ui/Resources/JoystickBack.png"
            const newJoystickButton = Qt.createQmlObject(`
                import QtQuick 2.15
                Image {

                }
                `,
                baseController,
            );
            newJoystickButton.objectName = "JoystickButton"
            newJoystickButton.source = "/Ui/Resources/JoystickButton.png"
            newJoystickButton.width = baseController.width/3
            newJoystickButton.height = baseController.height/3
            newJoystickButton.x = baseController.width/2 - newJoystickButton.width/2
            newJoystickButton.y = baseController.height/2 - newJoystickButton.height/2

            baseController.pressOperation.connect(baseController.joystickPress)
            baseController.releaseOperation.connect(baseController.joystickRelease)
            baseController.movePointOperation.connect(baseController.joystickMove)
            baseController.leaveAreaOperation.connect(baseController.joystickMove)
            baseController.sizeChange.connect(baseController.joystickSizeChange)
            break
        }
        case BaseController.ControllerType.Space:{//矩形按键
            keyValue1 = p_nKeyValue1
            baseController.source = "/Ui/Resources/Space.png"
            baseController.pressOperation.connect(baseController.spacePress)
            baseController.releaseOperation.connect(baseController.spaceRelease)
            baseController.leaveAreaOperation.connect(baseController.spaceRelease)
            if(p_sShowText !== ""){
                showText.text = qsTr(p_sShowText)
                showText.visible = true
            }
            break
        }
        case BaseController.ControllerType.MouseJoystick:{
            baseController.source = "/Ui/Resources/JoystickBack.png"
            var newJoystickButton1 = Qt.createQmlObject(`
                import QtQuick 2.15
                Image {
                }`,
                baseController,)
            newJoystickButton1.objectName = "MouseJoystick"
            newJoystickButton1.source = "/Ui/Resources/JoystickButton.png"
            newJoystickButton1.width = baseController.width/3
            newJoystickButton1.height = baseController.height/3
            newJoystickButton1.x = baseController.width/2 - newJoystickButton1.width/2
            newJoystickButton1.y = baseController.height/2 - newJoystickButton1.height/2

            timer = Qt.createQmlObject(`
                import QtQml 2.15
                Timer{
                }`,
                baseController,)

            timer.objectName = "MouseJoystickTimer"
            timer.running = false
            timer.interval = 50
            timer.repeat = true
            timer.triggered.connect(baseController.mouseJoystickRepeatSlot)
            baseController.keyValue3 = p_nKeyValue1
            baseController.pressOperation.connect(baseController.mouseJoystickPress)
            baseController.releaseOperation.connect(baseController.mouseJoystickRelease)
            baseController.movePointOperation.connect(baseController.mouseJoystickMove)
            baseController.leaveAreaOperation.connect(baseController.mouseJoystickMove)
            baseController.sizeChange.connect(baseController.joystickSizeChange)
            break
        }
        case BaseController.ControllerType.SetingButton:{
            baseController.source = "/Ui/Resources/set.png"
            baseController.pressOperation.connect(baseController.openSeting)
            break
        }
        case BaseController.ControllerType.EditButton:{
            baseController.source = "/Ui/Resources/editButton.png"
            break
        }
        default:{
            console.debug("Controller creat false, because parameters Controller Type error")
            return false
        }
        }

    }

    //重新设置操作器的边缘
    function resetBound(){
        baseController.boundLeft = x
        baseController.boundUp = y
        baseController.boundRight = x + width
        baseController.boundDown = y + height
    }

    //检查触摸点是否在操作器上
    function checkArea(p_posionX:real,p_posionY:real){
        if((p_posionX > baseController.boundLeft && p_posionX < baseController.boundRight) && (p_posionY > baseController.boundUp && p_posionY < baseController.boundDown)){
            return true
        }
        else{
            return false
        }
    }

    //检查拖动点是否在操作器上
    function moveCheck(p_posionX:real,p_posionY:real){
        if(baseController.checkArea(p_posionX,p_posionY)){
            movePointOperation(p_posionX,p_posionY)
        }else{
            leaveAreaOperation(p_posionX,p_posionY)
        }
    }

    //检查是否按下了操作器
    //如果是：触发操作器的按下信号
    function pressCheckArea(p_posionX:real,p_posionY:real){
        if( baseController.checkArea(p_posionX,p_posionY)){
            baseController.pressOperation(p_posionX,p_posionY)
            return true
        }else{
            return false
        }
    }

    /*********************操作器按下槽函数*************************/
    //按键类型的操作器被按下的槽函数
    function buttonPress(p_positionX:real,p_positionY:real){
        if(bIsPress === false){
            operateKeys(true,keyValue1)
            baseController.source = "/Ui/Resources/Button_Press.png"
            bIsPress = true
        }
    }

    //空格类型的操作器被按下的槽函数
    function spacePress(p_positionX:real,p_positionY:real){
        if(bIsPress === false){
            operateKeys(true,keyValue1)
            baseController.source = "/Ui/Resources/Space_Press.png"
            bIsPress = true
        }
    }

    //4个方向按键的操作器被按下的槽函数
    function direction_4_ButtonPress(p_positionX:real,p_positionY:real){
        bIsPress = true
        var relativeX = (p_positionX - baseController.boundLeft)/baseController.width
        var relativeY = (p_positionY - baseController.boundUp)/baseController.height

        var intervalJudgment = 0
        if(relativeY > relativeX){
            intervalJudgment = 1
        }
        if(relativeY > -relativeX + 1){
            intervalJudgment =  intervalJudgment + 2
        }

        switch(intervalJudgment){
        case 2:{
            //区间1
            operateKeys(true,keyValue1)
            pressValue = 0x01
            break;
        }
        case 3:{
            //区间2
            operateKeys(true,keyValue2)
            pressValue = 0x02
            break;
        }
        case 1:{
            //区间3
            operateKeys(true,keyValue3)
            pressValue = 0x04
            break;
        }
        case 0:{
            //区间4
            operateKeys(true,keyValue4)
            pressValue = 0x08
            break;
        }
        }

    }

    //8个方向按键的操作器被按下的槽函数
    function direction_8_ButtonPress(p_positionX:real,p_positionY:real){

        baseController.bIsPress = true

        var relativeX = p_positionX - baseController.boundLeft
        var relativeY = p_positionY - baseController.boundUp

        if(relativeX >= baseController.width*2/3
                && relativeY >= baseController.height/3
                && relativeY <= baseController.height*2/3){
            //this 1
            operateKeys(true,keyValue1)
            pressValue = 0x01
            console.debug("direction_8_Button : 1")
        }else if(relativeX > baseController.width*2/3
                 && relativeY > baseController.height*2/3 ){
            //this 2
            operateKeys(true,keyValue1)
            operateKeys(true,keyValue2)
            pressValue = 0x03
            console.debug("direction_8_Button : " + 2)
        }else if(relativeX >= baseController.width/3
                 && relativeX <= baseController.width*2/3
                 && relativeY >= baseController.height*2/3){
            //this 3
            operateKeys(true,keyValue2)
            pressValue = 0x02
            console.debug("direction_8_Button : " + 3)
        }else if(relativeX < baseController.width/3
                 && relativeY > baseController.height*2/3 ){
            //this 4
            operateKeys(true,keyValue2)
            operateKeys(true,keyValue3)
            pressValue = 0x06
            console.debug("direction_8_Button : " + 4)
        }else if(relativeX <= baseController.width/3
                 && relativeY >= baseController.height/3
                 && relativeY <= baseController.height*2/3){
            //this 5
            operateKeys(true,keyValue3)
            pressValue = 0x04
            console.debug("direction_8_Button : " + 5)
        }else if(relativeX < baseController.width/3
                 && relativeY < baseController.height/3 ){
            //this 6
            operateKeys(true,keyValue3)
            operateKeys(true,keyValue4)
            pressValue = 0x0C
            console.debug("direction_8_Button : " + 6)
        }else if(relativeX >= baseController.width/3
                 && relativeX <= baseController.height*2/3
                 && relativeY < baseController.height/3){
            //this 7
            operateKeys(true,keyValue4)
            pressValue = 0x08
            console.debug("direction_8_Button : " + 7)
        }else if(relativeX > baseController.width*2/3
                 && relativeY < baseController.height/3 ){
            //this 8
            operateKeys(true,keyValue4)
            operateKeys(true,keyValue1)
            pressValue = 0x9
            console.debug("direction_8_Button : " + 8)
        }else{
            return
        }

    }

    //摇杆被按下的槽函数
    function joystickPress(p_positionX:real,p_positionY:real){
        var relativeX = p_positionX - baseController.boundLeft
        var relativeY = p_positionY - baseController.boundUp
        var joystickButton = baseController.children[1]
        joystickButton.x = relativeX - joystickButton.width/2
        joystickButton.y = relativeY - joystickButton.height/2
        baseController.bIsPress = true
        if(relativeX >= baseController.width*2/3
                && relativeY >= baseController.height/3
                && relativeY <= baseController.height*2/3){
            //this 1
            operateKeys(true,keyValue1)
            pressValue = 0x01
            console.debug("joystickPress : " + 1+ " value" + pressValue)
        }else if(relativeX > baseController.width*2/3
                 && relativeY > baseController.height*2/3 ){
            //this 2
            operateKeys(true,keyValue1)
            operateKeys(true,keyValue2)
            pressValue = 0x03
            console.debug("joystickPress : " + 2)
        }else if(relativeX >= baseController.width/3
                 && relativeX <= baseController.width*2/3
                 && relativeY >= baseController.height*2/3){
            //this 3
            operateKeys(true,keyValue2)
            pressValue = 0x02
            console.debug("joystickPress : " + 3)
        }else if(relativeX < baseController.width/3
                 && relativeY > baseController.height*2/3 ){
            //this 4
            operateKeys(true,keyValue2)
            operateKeys(true,keyValue3)
            pressValue = 0x06
            console.debug("joystickPress : " + 4)
        }else if(relativeX <= baseController.width/3
                 && relativeY >= baseController.height/3
                 && relativeY <= baseController.height*2/3){
            //this 5
            operateKeys(true,keyValue3)
            pressValue = 0x04
            console.debug("joystickPress : " + 5)
        }else if(relativeX < baseController.width/3
                 && relativeY < baseController.height/3 ){
            //this 6
            operateKeys(true,keyValue3)
            operateKeys(true,keyValue4)
            pressValue = 0x0C
            console.debug("joystickPress : " + 6)
        }else if(relativeX >= baseController.width/3
                 && relativeX <= baseController.height*2/3
                 && relativeY < baseController.height/3){
            //this 7
            operateKeys(true,keyValue4)
            pressValue = 0x08
            console.debug("joystickPress : " + 7)
        }else if(relativeX > baseController.width*2/3
                 && relativeY < baseController.height/3 ){
            //this 8
            operateKeys(true,keyValue4)
            operateKeys(true,keyValue1)
            pressValue = 0x9
            console.debug("joystickPress : " + 8)
        }else{
            return
        }
    }

    //鼠标摇杆被按下的槽函数
    function mouseJoystickPress(p_positionX:real,p_positionY:real){

        //修改摇杆位置
        baseController.children[1].x = p_positionX - baseController.boundLeft - baseController.children[1].width/2
        baseController.children[1].y = p_positionY - baseController.boundUp - baseController.children[1].height/2


        //获取触摸点相对坐标
        var relativeX = (p_positionX - baseController.boundLeft)/baseController.width - 0.5
        var relativeY = (p_positionY - baseController.boundUp)/baseController.height - 0.5


        if( relativeX > 0.35355 ||relativeX < -0.35355){
            baseController.keyValue1 = baseController.keyValue3 * (relativeX > 0 ? 1 : -1)
        }else{
            baseController.keyValue1 = baseController.keyValue3 * relativeX / 0.35355
        }

        if(relativeY > 0.35355 || relativeY < -0.35355){
            baseController.keyValue2 = baseController.keyValue3 * (relativeY > 0 ? 1 : -1)
        }else{
            baseController.keyValue2 = baseController.keyValue3 * relativeY / 0.35355
        }

        timer.running = true
        baseController.bIsPress = true
    }

    /*********************操作器触点移动槽函数*************************/

    //4个方向按键操作器的触点移动
    function direction_4_ButtonMove(p_positionX:real,p_positionY:real){
        if(!baseController.bIsPress){
            return
        }
        var relativeX = (p_positionX - baseController.boundLeft)/baseController.width
        var relativeY = (p_positionY - baseController.boundUp)/baseController.height
        if(relativeX >  0.375  //死区判断
           && relativeX < 0.625
           && relativeY > 0.375
           && relativeY < 0.625){
            if((pressValue & 0x01) != 0){
                operateKeys(false,keyValue1)
            }
            if((pressValue & 0x02) != 0){
                 operateKeys(false,keyValue2)
            }
            if((pressValue & 0x04) != 0){
                 operateKeys(false,keyValue3)
            }
            if((pressValue & 0x08) != 0){
                 operateKeys(false,keyValue4)
            }
            pressValue = 0x00
        }else{ //活区判断

             var intervalJudgment = 0
             if(relativeY > relativeX){
                 intervalJudgment = 1
             }
             if(relativeY > -relativeX + 1){
                 intervalJudgment =  intervalJudgment + 2
             }

             var logicNumber = 0
             switch(intervalJudgment){
             case 2:{
                 //区间1
                 logicNumber = 0x01
                 break;
             }
             case 3:{
                 //区间2
                 logicNumber = 0x02
                 break;
             }
             case 1:{
                 //区间3
                 logicNumber = 0x04
                 break;
             }
             case 0:{
                 //区间4
                 logicNumber = 0x08
                 break;
             }
             }

             var actionNumber = pressValue ^ logicNumber
             if(actionNumber != 0){

                 if(baseController.type === 1){
                     baseController.leaveAreaOperation(p_positionX,p_positionY)
                     return
                 }


                 if((actionNumber & 0x01) != 0){
                     operateKeys(((logicNumber & 0x01) != 0),keyValue1)
                 }
                 if((actionNumber & 0x02) != 0){
                      operateKeys(((logicNumber & 0x02) != 0),keyValue2)
                 }
                 if((actionNumber & 0x04) != 0){
                      operateKeys(((logicNumber & 0x04) != 0),keyValue3)
                 }
                 if((actionNumber & 0x08) != 0){
                      operateKeys(((logicNumber & 0x08) != 0),keyValue4)
                 }
                 pressValue = logicNumber
             }
         }
    }

    //8个方向按键操作器的触点移动
    function direction_8_ButtonMove(p_positionX:real,p_positionY:real){
        if(!baseController.bIsPress){
            return
        }
        var relativeX = (p_positionX - baseController.boundLeft)/baseController.width
        var relativeY = (p_positionY - baseController.boundUp)/baseController.height


        if(relativeX >  1/3  //死区判断
           && relativeX < 2/3
           && relativeY > 1/3
           && relativeY <2/3){

            if((pressValue & 0x01) != 0){
                operateKeys(false,keyValue1)
            }
            if((pressValue & 0x02) != 0){
                 operateKeys(false,keyValue2)
            }
            if((pressValue & 0x04) != 0){
                 operateKeys(false,keyValue3)
            }
            if((pressValue & 0x08) != 0){
                 operateKeys(false,keyValue4)
            }
            pressValue = 0x00


        }else{//活区判断

            var intervalJudgment = 0
            //移动落点
            if(relativeX >= 2/3){
                intervalJudgment = intervalJudgment + 0x02
            }else if(relativeX >= 1/3){
                intervalJudgment = intervalJudgment + 0x01
            }

            if(relativeY >= 2/3){
                intervalJudgment = intervalJudgment + 0x08
            }else if(relativeY >= 1/3){
                intervalJudgment = intervalJudgment + 0x04
            }

            var logicNumber = 0
            switch(intervalJudgment){
            case 0x06:{
                //区间1
                logicNumber = 0x01
                break;
            }
            case 0x0A:{
                //区间2
                logicNumber = 0x03
                break;
            }
            case 0x09:{
                //区间3
                logicNumber = 0x02
                break;
            }
            case 0x08:{
                //区间4
                logicNumber = 0x06
                break;
            }
            case 0x04:{
                //区间5
                logicNumber = 0x04
                break;
            }
            case 0x00:{
                //区间6
                logicNumber = 0x0C
                break;
            }
            case 0x01:{
                //区间7
                logicNumber = 0x08
                break;
            }
            case 0x02:{
                //区间8
                logicNumber = 0x09
                break;
            }
            }
            var actionNumber = pressValue ^ logicNumber

            if(actionNumber != 0){
                if(baseController.type === 2){
                    if(((actionNumber & 0x01) != 0) && ((logicNumber & 0x01) == 0)){
                        operateKeys(false,keyValue1)
                        pressValue = pressValue & 0xFE
                    }
                    if(((actionNumber & 0x02) != 0) && ((logicNumber & 0x02) == 0)){
                        operateKeys(false,keyValue2)
                        pressValue = pressValue & 0xFD
                    }
                    if(((actionNumber & 0x04) != 0) && ((logicNumber & 0x04) == 0)){
                        operateKeys(false,keyValue3)
                        pressValue = pressValue & 0xFB
                    }
                    if(((actionNumber & 0x08) != 0) && ((logicNumber & 0x08) == 0)){
                        operateKeys(false,keyValue4)
                        pressValue = pressValue & 0xF7
                    }
                    if(pressValue === 0){
                        pressValue.bIsPress = false
                    }
                }else{

                    if((actionNumber & 0x01) != 0){
                        operateKeys(((logicNumber & 0x01) != 0),keyValue1)
                    }
                    if((actionNumber & 0x02) != 0){
                        operateKeys(((logicNumber & 0x02) != 0),keyValue2)
                    }
                    if((actionNumber & 0x04) != 0){
                        operateKeys(((logicNumber & 0x04) != 0),keyValue3)
                    }
                    if((actionNumber & 0x08) != 0){
                        operateKeys(((logicNumber & 0x08) != 0),keyValue4)
                    }
                    pressValue = logicNumber
                }
            }

        }
    }

    //摇杆的触点移动
    function joystickMove(p_positionX:real,p_positionY:real){
        if(!baseController.bIsPress){
            return
        }


        var backCentreX = baseController.x + baseController.width/2 //背景圆圆心X
        var backCentreY = baseController.y + baseController.height/2 //背景圆圆心Y
        var joystickButton = baseController.children[1]

        var moveOperate = false
        var relativeX = 0
        var relativeY = 0
        
        //如果移动点在圆内
        if((p_positionX - backCentreX)*(p_positionX - backCentreX)
                + (p_positionY- backCentreY)*(p_positionY- backCentreY) <= baseController.width*baseController.width/4){
            
            //修改摇杆柄显示的位置
            joystickButton.x =  p_positionX - baseController.boundLeft - joystickButton.width/2
            joystickButton.y =  p_positionY - baseController.boundUp - joystickButton.height/2
            
            //归一化的柄相对摇杆位置
            relativeX = (p_positionX - baseController.boundLeft)/baseController.width
            relativeY = (p_positionY - baseController.boundUp)/baseController.height
            
            if(relativeX >  1/3
               && relativeX < 2/3
               && relativeY > 1/3
               && relativeY < 2/3){//死区判断
                
                if((pressValue & 0x01) != 0){
                    operateKeys(false,keyValue1)
                }
                if((pressValue & 0x02) != 0){
                     operateKeys(false,keyValue2)
                }
                if((pressValue & 0x04) != 0){
                     operateKeys(false,keyValue3)
                }
                if((pressValue & 0x08) != 0){
                     operateKeys(false,keyValue4)
                }
                pressValue = 0x00
                
            }else{//活区判断
                moveOperate = true
            }
        }else{//如果移动点在圆外
            
            //计算摇杆柄在圆上的位置
            
            var fRelativeX = p_positionX - backCentreX //触点相对背景圆心X
            var fRelativeY = p_positionY - backCentreY //触点相对背景圆心Y

            //用三角形平行线定理求位置，计算比例
            var fDiagonalLength = Math.sqrt(fRelativeX*fRelativeX + fRelativeY*fRelativeY)
            var fProportion = baseController.width/2/fDiagonalLength
            
            //修改柄的显示位置
            joystickButton.x =  baseController.width/2 + fProportion * fRelativeX - joystickButton.width/2
            joystickButton.y =  baseController.height/2 + fProportion * fRelativeY - joystickButton.height/2

            //归一化的柄相对位置
            relativeX = (fProportion * fRelativeX + baseController.width/2)/baseController.width
            relativeY = (fProportion * fRelativeY + baseController.height/2)/baseController.width
            
            moveOperate = true
        }
        
        //如果并非死区操作，需要判断是否更新按钮
        if(moveOperate){
            var intervalJudgment = 0
            //移动落点
            if(relativeX >= 2/3){
                intervalJudgment = intervalJudgment + 0x02
            }else if(relativeX >= 1/3){
                intervalJudgment = intervalJudgment + 0x01
            }

            if(relativeY >= 2/3){
                intervalJudgment = intervalJudgment + 0x08
            }else if(relativeY >= 1/3){
                intervalJudgment = intervalJudgment + 0x04
            }    
            
            var logicNumber = 0
            switch(intervalJudgment){
            case 0x06:{
                //区间1
                logicNumber = 0x01
                break;
            }
            case 0x0A:{
                //区间2
                logicNumber = 0x03
                break;
            }
            case 0x09:{
                //区间3
                logicNumber = 0x02
                break;
            }
            case 0x08:{
                //区间4
                logicNumber = 0x06
                break;
            }
            case 0x04:{
                //区间5
                logicNumber = 0x04
                break;
            }
            case 0x00:{
                //区间6
                logicNumber = 0x0C
                break;
            }
            case 0x01:{
                //区间7
                logicNumber = 0x08
                break;
            }
            case 0x02:{
                //区间8
                logicNumber = 0x09
                break;
            }
            }
            var actionNumber = pressValue ^ logicNumber
            if((actionNumber & 0x01) != 0){
                operateKeys(((logicNumber & 0x01) != 0),keyValue1)
            }
            if((actionNumber & 0x02) != 0){
                operateKeys(((logicNumber & 0x02) != 0),keyValue2)
            }
            if((actionNumber & 0x04) != 0){
                operateKeys(((logicNumber & 0x04) != 0),keyValue3)
            }
            if((actionNumber & 0x08) != 0){
                operateKeys(((logicNumber & 0x08) != 0),keyValue4)
            }
            pressValue = logicNumber
        }
        
        
    }

    //鼠标摇杆的触点移动s
    function mouseJoystickMove(p_positionX:real,p_positionY:real){
        var backCentreX = baseController.x + baseController.width/2 //背景圆圆心X
        var backCentreY = baseController.y + baseController.height/2 //背景圆圆心Y
        var joystickButton = baseController.children[1]

        var moveOperate = false

        var relativeX = 0
        var relativeY = 0

        //如果移动点在圆内
        if((p_positionX - backCentreX)*(p_positionX - backCentreX)
                + (p_positionY- backCentreY)*(p_positionY- backCentreY) <= baseController.width*baseController.width/4){

            //修改摇杆柄显示的位置
            joystickButton.x =  p_positionX - baseController.boundLeft - joystickButton.width/2
            joystickButton.y =  p_positionY - baseController.boundUp - joystickButton.height/2

            //归一化的柄相对摇杆位置
            relativeX = (p_positionX - baseController.boundLeft)/baseController.width - 0.5
            relativeY = (p_positionY - baseController.boundUp)/baseController.height - 0.5

        }else{//如果移动点在圆外

            //计算摇杆柄在圆上的位置

            var fRelativeX = p_positionX - backCentreX //触点相对背景圆心X
            var fRelativeY = p_positionY - backCentreY //触点相对背景圆心Y

            //用三角形平行线定理求位置，计算比例
            var fDiagonalLength = Math.sqrt(fRelativeX*fRelativeX + fRelativeY*fRelativeY)
            var fProportion = baseController.width/2/fDiagonalLength

            //修改柄的显示位置
            joystickButton.x =  baseController.width/2 + fProportion * fRelativeX - joystickButton.width/2
            joystickButton.y =  baseController.height/2 + fProportion * fRelativeY - joystickButton.height/2

            //归一化的柄相对位置
            relativeX = (fProportion * fRelativeX + baseController.width/2)/baseController.width - 0.5
            relativeY = (fProportion * fRelativeY + baseController.height/2)/baseController.width - 0.5
        }

        if( relativeX > 0.35355 ||relativeX < -0.35355){
            baseController.keyValue1 = baseController.keyValue3 * (relativeX > 0 ? 1 : -1)
        }else{
            baseController.keyValue1 = baseController.keyValue3 * relativeX / 0.35355
        }

        if(relativeY > 0.35355 || relativeY < -0.35355){
            baseController.keyValue2 = baseController.keyValue3 * (relativeY > 0 ? 1 : -1)
        }else{
            baseController.keyValue2 = baseController.keyValue3 * relativeY / 0.35355
        }


    }

    /*********************操作器松开槽函数*************************/
    //按键类型的操作器被松开的槽函数
    function buttonRelease(p_posionX:real,p_posionY:real){
        if(bIsPress){
            operateKeys(false,keyValue1)
            baseController.source = "/Ui/Resources/Button.png"
            bIsPress = false
        }
    }

    //空格类型的操作器被松开的槽函数
    function spaceRelease(p_positionX:real,p_positionY:real){
        if(bIsPress === true){
            operateKeys(false,keyValue1)
            baseController.source = "/Ui/Resources/Space.png"
            bIsPress = false
        }
    }

    //方向按键的操作器被松开的槽函数
    function directionButtonRelease(p_posionX:real,p_posionY:real){

        if( bIsPress){
            if((pressValue & 0x01) != 0){
                operateKeys(false,keyValue1)
            }
            if((pressValue & 0x02) != 0){
                 operateKeys(false,keyValue2)
            }
            if((pressValue & 0x04) != 0){
                 operateKeys(false,keyValue3)
            }
            if((pressValue & 0x08) != 0){
                 operateKeys(false,keyValue4)
            }
            pressValue = 0x00
            bIsPress = false;
        }
    }

    //摇杆被松开的槽函数
    function joystickRelease(p_posionX:real,p_posionY:real){
        if(baseController.bIsPress){
            var joystickButton = baseController.children[1]
            joystickButton.x = baseController.width/2 - joystickButton.width/2
            joystickButton.y = baseController.height/2 - joystickButton.height/2
            if((pressValue & 0x01) != 0){
                operateKeys(false,keyValue1)
            }
            if((pressValue & 0x02) != 0){
                 operateKeys(false,keyValue2)
            }
            if((pressValue & 0x04) != 0){
                 operateKeys(false,keyValue3)
            }
            if((pressValue & 0x08) != 0){
                 operateKeys(false,keyValue4)
            }
            pressValue = 0
            baseController.bIsPress = false
        }
    }

    //鼠标摇杆被松开的槽函数
    function mouseJoystickRelease(p_posionX:real,p_posionY:real){

        if(baseController.bIsPress){
            var joystickButton = baseController.children[1]
            joystickButton.x = baseController.width/2 - joystickButton.width/2
            joystickButton.y = baseController.height/2 - joystickButton.height/2
            baseController.keyValue1 = 0
            baseController.keyValue2 = 0
            timer.running = false
            operateMouseMove(0,0)
            baseController.bIsPress = false
        }
    }

    /*********************其他函数*************************/
    function buttonSizeChange(p_fWidthDifference,p_fHeightDifference){
        var buttonText = baseController.children[0]
        buttonText.width = baseController.width
        buttonText.height = baseController.height
        buttonText.x = baseController.width/2 - buttonText.width/2
        buttonText.y = baseController.height/2 - buttonText.height/2
        buttonText.fontInfo.pixelSize = baseController.height/2
    }

    //摇杆大小改变槽函数
    function joystickSizeChange(p_fWidthDifference,p_fHeightDifference){
        var joystickButton = baseController.children[1]
        joystickButton.width = joystickButton.width + p_fWidthDifference/3
        joystickButton.height = joystickButton.height + p_fWidthDifference/3
        joystickButton.x = baseController.width/2 - joystickButton.width/2
        joystickButton.y = baseController.height/2 - joystickButton.height/2
    }

    //鼠标摇杆移动输重复运行的槽函数
    function mouseJoystickRepeatSlot(){
        operateMouseMove(baseController.keyValue1,baseController.keyValue2)
    }
}

