import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0


Kirigami.ScrollablePage {
    title: i18n("Files")

    ListModel {
        id: fileModel
    }

    // look into multiple selection w/ folders and sanitize input rather than static slicing
    FileDialog {
        id: fileDialog
        title: "Please choose your file(s)"
        folder: shortcuts.home
        selectMultiple: true
        onAccepted: {
            for (var i = 0; i < fileUrls.length; i++)
                fileModel.append({name: fileUrls[i].slice(7)})
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

    // undo function may not be necessary
    // function undo() {
    //             console.log("abc")
    //             // fileModel.insert(file.index, {"name": file.name})
    //         } 

    Component {
        id: fileDelegate

        Kirigami.BasicListItem {
            activeBackgroundColor: "lightblue"
            Controls.Label {
                Layout.fillWidth: true
                elide: Text.ElideLeft
                text: model.name
            }
            

            // maybe i do not need undo
            Controls.Button {
                id: undoButton
                flat: true
                icon.name: "edit-delete"
                visible: containsMouse ? true : false
                onClicked: {
                    var file = fileModel.get(index)
                    // applicationWindow().showPassiveNotification("Removed " + file.name, 4000, "Undo", undo(fileModel.get(index)))
                    // removalMessage.text = "Removed " + file.name
                    // removalMessage.removedIndex = index
                    applicationWindow().showPassiveNotification("Removed " + file.name, 1000)
                    fileModel.remove(index)
                    // removalMessage.visible = true
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: fileView
            // height: parent.height
            // width: parent.width
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: fileDelegate
            model: fileModel
        }
    }
}