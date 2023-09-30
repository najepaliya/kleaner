import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0
import com.github.najepaliya.kleaner 1.0

Kirigami.Page {
    title: i18n("Home")

    actions.main: Kirigami.Action {
        displayComponent: Controls.Button {
            icon.name: "media-playback-start"
            enabled: fileView.count > 0 ? true : false
            flat: true
            onClicked: {
                resultMessage.text = "Template \"" + templateModel.get(templateView.currentIndex).name + "\" applied to " + Kleaner.processFiles(templateView.currentIndex)
                resultMessage.visible = true
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            type: Kirigami.MessageType.Warning
            text: "Custom user templates are a work in progress."
            visible: true
        }

        Kirigami.InlineMessage {
            id: resultMessage
            Layout.fillWidth: true
            type: Kirigami.MessageType.Positive
            text: ""
            visible: false
            showCloseButton: true
            actions: [
                Kirigami.Action {
                    text: "Clear file list"
                    onTriggered: {
                        Kleaner.fileModel.removeFiles(0, fileView.count)
                    }
                }
            ]
        }

        Controls.GroupBox {
            Layout.fillHeight: true
            Layout.fillWidth: true

            ListView {
                id: fileView
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
                            Kleaner.fileModel.removeFiles(index, index)
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
                            var filtered = Kleaner.filterInput(fileUrls)
                            if (filtered) {
                                applicationWindow().showPassiveNotification("Some files have been filtered due to incompatability")
                            }
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

                Kirigami.PlaceholderMessage {
                    anchors.centerIn: parent
                    width: parent.width - Kirigami.Units.largeSpacing * 4
                    visible: fileView.count == 0
                    text: "Select files to continue"
                }
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
                    id: templateModel
                    
                    ListElement {
                        name: "Clear all EXIF"
                        checked: true
                    }

                    ListElement {
                        name: "Clear all IPTC"
                        checked: false
                    }

                    ListElement {
                        name: "Clear all XMP"
                        checked: false
                    }

                    ListElement {
                        name: "Clear all comments"
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
                        enabled: index < 4 ? false : true
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

                        // implement custom user templates
                        Controls.Button {
                            icon.name: "list-add"
                            flat: true
                            enabled: false
                        }
                    }
                }
                headerPositioning: ListView.OverlayHeader
            }
        }
    }
}