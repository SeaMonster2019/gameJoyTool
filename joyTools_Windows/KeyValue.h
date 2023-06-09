#ifndef KEYVALUE_H
#define KEYVALUE_H
namespace VK
{
#define VK_LBUTTON        0x01    //鼠标左键
#define VK_RBUTTON        0x02    //鼠标右键
#define VK_CANCEL         0x03    //Ctrl + Break
#define VK_MBUTTON        0x04    //鼠标中键/* NOT contiguous with L & RBUTTON */
#define VK_BACK           0x08   //Backspace 键
#define VK_TAB            0x09   //Tab 键
#define VK_CLEAR          0x0C
#define VK_RETURN         0x0D   //回车键
#define VK_SHIFT          0x10
#define VK_CONTROL        0x11
#define VK_MENU           0x12   //Alt 键
#define VK_PAUSE          0x13
#define VK_CAPITAL        0x14   //Caps Lock 键
#define VK_KANA           0x15
#define VK_HANGEUL        0x15 /* old name - should be here for compatibility */
#define VK_HANGUL         0x15
#define VK_JUNJA          0x17
#define VK_FINAL          0x18
#define VK_HANJA          0x19
#define VK_KANJI          0x19
#define VK_ESCAPE         0x1B   //Esc 键
#define VK_CONVERT        0x1C
#define VK_NONCONVERT     0x1D
#define VK_ACCEPT         0x1E
#define VK_MODECHANGE     0x1F
#define VK_SPACE          0x20   //空格
#define VK_PRIOR          0x21   //Page Up 键
#define VK_NEXT           0x22   //Page Down 键
#define VK_END            0x23   //End 键
#define VK_HOME           0x24   //Home 键
#define VK_LEFT           0x25  /*方向键*/
#define VK_UP             0x26
#define VK_RIGHT          0x27
#define VK_DOWN           0x28
#define VK_SELECT         0x29
#define VK_PRINT          0x2A
#define VK_EXECUTE        0x2B
#define VK_SNAPSHOT       0x2C   //Print Screen 键
#define VK_INSERT         0x2D  //Insert键
#define VK_DELETE         0x2E  //Delete键
#define VK_HELP           0x2F
/* VK_0 thru VK_9 are the same as ASCII '0' thru '9' (0x30 - 0x39) */

//定义数据字符0~9
#define   VK_0         0x30
#define   VK_1         0x31
#define   VK_2         0x32
#define   VK_3         0x33
#define   VK_4         0x34
#define   VK_5         0x35
#define   VK_6         0x36
#define   VK_7         0x37
#define   VK_8         0x38
#define   VK_9         0x39

//定义数据字符A~Z
#define   VK_A  0x41
#define   VK_B  0x42
#define   VK_C  0x43
#define   VK_D  0x44
#define   VK_E  0x45
#define   VK_F  0x46
#define   VK_G  0x47
#define   VK_H  0x48
#define   VK_I  0x49
#define   VK_J  0x4A
#define   VK_K  0x4B
#define   VK_L  0x4C
#define   VK_M  0x4D
#define   VK_N  0x4E
#define   VK_O  0x4F
#define   VK_P  0x50
#define   VK_Q  0x51
#define   VK_R  0x52
#define   VK_S  0x53
#define   VK_T  0x54
#define   VK_U  0x55
#define   VK_V  0x56
#define   VK_W  0x57
#define   VK_X  0x58
#define   VK_Y  0x59
#define   VK_Z  0x5A

//定义数据字符a~z
#define   VK_a  0x61
#define   VK_b  0x62
#define   VK_c  0x63
#define   VK_d  0x64
#define   VK_e  0x65
#define   VK_f  0x66
#define   VK_g  0x67
#define   VK_h  0x68
#define   VK_i  0x69
#define   VK_j  0x6A
#define   VK_k  0x6B
#define   VK_l  0x6C
#define   VK_m  0x6D
#define   VK_n  0x6E
#define   VK_o  0x6F
#define   VK_p  0x70
#define   VK_q  0x71
#define   VK_r  0x72
#define   VK_s  0x73
#define   VK_t  0x74
#define   VK_u  0x75
#define   VK_v  0x76
#define   VK_w  0x77
#define   VK_x  0x78
#define   VK_y  0x79
#define   VK_z  0x7A

/* VK_A thru VK_Z are the same as ASCII 'A' thru 'Z' (0x41 - 0x5A) */
#define VK_LWIN           0x5B //左WinKey(104键盘才有)
#define VK_RWIN           0x5C //右WinKey(104键盘才有)
#define VK_APPS           0x5D //AppsKey(104键盘才有)
#define VK_NUMPAD0        0x60 //小键盘0-9
#define VK_NUMPAD1        0x61
#define VK_NUMPAD2        0x62
#define VK_NUMPAD3        0x63
#define VK_NUMPAD4        0x64
#define VK_NUMPAD5        0x65
#define VK_NUMPAD6        0x66
#define VK_NUMPAD7        0x67
#define VK_NUMPAD8        0x68
#define VK_NUMPAD9        0x69
#define VK_MULTIPLY       0x6A //乘
#define VK_ADD            0x6B //加
#define VK_SEPARATOR      0x6C //除
#define VK_SUBTRACT       0x6D //减
#define VK_DECIMAL        0x6E //小数点
#define VK_DIVIDE         0x6F
#define VK_F1             0x70 //功能键F1-F24
#define VK_F2             0x71
#define VK_F3             0x72
#define VK_F4             0x73
#define VK_F5             0x74
#define VK_F6             0x75
#define VK_F7             0x76
#define VK_F8             0x77
#define VK_F9             0x78
#define VK_F10            0x79
#define VK_F11            0x7A
#define VK_F12            0x7B
#define VK_F13            0x7C
#define VK_F14            0x7D
#define VK_F15            0x7E
#define VK_F16            0x7F
#define VK_F17            0x80
#define VK_F18            0x81
#define VK_F19            0x82
#define VK_F20            0x83
#define VK_F21            0x84
#define VK_F22            0x85
#define VK_F23            0x86
#define VK_F24            0x87
#define VK_NUMLOCK        0x90 //Num Lock 键
#define VK_SCROLL         0x91 //Scroll Lock 键
/*
* VK_L* & VK_R* - left and right Alt, Ctrl and Shift virtual keys.
* Used only as parameters to GetAsyncKeyState() and GetKeyState().
* No other API or message will distinguish left and right keys in this way.
*/
#define VK_LSHIFT          0xA0
#define VK_RSHIFT          0xA1
#define VK_LCONTROL        0xA2
#define VK_RCONTROL        0xA3
#define VK_LMENU           0xA4
#define VK_RMENU           0xA5

#if(WINVER >= 0x0400)
#define VK_PROCESSKEY      0xE5
#endif /* WINVER >= 0x0400 */

#define VK_ATTN            0xF6
#define VK_CRSEL           0xF7
#define VK_EXSEL           0xF8
#define VK_EREOF           0xF9
#define VK_PLAY            0xFA
#define VK_ZOOM            0xFB
#define VK_NONAME          0xFC
#define VK_PA1             0xFD
#define VK_OEM_CLEAR       0xFE
}
#endif
