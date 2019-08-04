#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <QGuiApplication>
#include <QQmlAspectEngine>
#include <QQmlContext>
#include "Tools.h"

int main(int argc, char* argv[]) {
    QGuiApplication app(argc, argv);
    Qt3DExtras::Quick::Qt3DQuickWindow view;

	Tools* myObject = new Tools();
	view.engine()->qmlEngine()->rootContext()->setContextProperty("tools", myObject);

    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    return app.exec();
}
