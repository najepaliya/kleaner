import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0
import com.github.najepaliya.kleaner 1.0

Kirigami.Page {
    title: i18n("Home")

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Controls.GroupBox {
            Layout.fillHeight: true
            Layout.fillWidth: true

            ListView {
                anchors.fill: parent
                clip: true
                model: Kleaner.fileModel
                delegate: Kirigami.BasicListItem {
                    activeBackgroundColor: "lightblue"
                    
                    Controls.Label {
                        text: i18n(display)
                        Layout.fillWidth: true
                        elide: Text.ElideLeft
                    }

                    Controls.Button {
                        icon.name: "edit-delete"
                        flat: true
                        onClicked: {
                            var filename = Kleaner.fileModel.removeFile(index)
                            applicationWindow().showPassiveNotification("Removed " + filename, 1000)
                        }
                    }
                }
                header: Controls.ToolBar {
                    
                    FileDialog {
                        id: fileDialog
                        title: "Please choose your file(s)"
                        folder: shortcuts.home
                        selectMultiple: true
                        onAccepted: {
                            Kleaner.fileModel.insertFiles (fileUrls)
                        }
                        Component.onCompleted: visible = false
                    }
                    
                    width: ListView.view.width
                    leftPadding: 16
                    rightPadding: 8
                    z: 2
                    
                    RowLayout {
                        width: parent.width

                        Controls.Label {
                            text: i18n("Files")
                            Layout.fillWidth: true
                        }

                        Controls.Button {
                            icon.name: "list-add"
                            flat: true
                            onClicked: {
                                fileDialog.open()
                            }
                        }
                    }
                }
                headerPositioning: ListView.OverlayHeader
            }
        }

        Controls.GroupBox {
            Layout.fillHeight: true
            Layout.fillWidth: true

            ListView {
                id: templateView
                anchors.fill: parent
                clip: true
                model: ListModel {
                    
                    ListElement {
                        name: "Remove all metadata"
                        checked: true
                    }

                    ListElement {
                        name: "Custom user template"
                        checked: false
                    }
                }

                Controls.ButtonGroup {
                    id: radioGroup
                }

                delegate: Kirigami.BasicListItem {
                    activeBackgroundColor: "lightblue"

                    Controls.RadioButton {
                        Layout.fillWidth: true
                        text: model.name
                        checked: model.checked
                        Controls.ButtonGroup.group: radioGroup
                        onClicked: {
                            templateView.currentIndex = index
                        }
                    }

                    Controls.Button {
                        icon.name: "edit-delete"
                        flat: true
                        enabled: index == 0 ? false : true
                    }
                }
                header: Controls.ToolBar {
                    width: ListView.view.width
                    leftPadding: 16
                    rightPadding: 8
                    z: 2
                    
                    RowLayout {
                        width: parent.width

                        Controls.Label {
                            text: i18n("Templates")
                            Layout.fillWidth: true
                        }

                        Controls.Button {
                            icon.name: "list-add"
                            flat: true
                        }
                    }
                }
                headerPositioning: ListView.OverlayHeader
            }
        }
    }
}