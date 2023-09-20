import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ScrollablePage {
    title: i18n("Templates")
    
    actions.main: Kirigami.Action {
        icon.name: "list-add"
        tooltip: "Add templates"
        onTriggered: {
            console.log("creating template")
        }
    }

    Controls.ButtonGroup { id: templateRadioGroup }

    ListModel {
        id: templateModel

        ListElement {
            name: "Delete everything"
            checked: false
        }

        ListElement {
            name: "Custom 1"
            checked: false
        }

        ListElement {
            name: "Custom 2"
            checked: false
        }
    }

    Component {
        id: templateDelegate
        Kirigami.BasicListItem {
            activeBackgroundColor: "lightblue"
            Controls.RadioButton {
                Layout.fillWidth: true
                text: model.name
                checked: model.checked
                Controls.ButtonGroup.group: templateRadioGroup
                onClicked: {
                    templateView.currentIndex = index
                }
            }
            Controls.Button {
                flat: true
                icon.name: "document-edit"
                visible: containsMouse ? true : false
                enabled: model.index != 0 ? true : false
            }
            Controls.Button {
                flat: true
                icon.name: "edit-delete"
                visible: containsMouse ? true : false
                enabled: model.index != 0 ? true : false
                onClicked: {
                    var template = templateModel.get(index)
                    applicationWindow().showPassiveNotification("Removed " + template.name, 1000)
                    templateModel.remove(index)
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: templateView
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: templateModel
            delegate: templateDelegate
            currentIndex: -1
        }
    }
}