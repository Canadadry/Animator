#include <QtGui/QGuiApplication>
#include <QApplication>
#include "qtquick2applicationviewer.h"
#include <qqml.h>
#include "fileio.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<FileIO>("IO",1,0,"FileIO");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/Animator/Main.qml"));
    viewer.showExpanded();

    return app.exec();
}
