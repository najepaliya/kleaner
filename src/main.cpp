#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QUrl>
#include <QQuickStyle>
#include <KLocalizedContext>
#include <KLocalizedString>
#include <Kleaner.hpp>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    KLocalizedString::setApplicationDomain("kleaner");
    QCoreApplication::setOrganizationName(QStringLiteral("KDE"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("kde.org"));
    QCoreApplication::setApplicationName(QStringLiteral("Kleaner"));

    QGuiApplication::setDesktopFileName("io.github.najepaliya.kleaner.desktop");

    QQuickStyle::setStyle("org.kde.desktop");

    QQmlApplicationEngine engine;

    Kleaner kleaner;
    qmlRegisterSingletonInstance<Kleaner>("io.github.najepaliya.kleaner", 1, 0, "Kleaner", &kleaner);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}