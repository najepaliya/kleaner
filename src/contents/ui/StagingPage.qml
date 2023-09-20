import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ScrollablePage {
    title: i18n("Staging")
    
    property int fileCount: 0
    property string template: "N/A"

    Column {
        anchors.fill: parent
        spacing: 20

        Controls.Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n(fileCount)
            font.pixelSize: 64
        }

        Controls.Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n("Files")
            font.pixelSize: 32
        }

        Kirigami.Separator {
            width: parent.width
        }

        Controls.Label {
            width: parent.width
            // Layout.fillWidth: true
            anchors.horizontalCenter: parent.horizontalCenter
            text: template
            font.pixelSize: 64
            wrapMode: Text.WordWrap
        }

        Controls.Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n("Template")
            font.pixelSize: 32
        }
    }
}