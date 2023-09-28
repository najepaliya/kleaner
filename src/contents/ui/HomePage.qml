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
                var result = Kleaner.processFiles()
                resultMessage.text = result
                resultMessage.visible = true
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        Kirigami.InlineMessage {
            id: resultMessage
            Layout.fillWidth: true
            type: Kirigami.MessageType.Positive
            text: ""
            visible: false
        }

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            type: Kirigami.MessageType.Warning
            text: "Custom user templates are a work in progress. The default template removes all EXIF, IPTC, XMP and Comments metadata."
            visible: true
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
                            Kleaner.fileModel.removeFile(index, index)
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
                    
                    ListElement {
                        name: "Remove all metadata"
                        checked: true
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