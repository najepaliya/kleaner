// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2024 Neel Jepaliya <najepaliya@gmail.com>

#pragma once

#include <QObject>
#include <QQmlEngine>

class QQuickWindow;

class App : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    // Restore current window geometry
    Q_INVOKABLE void restoreWindowGeometry(QQuickWindow *window, const QString &group = QStringLiteral("main")) const;
    // Save current window geometry
    Q_INVOKABLE void saveWindowGeometry(QQuickWindow *window, const QString &group = QStringLiteral("main")) const;
};
