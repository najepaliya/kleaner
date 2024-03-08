/*
    SPDX-License-Identifier: GPL-3.0-or-later
    SPDX-FileCopyrightText: 2024 Neel Jepaliya <najepaliya@gmail.com>
*/

#include <QtGlobal>
// #ifdef Q_OS_ANDROID
// #include <QGuiApplication>
// #else
#include <QApplication>
// #endif

#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QUrl>

#include "app.h"
#include "version-kleaner.h"
#include <KAboutData>
#include <KLocalizedContext>
#include <KLocalizedString>

#include "kleanerconfig.h"

using namespace Qt::Literals::StringLiterals;

// #ifdef Q_OS_ANDROID
// Q_DECL_EXPORT
// #endif
int main(int argc, char *argv[])
{
// #ifdef Q_OS_ANDROID
//     QGuiApplication app(argc, argv);
//     QQuickStyle::setStyle(QStringLiteral("org.kde.breeze"));
// #else
    QApplication app(argc, argv);

    // Default to org.kde.desktop style unless the user forces another style
    if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE")) {
        QQuickStyle::setStyle(u"org.kde.desktop"_s);
    }
// #endif

// #ifdef Q_OS_WINDOWS
//     if (AttachConsole(ATTACH_PARENT_PROCESS)) {
//         freopen("CONOUT$", "w", stdout);
//         freopen("CONOUT$", "w", stderr);
//     }

//     QApplication::setStyle(QStringLiteral("breeze"));
//     auto font = app.font();
//     font.setPointSize(10);
//     app.setFont(font);
// #endif

    KLocalizedString::setApplicationDomain("kleaner");
    QCoreApplication::setOrganizationName(u"KDE"_s);

    KAboutData aboutData(
        // The program name used internally.
        u"kleaner"_s,
        // A displayable program name string.
        i18nc("@title", "kleaner"),
        // The program version string.
        QStringLiteral(KLEANER_VERSION_STRING),
        // Short description of what the app does.
        i18n("Application Description"),
        // The license this code is released under.
        KAboutLicense::GPL,
        // Copyright Statement.
        i18n("(c) 2024"));
    aboutData.addAuthor(i18nc("@info:credit", "Neel Jepaliya"),
                        i18nc("@info:credit", "Maintainer"),
                        u"najepaliya@gmail.com"_s,
                        u"https://yourwebsite.com"_s);
    aboutData.setTranslator(i18nc("NAME OF TRANSLATORS", "Your names"), i18nc("EMAIL OF TRANSLATORS", "Your emails"));
    KAboutData::setApplicationData(aboutData);
    QGuiApplication::setWindowIcon(QIcon::fromTheme(u"io.github.najepaliya.kleaner"_s));

    QQmlApplicationEngine engine;

    auto config = kleanerConfig::self();

    qmlRegisterSingletonInstance("io.github.najepaliya.kleaner.private", 1, 0, "Config", config);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.loadFromModule("io.github.najepaliya.kleaner", u"Main.qml");

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
