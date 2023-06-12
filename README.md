# gameJoyTool
这是一个游戏手柄工具，可以让你的手机变成游戏手柄，然后用手机控制你的windows电脑。
这个程序是用qt c++和qt qml语言编写。
这个程序虽然已经完成主要功能，但是还是不完善。
特别的，我使用了“win32api”来控制电脑，在某些使用原生接口的游戏，可能程序没办法控制键鼠。

This is a  joypad tool that allows you to program your phone's controller to control your windows computer. 
This program is written using "qt c++" and "qt qml".
This program already has most of the functions, including "communication" and "control", but there are still flaws.
I used the "win32 API" for this program, so the control may fail in some games. I am trying other methods.

# Usage
在这个代码里有qt工程文件，克隆后可以直接编译运行。
当然你可以直接在android项目下里找到apk文件夹下的apk文件直接安装到手机，在windows的目录下找到outpush文件夹下的exe文件直接运行，在两个软件一起运行的情况下，就可以进行远程控制。另外，在这个测试版中，手机需要连接的ip端口号是16666。

There are qt engineering files in this code, which can be directly compiled and run after cloning.
Of course, you can directly find the "APK" file in the "APK" folder under the Android project and install it directly on your phone. In the Windows directory, find the "exe" file in the "outpush" folder and run it directly. When the two software are running together, remote control can be carried out. In addition, in this beta version, the IP port number that the phone app needs to connect to is 16666.
