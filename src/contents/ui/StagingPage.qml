import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ScrollablePage {
    title: i18n("Staging")
    property int fileCount: 0

    Column {
        Controls.Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n(fileCount + " files")
            font.pixelSize: 64
        }
    }
}