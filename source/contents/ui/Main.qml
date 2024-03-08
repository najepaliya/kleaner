// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2024 Neel Jepaliya <najepaliya@gmail.com>

import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import io.github.najepaliya.kleaner

Kirigami.ApplicationWindow {
    id: root

    title: i18n("kleaner")

    minimumWidth: Kirigami.Units.gridUnit * 20
    minimumHeight: Kirigami.Units.gridUnit * 20

    onClosing: App.saveWindowGeometry(root)

    onWidthChanged: saveWindowGeometryTimer.restart()
    onHeightChanged: saveWindowGeometryTimer.restart()
    onXChanged: saveWindowGeometryTimer.restart()
    onYChanged: saveWindowGeometryTimer.restart()

    Component.onCompleted: App.restoreWindowGeometry(root)

    // This timer allows to batch update the window size change to reduce
    // the io load and also work around the fact that x/y/width/height are
    // changed when loading the page and overwrite the saved geometry from
    // the previous session.
    Timer {
        id: saveWindowGeometryTimer
        interval: 1000
        onTriggered: App.saveWindowGeometry(root)
    }

    property int counter: 0

    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: !Kirigami.Settings.isMobile
        actions: [
            Kirigami.Action {
                text: i18n("Plus One")
                icon.name: "list-add"
                onTriggered: root.counter += 1
            },
            Kirigami.Action {
                text: i18n("About kleaner")
                icon.name: "help-about"
                onTriggered: root.pageStack.pushDialogLayer("qrc:About.qml")
            },
            Kirigami.Action {
                text: i18n("Quit")
                icon.name: "application-exit"
                onTriggered: Qt.quit()
            }
        ]
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    pageStack.initialPage: page

    Kirigami.Page {
        id: page

        title: i18n("Main Page")

        actions: [
            Kirigami.Action {
                text: i18n("Plus One")
                icon.name: "list-add"
                tooltip: i18n("Add one to the counter")
                onTriggered: root.counter += 1
            }
        ]

        ColumnLayout {
            width: page.width

            anchors.centerIn: parent

            Kirigami.Heading {
                Layout.alignment: Qt.AlignCenter
                text: root.counter === 0 ? i18n("Hello, World!") : root.counter
            }

            Controls.Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n("+ 1")
                onClicked: root.counter += 1
            }
        }
    }
}
