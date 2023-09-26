import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0
import com.github.najepaliya.kleaner 1.0

Kirigami.ScrollablePage {
    title: i18n("Files")

    property alias fileCount: fileView.count

    // look into multiple selection w/ folders and sanitize input rather than static slicing
    FileDialog {
        id: fileDialog
        title: "Please choose your file(s)"
        folder: shortcuts.home
        selectMultiple: true
        onAccepted: {
            FileModel.insertFiles (fileUrls)
        }
        Component.onCompleted: visible = false
    }

    actions.main: Kirigami.Action {
        icon.name: "list-add"
        tooltip: "Add files"
        onTriggered: {
            fileDialog.open()
        }
    }

    Component {
        id: fileDelegate

        Kirigami.BasicListItem {
            activeBackgroundColor: "lightblue"

            Controls.Label {
                Layout.fillWidth: true
                elide: Text.ElideLeft
                text: display
            }
            
            Controls.Button {
                flat: true
                icon.name: "edit-delete"
                visible: containsMouse ? true : false
                onClicked: {
                    var filename = FileModel.removeFile(index)
                    applicationWindow().showPassiveNotification("Removed " + filename, 1000)
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: fileView
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: fileDelegate
            model: FileModel
        }
    }
}