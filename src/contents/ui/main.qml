import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ApplicationWindow {
    title: "Kleaner"

    ListModel {
        id: fileModel
    }

    FileDialog {
        id: fileDialog
        title: "Please choose your file(s)"
        folder: shortcuts.home
        // selectFolder: true
        selectMultiple: true
        onAccepted: {
            for (var i = 0; i < fileUrls.length; i++)
                fileModel.append({name: fileUrls[i].slice(7)})
        }
        // onRejected: {
        //     console.log("Canceled")
        //     Qt.quit()
        // }
        Component.onCompleted: visible = false
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18n("Files")

        actions.main: Kirigami.Action {
            icon.name: "list-add"
            text: i18n("Add")
            onTriggered: {
                fileDialog.open()
            }
        }

        Component {
            id: fileDelegate

            Kirigami.BasicListItem {
                
                Controls.Label {
                    Layout.fillWidth: true
                    text: model.name
                }

                Controls.Button {
                    id: undoButton
                    flat: true
                    icon.name: "edit-delete"
                    visible: containsMouse ? true : false
                    onClicked: {
                        var file = fileModel.get(index)
                        removalMessage.text = "Removed " + file.name
                        removalMessage.removedIndex = index
                        fileModel.remove(index)
                        removalMessage.visible = true
                    }
                }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 20

            Kirigami.InlineMessage {
                id: removalMessage
                Layout.fillWidth: true
                showCloseButton: true
                visible: false
                type: Kirigami.MessageType.Warning
                property int removedIndex
                actions: [
                    Kirigami.Action {
                        icon.name: "edit-undo"
                        text: i18n("Undo")
                        onTriggered: {
                            fileModel.insert(removalMessage.removedIndex, {"name": removalMessage.text.slice(8)})
                            removalMessage.visible = false
                        }
                    }
                ]
            }

            ListView {
                id: fileView
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true
                delegate: fileDelegate
                model: fileModel
                // property int removedIndex: 0
            }
        }
    }
}