#include "joytools.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    joyTools w;
    w.show();
    return a.exec();
}
