import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle{

   id:controllerOption
   width: parent.width
   height: parent.height
   x:0
   y:0
   signal openSeting()
   signal addButton(int p_Type,real p_fWidth,real p_fHeight,
                    real p_nPosionX,real p_nPosionY,
                    int p_nKeyValue1,int p_nKeyValue2,int p_nKeyValue3,int p_nKeyValue4,
                    string p_sShowText)

   property var arrShowText: ["左键",//0
        "右键",//1
        "回车",//2
        "退格",//3
	    "TAB",//4
		"SHIFT",//5	
		"CTRL",//6
		"ALT",//7
		"CL",//8
        "ESC",//9
        "Space",//10
		"←",//11
		"↑",//12
		"→",//13
		"↓",//14
		"A",//15
		"B",//16
		"C",//17
		"D",//18
		"E",//19
		"F",//20
		"G",//21
		"H",//22
		"I",//23
		"J",//24
		"K",//25
		"L",//26
		"M",//27
		"N",//28
		"O",//29
		"P",//30
		"Q",//31
		"R",//32
		"S",//33
		"T",//34
		"U",//35
		"V",//36
		"W",//37
		"X",//38
		"Y",//39
		"Z",//40
		"0",//41
		"1",//42
		"2",//43
		"3",//44
		"4",//45
		"5",//46
		"6",//47
		"7",//48
		"8",//49
		"9",//50
		";",//51
		"=",//52
		",",//53
		"-",//54
		".",//55
		"/",//56
		"`",//57
		"[",//58
		"\\",//59
		"]",//60
        "\"\"",//61
        "F1",//62
        "F2",//63
        "F3",//64
        "F4",//65
        "F5",//66
        "F6",//67
        "F7",//68
        "F8",//69
        "F9",//70
        "F10",//71
        "F11",//72
        "F12",//73
        "N0",//74
        "N1",//75
        "N2",//76
        "N3",//77
        "N4",//78
        "N5",//79
        "N6",//80
        "N7",//81
        "N8",//82
        "N9",//83
        "N*",//84
        "N+",//85
        "N回车",//86
        "N-",//87
        "N.",//88
        "N/",//89
   ]
   property var arrKeyValue:[
       0x01,//0
       0x02,//1
       0x0D,//2
       0x08,//3
       0x09,//4
       0x10,//5
       0x11,//6
       0x12,//7
       0x14,//8
       0x1B,//9
       0x20,//10
       0x25,//11
       0X26,//12
       0x27,//13
       0x28,//14
       0x41,//15
       0x42,//16
       0x43,//17
       0x44,//18
       0x45,//19
       0x46,//20
       0x47,//21
       0x48,//22
       0x49,//23
       0x4A,//24
       0x4B,//25
       0x4C,//26
       0x4D,//27
       0x4E,//28
       0x4F,//29
       0x50,//30
       0x51,//31
       0x52,//32
       0x53,//33
       0x54,//34
       0x55,//35
       0x56,//36
       0x57,//37
       0x58,//38
       0x59,//39
       0x5A,//40
       0x30,//41
       0x31,//42
       0x32,//43
       0x33,//44
       0x34,//45
       0x35,//46
       0x36,//47
       0x37,//48
       0x38,//49
       0x39,//50
       0xBA,//51
       0xBB,//52
       0xBC,//53
       0xBD,//54
       0xBE,//55
       0xBF,//56
       0xC0,//57
       0xDB,//58
       0xDC,//59
       0xDD,//60
       0xDE,//61
       0x70,//62
       0x71,//63
       0x72,//64
       0x73,//65
       0x74,//66
       0x75,//67
       0x76,//68
       0x77,//69
       0x78,//70
       0x79,//71
       0x7A,//72
       0x7B,//73
       0x60,//74
       0x61,//75
       0x62,//76
       0x63,//77
       0x64,//78
       0x65,//79
       0x66,//80
       0x67,//81
       0x68,//82
       0x69,//83
       0x6A,//84
       0x6B,//85
       0x6C,//86
       0x6D,//87
       0x6E,//88
       0x6F,//89
   ]
   property real totalWidth: width
   property real totalHeight: height

   //第一行

   Text{
       id:typeLable
       visible: true
       width:totalWidth/10
       height:totalHeight/10
       x:totalWidth/20
       y:totalHeight/20
       text: "控制器类型"
       font.bold: true
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
   }

   ComboBox{
       id:typeOptionComboBox
       visible: true
       width:totalWidth/4
       height:totalHeight/10
       x:typeLable.x+typeLable.width + totalWidth/40
       y:typeLable.y
       font.bold: true
       model: ListModel {
           ListElement {
               text: "按键";//0
                }
           ListElement {
               text: "按钮型4方向键"//1
                }
           ListElement {
               text: "按钮型8方向键"//2
                }
           ListElement {
               text: "触屏型4方向键"//3
                }
           ListElement {
               text: "触屏型8方向键"//4
               }
           ListElement {
               text: "按键摇杆"//5
                }
           ListElement {
               text: "矩形按键"//6
                }
           ListElement {
               text: "鼠标摇杆"//7
           }
       }

       onActivated:function(index){
           if(0 === index ){
               rootLable1_1.visible = true
               rootLable1_1.text = "显示大小"
               sizeOptionComboBox.visible = true
               rootLable1_2.visible = false
               sizeOptionComboBox1_2.visible = false

               rootLable2_1.visible = true
               rootLable2_1.text = "键值"
               keyValueOptionComboBox2_1.visible = true
               rootLable2_2.visible = false
               keyValueOptionComboBox2_2.visible = false

               rootLable3_1.visible = false
               keyValueOptionComboBox3_1.visible  = false
               rootLable3_2.visible = false
               keyValueOptionComboBox3_2.visible =false

           }else if(1 === index ||
                   2 === index ||
                   3 === index ||
                   4 === index ||
                   5 === index ){
               rootLable1_1.visible = true
               rootLable1_1.text = "显示大小"
               sizeOptionComboBox.visible = true
               rootLable1_2.visible = false
               sizeOptionComboBox1_2.visible = false

               rootLable2_1.visible = true
               rootLable2_1.text = "键值(右)"
               keyValueOptionComboBox2_1.visible  = true
               rootLable2_2.visible = true
               rootLable2_2.text = "键值(下)"
               keyValueOptionComboBox2_2.visible = true

               rootLable3_1.visible = true
               rootLable3_1.text = "键值(左)"
               keyValueOptionComboBox3_1.visible  = true
               rootLable3_2.visible = true
               rootLable3_2.text = "键值(上)"
               keyValueOptionComboBox3_2.visible = true


           }else if(6 === index){
               rootLable1_1.visible = true
               rootLable1_1.text = "宽度"
               sizeOptionComboBox.visible = true
               rootLable1_2.visible = true
               rootLable1_2.text = "高度"
               sizeOptionComboBox1_2.visible = true

               rootLable2_1.visible = true
               rootLable2_1.text = "键值"
               keyValueOptionComboBox2_1.visible = true
               rootLable2_2.visible = false
               keyValueOptionComboBox2_2.visible = false

               rootLable3_1.visible = false
               keyValueOptionComboBox3_1.visible  = false
               rootLable3_2.visible = false
               keyValueOptionComboBox3_2.visible =false
           }else if(7 === index){
               rootLable1_1.visible = true
               rootLable1_1.text = "显示大小"
               sizeOptionComboBox.visible = true
               rootLable1_2.visible = true
               rootLable1_2.text = "移动速度"
               sizeOptionComboBox1_2.visible = true

               rootLable2_1.visible = false
               keyValueOptionComboBox2_1.visible = false
               rootLable2_2.visible = false
               keyValueOptionComboBox2_2.visible = false

               rootLable3_1.visible = false
               keyValueOptionComboBox3_1.visible  = false
               rootLable3_2.visible = false
               keyValueOptionComboBox3_2.visible =false
           }


       }
   }

   //第二行

   Text{
       id:rootLable1_1
       visible: true
       width:totalWidth/10
       height:totalHeight/10
       x:totalWidth/20
       y:typeLable.x + typeLable.height + totalHeight/20
       text: "显示大小"
       font.bold: true
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
   }

   ComboBox{
       id:sizeOptionComboBox
       visible: true
       width:totalWidth/4
       height:totalHeight/10
       x:rootLable1_1.x+rootLable1_1.width + totalWidth/40
       y:rootLable1_1.y
       font.bold: true
       model: ListModel{
           ListElement{
               text: "1";
           }
           ListElement{
               text: "2"
           }
           ListElement{
               text: "3"
           }
           ListElement{
               text: "4"
           }
           ListElement{
               text: "5"
           }
           ListElement{
               text: "6"
           }
           ListElement{
               text: "7"
           }
           ListElement{
               text: "8"
           }
           ListElement{
               text: "9"
           }
           ListElement{
               text: "10"
           }
           ListElement{
               text: "11"
           }
           ListElement{
               text: "12"
           }
       }
   }

   Text{
       id:rootLable1_2
       visible: false
       width:totalWidth/10
       height:totalHeight/10
       x:sizeOptionComboBox.x + sizeOptionComboBox.width + totalWidth/20
       y:sizeOptionComboBox.y
       text: "高度大小"
       font.bold: true
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
   }

   ComboBox{
       id:sizeOptionComboBox1_2
       visible: false
       width:totalWidth/4
       height:totalHeight/10
       x:rootLable1_2.x+rootLable1_2.width + totalWidth/40
       y:rootLable1_2.y
       font.bold: true
       model: ListModel{
           ListElement{
               text: "1";
           }
           ListElement{
               text: "2"
           }
           ListElement{
               text: "3"
           }
           ListElement{
               text: "4"
           }
           ListElement{
               text: "5"
           }
           ListElement{
               text: "6"
           }
           ListElement{
               text: "7"
           }
           ListElement{
               text: "8"
           }
           ListElement{
               text: "9"
           }
           ListElement{
               text: "10"
           }
           ListElement{
               text: "11"
           }
           ListElement{
               text: "12"
           }
       }
   }

   //第三行

   Text{
       id:rootLable2_1
       visible: true
       width:totalWidth/10
       height:totalHeight/10
       x:totalWidth/20
       y:rootLable1_1.y + rootLable1_1.height + totalHeight/20
       text: "键值"
       font.bold: true
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
   }

   ComboBox{
       id:keyValueOptionComboBox2_1
       visible: true
       width:totalWidth/4
       height:totalHeight/10
       x:rootLable2_1.x+rootLable2_1.width + totalWidth/40
       y:rootLable2_1.y
       font.bold: true
       model: ListModel {
           ListElement {
              //0
              text: "鼠标左键"
           }
           ListElement {
              //1
              text: "鼠标右键"
           }
           ListElement {
              //2
              text: "回车键";
           }
           ListElement {
              //3
              text: "退格键Backspace"
           }
           ListElement {
              //4
              text: "制表符TAB键"
           }
           ListElement {
              //5
              text: "SHIFT键"
           }
           ListElement {
              //6
              text: "CTRL键"
           }
           ListElement {
              //7
              text: "ALT"
           }
           ListElement {
              //8
              text: "大小写CAPSLOCK键"
           }
           ListElement {
              //9
              text: "ESC"
           }
           ListElement {
              //10
              text: "空格键"
           }
           ListElement {
              //11
              text: "左键"
           }
           ListElement {
              //12
              text: "上键"
           }
           ListElement {
              //13
              text: "右键"
           }
           ListElement {
              //14
              text: "下键"
           }
           ListElement {
              //15
              text: "A"
           }
           ListElement {
              //16
              text: "B"
           }
           ListElement {
              //17
              text: "C"
           }
           ListElement {
              //18
              text: "D"
           }
           ListElement {
              //19
              text: "E"
           }
           ListElement {
              //20
              text: "F"
           }
           ListElement {
              //21
              text: "G"
           }
           ListElement {
              //22
              text: "H"
           }
           ListElement {
              //23
              text: "I"
           }
           ListElement {
              //24
              text: "J"
           }
           ListElement {
              //25
              text: "K"
           }
           ListElement {
              //26
              text: "L"
           }
           ListElement {
              //27
              text: "M"
           }
           ListElement {
              //28
              text: "N"
           }
           ListElement {
              //29
              text: "O"
           }
           ListElement {
              //30
              text: "P"
           }
           ListElement {
              //31
              text: "Q"
           }
           ListElement {
              //32
              text: "R"
           }
           ListElement {
              //33
              text: "S"
           }
           ListElement {
              //34
              text: "T"
           }
           ListElement {
              //35
              text: "U"
           }
           ListElement {
              //36
              text: "V"
           }
           ListElement {
              //37
              text: "W"
           }
           ListElement {
              //38
              text: "X"
           }
           ListElement {
              //39
              text: "Y"
           }
           ListElement {
              //40
              text: "Z"
           }
           ListElement {
              //41
              text: "0"
           }
           ListElement {
              //42
              text: "1"
           }
           ListElement {
              //43
              text: "2"
           }
           ListElement {
              //44
              text: "3"
           }
           ListElement {
              //45
              text: "4"
           }
           ListElement {
              //46
              text: "5"
           }
           ListElement {
              //47
              text: "6"
           }
           ListElement {
              //48
              text: "7"
           }
           ListElement {
              //49
              text: "8"
           }
           ListElement {
              //50
              text: "9"
           }
           ListElement {
              //51
              text: ";:"
           }
           ListElement {
              //52
              text: "=+"
           }
           ListElement {
              //53
              text: ",<"
           }
           ListElement {
              //54
              text: "-_"
           }
           ListElement {
              //55
              text: ".>"
           }
           ListElement {
              //56
              text: "/?"
           }
           ListElement {
              //57
              text: "~`"
           }
           ListElement {
              //58
              text: "[{"
           }
           ListElement {
              //59
              text: "\\|"
           }
           ListElement {
              //60
              text: "]}"
           }
           ListElement {
              //61
              text: "\"\""
           }
           ListElement {
              //62
              text: "F1"
           }
           ListElement {
              //63
              text: "F2"
           }
           ListElement {
              //64
              text: "F3"
           }
           ListElement {
              //65
              text: "F4"
           }
           ListElement {
              //66
              text: "F5"
           }
           ListElement {
              //67
              text: "F6"
           }
           ListElement {
              //68
              text: "F7"
           }
           ListElement {
              //69
              text: "F8"
           }
           ListElement {
              //70
              text: "F9"
           }
           ListElement {
              //71
              text: "F10"
           }
           ListElement {
              //72
              text: "F11"
           }
           ListElement {
              //73
              text: "F12"
           }
           ListElement {
              //74
              text: "小键盘0"
           }
           ListElement {
              //75
              text: "小键盘1"
           }
           ListElement {
              //76
              text: "小键盘2"
           }
           ListElement {
              //77
              text: "小键盘3"
           }
           ListElement {
              //78
              text: "小键盘4"
           }
           ListElement {
              //79
              text: "小键盘5"
           }
           ListElement {
              //80
              text: "小键盘6"
           }
           ListElement {
              //81
              text: "小键盘7"
           }
           ListElement {
              //82
              text: "小键盘8"
           }
           ListElement {
              //83
              text: "小键盘9"
           }
           ListElement {
              //84
              text: "小键盘*"
           }
           ListElement {
              //85
              text: "小键盘+"
           }
           ListElement {
              //86
              text: "小键盘回车"
           }
           ListElement {
              //87
              text: "小键盘-"
           }
           ListElement {
              //88
              text: "小键盘."
           }
           ListElement {
              //89
              text: "小键盘/"
           }
       }
   }

   Text{
       id:rootLable2_2
       visible: false
       width:totalWidth/10
       height:totalHeight/10
       x:keyValueOptionComboBox2_1.x + keyValueOptionComboBox2_1.width + totalWidth/20
       y:rootLable2_1.y
       text: "键值"
       font.bold: true
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
   }

   ComboBox{
       id:keyValueOptionComboBox2_2
       visible: false
       width:totalWidth/4
       height:totalHeight/10
       x:rootLable2_2.x + rootLable2_2.width + totalWidth/40
       y:rootLable2_2.y
       font.bold: true
       model: ListModel {
           ListElement {
              //0
              text: "鼠标左键"
           }
           ListElement {
              //1
              text: "鼠标右键"
           }
           ListElement {
              //2
              text: "回车键";
           }
           ListElement {
              //3
              text: "退格键Backspace"
           }
           ListElement {
              //4
              text: "制表符TAB键"
           }
           ListElement {
              //5
              text: "SHIFT键"
           }
           ListElement {
              //6
              text: "CTRL键"
           }
           ListElement {
              //7
              text: "ALT"
           }
           ListElement {
              //8
              text: "大小写CAPSLOCK键"
           }
           ListElement {
              //9
              text: "ESC"
           }
           ListElement {
              //10
              text: "空格键"
           }
           ListElement {
              //11
              text: "左键"
           }
           ListElement {
              //12
              text: "上键"
           }
           ListElement {
              //13
              text: "右键"
           }
           ListElement {
              //14
              text: "下键"
           }
           ListElement {
              //15
              text: "A"
           }
           ListElement {
              //16
              text: "B"
           }
           ListElement {
              //17
              text: "C"
           }
           ListElement {
              //18
              text: "D"
           }
           ListElement {
              //19
              text: "E"
           }
           ListElement {
              //20
              text: "F"
           }
           ListElement {
              //21
              text: "G"
           }
           ListElement {
              //22
              text: "H"
           }
           ListElement {
              //23
              text: "I"
           }
           ListElement {
              //24
              text: "J"
           }
           ListElement {
              //25
              text: "K"
           }
           ListElement {
              //26
              text: "L"
           }
           ListElement {
              //27
              text: "M"
           }
           ListElement {
              //28
              text: "N"
           }
           ListElement {
              //29
              text: "O"
           }
           ListElement {
              //30
              text: "P"
           }
           ListElement {
              //31
              text: "Q"
           }
           ListElement {
              //32
              text: "R"
           }
           ListElement {
              //33
              text: "S"
           }
           ListElement {
              //34
              text: "T"
           }
           ListElement {
              //35
              text: "U"
           }
           ListElement {
              //36
              text: "V"
           }
           ListElement {
              //37
              text: "W"
           }
           ListElement {
              //38
              text: "X"
           }
           ListElement {
              //39
              text: "Y"
           }
           ListElement {
              //40
              text: "Z"
           }
           ListElement {
              //41
              text: "0"
           }
           ListElement {
              //42
              text: "1"
           }
           ListElement {
              //43
              text: "2"
           }
           ListElement {
              //44
              text: "3"
           }
           ListElement {
              //45
              text: "4"
           }
           ListElement {
              //46
              text: "5"
           }
           ListElement {
              //47
              text: "6"
           }
           ListElement {
              //48
              text: "7"
           }
           ListElement {
              //49
              text: "8"
           }
           ListElement {
              //50
              text: "9"
           }
           ListElement {
              //51
              text: ";:"
           }
           ListElement {
              //52
              text: "=+"
           }
           ListElement {
              //53
              text: ",<"
           }
           ListElement {
              //54
              text: "-_"
           }
           ListElement {
              //55
              text: ".>"
           }
           ListElement {
              //56
              text: "/?"
           }
           ListElement {
              //57
              text: "~`"
           }
           ListElement {
              //58
              text: "[{"
           }
           ListElement {
              //59
              text: "\\|"
           }
           ListElement {
              //60
              text: "]}"
           }
           ListElement {
              //61
              text: "\"\""
           }
           ListElement {
              //62
              text: "F1"
           }
           ListElement {
              //63
              text: "F2"
           }
           ListElement {
              //64
              text: "F3"
           }
           ListElement {
              //65
              text: "F4"
           }
           ListElement {
              //66
              text: "F5"
           }
           ListElement {
              //67
              text: "F6"
           }
           ListElement {
              //68
              text: "F7"
           }
           ListElement {
              //69
              text: "F8"
           }
           ListElement {
              //70
              text: "F9"
           }
           ListElement {
              //71
              text: "F10"
           }
           ListElement {
              //72
              text: "F11"
           }
           ListElement {
              //73
              text: "F12"
           }
           ListElement {
              //74
              text: "小键盘0"
           }
           ListElement {
              //75
              text: "小键盘1"
           }
           ListElement {
              //76
              text: "小键盘2"
           }
           ListElement {
              //77
              text: "小键盘3"
           }
           ListElement {
              //78
              text: "小键盘4"
           }
           ListElement {
              //79
              text: "小键盘5"
           }
           ListElement {
              //80
              text: "小键盘6"
           }
           ListElement {
              //81
              text: "小键盘7"
           }
           ListElement {
              //82
              text: "小键盘8"
           }
           ListElement {
              //83
              text: "小键盘9"
           }
           ListElement {
              //84
              text: "小键盘*"
           }
           ListElement {
              //85
              text: "小键盘+"
           }
           ListElement {
              //86
              text: "小键盘回车"
           }
           ListElement {
              //87
              text: "小键盘-"
           }
           ListElement {
              //88
              text: "小键盘."
           }
           ListElement {
              //89
              text: "小键盘/"
           }
       }
   }

   //第四行

   Text{
       id:rootLable3_1
       visible: false
       width:totalWidth/10
       height:totalHeight/10
       x:totalWidth/20
       y:rootLable2_1.y + rootLable2_1.height + totalHeight/20
       text: "键值"
       font.bold: true
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
   }

   ComboBox{
       id:keyValueOptionComboBox3_1
       visible: false
       width:totalWidth/4
       height:totalHeight/10
       x:rootLable3_1.x+rootLable3_1.width + totalWidth/40
       y:rootLable3_1.y
       font.bold: true
       model: ListModel {
           ListElement {
              //0
              text: "鼠标左键"
           }
           ListElement {
              //1
              text: "鼠标右键"
           }
           ListElement {
              //2
              text: "回车键";
           }
           ListElement {
              //3
              text: "退格键Backspace"
           }
           ListElement {
              //4
              text: "制表符TAB键"
           }
           ListElement {
              //5
              text: "SHIFT键"
           }
           ListElement {
              //6
              text: "CTRL键"
           }
           ListElement {
              //7
              text: "ALT"
           }
           ListElement {
              //8
              text: "大小写CAPSLOCK键"
           }
           ListElement {
              //9
              text: "ESC"
           }
           ListElement {
              //10
              text: "空格键"
           }
           ListElement {
              //11
              text: "左键"
           }
           ListElement {
              //12
              text: "上键"
           }
           ListElement {
              //13
              text: "右键"
           }
           ListElement {
              //14
              text: "下键"
           }
           ListElement {
              //15
              text: "A"
           }
           ListElement {
              //16
              text: "B"
           }
           ListElement {
              //17
              text: "C"
           }
           ListElement {
              //18
              text: "D"
           }
           ListElement {
              //19
              text: "E"
           }
           ListElement {
              //20
              text: "F"
           }
           ListElement {
              //21
              text: "G"
           }
           ListElement {
              //22
              text: "H"
           }
           ListElement {
              //23
              text: "I"
           }
           ListElement {
              //24
              text: "J"
           }
           ListElement {
              //25
              text: "K"
           }
           ListElement {
              //26
              text: "L"
           }
           ListElement {
              //27
              text: "M"
           }
           ListElement {
              //28
              text: "N"
           }
           ListElement {
              //29
              text: "O"
           }
           ListElement {
              //30
              text: "P"
           }
           ListElement {
              //31
              text: "Q"
           }
           ListElement {
              //32
              text: "R"
           }
           ListElement {
              //33
              text: "S"
           }
           ListElement {
              //34
              text: "T"
           }
           ListElement {
              //35
              text: "U"
           }
           ListElement {
              //36
              text: "V"
           }
           ListElement {
              //37
              text: "W"
           }
           ListElement {
              //38
              text: "X"
           }
           ListElement {
              //39
              text: "Y"
           }
           ListElement {
              //40
              text: "Z"
           }
           ListElement {
              //41
              text: "0"
           }
           ListElement {
              //42
              text: "1"
           }
           ListElement {
              //43
              text: "2"
           }
           ListElement {
              //44
              text: "3"
           }
           ListElement {
              //45
              text: "4"
           }
           ListElement {
              //46
              text: "5"
           }
           ListElement {
              //47
              text: "6"
           }
           ListElement {
              //48
              text: "7"
           }
           ListElement {
              //49
              text: "8"
           }
           ListElement {
              //50
              text: "9"
           }
           ListElement {
              //51
              text: ";:"
           }
           ListElement {
              //52
              text: "=+"
           }
           ListElement {
              //53
              text: ",<"
           }
           ListElement {
              //54
              text: "-_"
           }
           ListElement {
              //55
              text: ".>"
           }
           ListElement {
              //56
              text: "/?"
           }
           ListElement {
              //57
              text: "~`"
           }
           ListElement {
              //58
              text: "[{"
           }
           ListElement {
              //59
              text: "\\|"
           }
           ListElement {
              //60
              text: "]}"
           }
           ListElement {
              //61
              text: "\"\""
           }
           ListElement {
              //62
              text: "F1"
           }
           ListElement {
              //63
              text: "F2"
           }
           ListElement {
              //64
              text: "F3"
           }
           ListElement {
              //65
              text: "F4"
           }
           ListElement {
              //66
              text: "F5"
           }
           ListElement {
              //67
              text: "F6"
           }
           ListElement {
              //68
              text: "F7"
           }
           ListElement {
              //69
              text: "F8"
           }
           ListElement {
              //70
              text: "F9"
           }
           ListElement {
              //71
              text: "F10"
           }
           ListElement {
              //72
              text: "F11"
           }
           ListElement {
              //73
              text: "F12"
           }
           ListElement {
              //74
              text: "小键盘0"
           }
           ListElement {
              //75
              text: "小键盘1"
           }
           ListElement {
              //76
              text: "小键盘2"
           }
           ListElement {
              //77
              text: "小键盘3"
           }
           ListElement {
              //78
              text: "小键盘4"
           }
           ListElement {
              //79
              text: "小键盘5"
           }
           ListElement {
              //80
              text: "小键盘6"
           }
           ListElement {
              //81
              text: "小键盘7"
           }
           ListElement {
              //82
              text: "小键盘8"
           }
           ListElement {
              //83
              text: "小键盘9"
           }
           ListElement {
              //84
              text: "小键盘*"
           }
           ListElement {
              //85
              text: "小键盘+"
           }
           ListElement {
              //86
              text: "小键盘回车"
           }
           ListElement {
              //87
              text: "小键盘-"
           }
           ListElement {
              //88
              text: "小键盘."
           }
           ListElement {
              //89
              text: "小键盘/"
           }
       }
   }

   Text{
       id:rootLable3_2
       visible: false
       width:totalWidth/10
       height:totalHeight/10
       x:keyValueOptionComboBox3_1.x + keyValueOptionComboBox3_1.width + totalWidth/20
       y:rootLable3_1.y
       text: "键值"
       font.bold: true
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
   }

   ComboBox{
       id:keyValueOptionComboBox3_2
       visible: false
       width:totalWidth/4
       height:totalHeight/10
       x:rootLable3_2.x+rootLable3_2.width + totalWidth/40
       y:rootLable3_2.y
       font.bold: true
       model: ListModel {
           ListElement {
              //0
              text: "鼠标左键"
           }
           ListElement {
              //1
              text: "鼠标右键"
           }
           ListElement {
              //2
              text: "回车键";
           }
           ListElement {
              //3
              text: "退格键Backspace"
           }
           ListElement {
              //4
              text: "制表符TAB键"
           }
           ListElement {
              //5
              text: "SHIFT键"
           }
           ListElement {
              //6
              text: "CTRL键"
           }
           ListElement {
              //7
              text: "ALT"
           }
           ListElement {
              //8
              text: "大小写CAPSLOCK键"
           }
           ListElement {
              //9
              text: "ESC"
           }
           ListElement {
              //10
              text: "空格键"
           }
           ListElement {
              //11
              text: "左键"
           }
           ListElement {
              //12
              text: "上键"
           }
           ListElement {
              //13
              text: "右键"
           }
           ListElement {
              //14
              text: "下键"
           }
           ListElement {
              //15
              text: "A"
           }
           ListElement {
              //16
              text: "B"
           }
           ListElement {
              //17
              text: "C"
           }
           ListElement {
              //18
              text: "D"
           }
           ListElement {
              //19
              text: "E"
           }
           ListElement {
              //20
              text: "F"
           }
           ListElement {
              //21
              text: "G"
           }
           ListElement {
              //22
              text: "H"
           }
           ListElement {
              //23
              text: "I"
           }
           ListElement {
              //24
              text: "J"
           }
           ListElement {
              //25
              text: "K"
           }
           ListElement {
              //26
              text: "L"
           }
           ListElement {
              //27
              text: "M"
           }
           ListElement {
              //28
              text: "N"
           }
           ListElement {
              //29
              text: "O"
           }
           ListElement {
              //30
              text: "P"
           }
           ListElement {
              //31
              text: "Q"
           }
           ListElement {
              //32
              text: "R"
           }
           ListElement {
              //33
              text: "S"
           }
           ListElement {
              //34
              text: "T"
           }
           ListElement {
              //35
              text: "U"
           }
           ListElement {
              //36
              text: "V"
           }
           ListElement {
              //37
              text: "W"
           }
           ListElement {
              //38
              text: "X"
           }
           ListElement {
              //39
              text: "Y"
           }
           ListElement {
              //40
              text: "Z"
           }
           ListElement {
              //41
              text: "0"
           }
           ListElement {
              //42
              text: "1"
           }
           ListElement {
              //43
              text: "2"
           }
           ListElement {
              //44
              text: "3"
           }
           ListElement {
              //45
              text: "4"
           }
           ListElement {
              //46
              text: "5"
           }
           ListElement {
              //47
              text: "6"
           }
           ListElement {
              //48
              text: "7"
           }
           ListElement {
              //49
              text: "8"
           }
           ListElement {
              //50
              text: "9"
           }
           ListElement {
              //51
              text: ";:"
           }
           ListElement {
              //52
              text: "=+"
           }
           ListElement {
              //53
              text: ",<"
           }
           ListElement {
              //54
              text: "-_"
           }
           ListElement {
              //55
              text: ".>"
           }
           ListElement {
              //56
              text: "/?"
           }
           ListElement {
              //57
              text: "~`"
           }
           ListElement {
              //58
              text: "[{"
           }
           ListElement {
              //59
              text: "\\|"
           }
           ListElement {
              //60
              text: "]}"
           }
           ListElement {
              //61
              text: "\"\""
           }
           ListElement {
              //62
              text: "F1"
           }
           ListElement {
              //63
              text: "F2"
           }
           ListElement {
              //64
              text: "F3"
           }
           ListElement {
              //65
              text: "F4"
           }
           ListElement {
              //66
              text: "F5"
           }
           ListElement {
              //67
              text: "F6"
           }
           ListElement {
              //68
              text: "F7"
           }
           ListElement {
              //69
              text: "F8"
           }
           ListElement {
              //70
              text: "F9"
           }
           ListElement {
              //71
              text: "F10"
           }
           ListElement {
              //72
              text: "F11"
           }
           ListElement {
              //73
              text: "F12"
           }
           ListElement {
              //74
              text: "小键盘0"
           }
           ListElement {
              //75
              text: "小键盘1"
           }
           ListElement {
              //76
              text: "小键盘2"
           }
           ListElement {
              //77
              text: "小键盘3"
           }
           ListElement {
              //78
              text: "小键盘4"
           }
           ListElement {
              //79
              text: "小键盘5"
           }
           ListElement {
              //80
              text: "小键盘6"
           }
           ListElement {
              //81
              text: "小键盘7"
           }
           ListElement {
              //82
              text: "小键盘8"
           }
           ListElement {
              //83
              text: "小键盘9"
           }
           ListElement {
              //84
              text: "小键盘*"
           }
           ListElement {
              //85
              text: "小键盘+"
           }
           ListElement {
              //86
              text: "小键盘回车"
           }
           ListElement {
              //87
              text: "小键盘-"
           }
           ListElement {
              //88
              text: "小键盘."
           }
           ListElement {
              //89
              text: "小键盘/"
           }
       }
   }


   Button{
        id:determineButton
        text: "确定"
        font.bold: true
        width:totalWidth/10
        height:totalHeight/10
        x: totalWidth/3 - cancelButton.width/2
        y: totalHeight - totalHeight/20 - cancelButton.height
        
        onClicked:{
            if(typeOptionComboBox.currentIndex === 0 ){//添加方按钮
                addButton(typeOptionComboBox.currentIndex,
                (sizeOptionComboBox.currentIndex + 1) * 10,
                (sizeOptionComboBox.currentIndex + 1) * 10,
                -1,-1,
                arrKeyValue[keyValueOptionComboBox2_1.currentIndex],-1,-1,-1,
                arrShowText[keyValueOptionComboBox2_1.currentIndex])
            }else if(typeOptionComboBox.currentIndex >= 1 && typeOptionComboBox.currentIndex <= 5){//添加按键摇杆、方向键
                addButton(typeOptionComboBox.currentIndex,
                (sizeOptionComboBox.currentIndex + 4) * 10,
                (sizeOptionComboBox.currentIndex + 4) * 10,
                -1,
                -1,
                arrKeyValue[keyValueOptionComboBox2_1.currentIndex],
                arrKeyValue[keyValueOptionComboBox2_2.currentIndex],
                arrKeyValue[keyValueOptionComboBox3_1.currentIndex],
                arrKeyValue[keyValueOptionComboBox3_2.currentIndex],
                "")
            }else if(typeOptionComboBox.currentIndex === 6){//添加空格
                addButton(typeOptionComboBox.currentIndex,
                (sizeOptionComboBox.currentIndex + 4) * 10,
                (sizeOptionComboBox1_2.currentIndex + 4) * 10,
                -1,-1,
                arrKeyValue[keyValueOptionComboBox2_1.currentIndex],-1,-1,-1,
                arrShowText[keyValueOptionComboBox2_1.currentIndex])
            }else if(typeOptionComboBox.currentIndex === 7){//添加鼠标摇杆
                addButton(typeOptionComboBox.currentIndex,
                (sizeOptionComboBox.currentIndex + 4) * 10,
                (sizeOptionComboBox.currentIndex + 4) * 10,
                -1,-1,
                sizeOptionComboBox1_2.currentIndex * 5,-1,-1,-1,
                "")
            }
       }
   }

   Button{
       id:cancelButton
       text: "取消"
       font.bold: true
       width:totalWidth/10
       height:totalHeight/10
       x: totalWidth*2/3 - cancelButton.width/2
       y: totalHeight - totalHeight/20 - cancelButton.height
       onClicked: {
           openSeting()
       }
   }

   Component.onCompleted:{
       var screenScale = totalWidth/totalHeight
       var thisPixelSize = totalHeight*6/80
       if(screenScale < 5){
          thisPixelSize = totalWidth/50
       }
       typeLable.font.pixelSize = thisPixelSize
       typeOptionComboBox.font.pixelSize = thisPixelSize

       rootLable1_1.font.pixelSize = thisPixelSize
       sizeOptionComboBox.font.pixelSize = thisPixelSize
       rootLable1_2.font.pixelSize = thisPixelSize
       sizeOptionComboBox1_2.font.pixelSize = thisPixelSize

       rootLable2_1.font.pixelSize = thisPixelSize
       keyValueOptionComboBox2_1.font.pixelSize = thisPixelSize
       rootLable2_2.font.pixelSize = thisPixelSize
       keyValueOptionComboBox2_2.font.pixelSize = thisPixelSize

       rootLable3_1.font.pixelSize = thisPixelSize
       keyValueOptionComboBox3_1.font.pixelSize  = thisPixelSize
       rootLable3_2.font.pixelSize = thisPixelSize
       keyValueOptionComboBox3_2.font.pixelSize = thisPixelSize

       determineButton.font.pixelSize = thisPixelSize
       cancelButton.font.pixelSize = thisPixelSize
   }
}
