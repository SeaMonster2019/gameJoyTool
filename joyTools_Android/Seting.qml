import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle{
    id:seting
    anchors.fill: parent
    color: "#FFFFFF"

    signal openHandle()
    signal openControllerOption()
    signal openFlieChoseWindow()
    signal openFlieOption()
    signal handleChangeMode()
    signal cleanLayout()

    property int totalWidth: seting.width
    property int totalHeight: seting.height

    property int partWidth: totalWidth/8
    property int partHeight: totalHeight/8

    Text{
        id:ipLable
        width: partWidth
        height: partHeight
        x: totalWidth/20
        y: totalHeight/4 - height
        text: "IP"
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: ipTextFiled
        width: totalWidth/4
        height: partHeight
        x: ipLable.x + ipLable.width + totalWidth/40
        y: ipLable.y
        color: "#D6D6D6"
        TextInput {
            id: ipTextInput
            anchors.fill: parent
            anchors.margins: 2
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            focus: true
        }
    }

    Text{
        id:pornLable
        width: partWidth
        height: partHeight
        x: ipTextFiled.x + ipTextFiled.width + totalWidth/20
        y: ipLable.y
        text: "端口号"
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }


    Rectangle {
        id: pornTextFiled
        width: totalWidth/6
        height: partHeight
        x: pornLable.x + pornLable.width + totalWidth/40
        y: ipLable.y
        color: "#D6D6D6"
        TextInput {
            id: pornTextInput
            anchors.fill: parent
            anchors.margins: 2
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            focus: true
        }
    }


    Button{
        //第一层第1个按钮
        id : button_connect
        width: partWidth
        height: partHeight
        x: controllerOptionButton.x
        y: ipLable.y + ipLable.height + totalHeight/10
        text:"连接电脑"
        font.bold: true
        onClicked: {
            tcpTools.doConnect(ipTextInput.text,pornTextInput.text)
        }
    }

    Button{
        //第一层第2个按钮
        id : button_disconnect
        width: button_connect.width
        height: button_connect.height
        x: setingLayout.x
        y: button_connect.y
        text: "断开连接"
        font.bold: true
        onClicked: {
            tcpTools.doDisconnect()
        }
    }

    Button{
        id:initButon
        width: button_connect.width
        height: button_connect.height
        x: save_read_Button.x
        y: button_connect.y
        text: "初始化布局"
        font.bold: true
        onClicked: {
            cleanLayout()
        }
    }


    Button{
        //第二层第1个按钮
        id : controllerOptionButton
        width: button_connect.width
        height: button_connect.height
        property int leftSide : handleButton.x + handleButton.width
        x:leftSide + (totalWidth - leftSide*2)/4 - width/2
        y: button_connect.y + button_connect.height + totalHeight/10
        text: "添加按键"
        font.bold: true
        onClicked: {
            openControllerOption()
        }
    }

    Button{
        //第二层第2个按钮
        id : setingLayout
        width: button_connect.width
        height: button_connect.height
        x: controllerOptionButton.leftSide + (totalWidth - controllerOptionButton.leftSide*2)*2/4 - width/2
        y: controllerOptionButton.y
        text: "布局设置"
        font.bold: true
        onClicked: {
            handleChangeMode()
            openHandle()
        }
    }

    Button{
        //第二层第3个按钮
        id : save_read_Button
        width: button_connect.width
        height: button_connect.height
        x: controllerOptionButton.leftSide + (totalWidth - controllerOptionButton.leftSide*2)*3/4 - width/2
        y: controllerOptionButton.y
        text: "存/读布局"
        font.pointSize: 15
        font.bold: true
        onClicked: {
            openFlieOption()
        }
    }


    Button{
        id:handleButton
        width: totalWidth/8
        height: width
        x: totalWidth/40
        y: (button_connect.y + button_connect.height/2 + controllerOptionButton.y + controllerOptionButton.height/2)/2 - height/2
        Image{
            id:handleImage
            anchors.fill: parent
            source: "/Ui/Resources/handle_disconnect.png"
        }
        onClicked: {
            seting.openHandle()
        }
    }

    function connectStatus(bIsConnect:bool){
        if(bIsConnect){
            handleImage.source = "/Ui/Resources/handle.png"
        }else{
            handleImage.source = "/Ui/Resources/handle_disconnect.png"
        }
    }

    Component.onCompleted:{
        var thisPixelSize = partHeight*6/8

        if(partWidth/partHeight*6/8 < 6)
        {
            thisPixelSize = partWidth/6
        }


        ipLable.font.pixelSize = thisPixelSize
        ipTextInput.font.pixelSize = thisPixelSize
        pornLable.font.pixelSize = thisPixelSize
        pornTextInput.font.pixelSize = thisPixelSize

        button_connect.font.pixelSize = thisPixelSize
        button_disconnect.font.pixelSize = thisPixelSize
        initButon.font.pixelSize = thisPixelSize

        controllerOptionButton.font.pixelSize = thisPixelSize
        setingLayout.font.pixelSize = thisPixelSize
        save_read_Button.font.pixelSize = thisPixelSize
    }

}
