import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0
import io.github.najepaliya.kleaner 1.0

Kirigami.Page {
    title: i18n("Home")

    actions.main: Kirigami.Action {
        text: i18n("Process file(s)")
        displayHint: Kirigami.DisplayHint.IconOnly
        icon.name: "media-playback-start"
        enabled: fileView.count > 0 ? true : false
        onTriggered: {
            var template = radioGroup.checkedButton.name
            var result = Kleaner.processFiles(radioGroup.checkedButton.index);
            resultMessage.text = i18n("Template \"%1\" applied to %2 file(s) with %3 metadata clearing/saving failure(s) and %4 metadata loading failure(s).", template, result.total, result.failures, result.unknown);
            resultMessage.visible = true
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Kirigami.Units.gridUnit

        Kirigami.InlineMessage {
            Layout.fillWidth: true
            type: Kirigami.MessageType.Warning
            text: i18n("Custom user templates are a work in progress.")
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
                    text: i18n("Clear file list")
                    onTriggered: {
                        Kleaner.fileModel.removeFiles(0, fileView.count)
                        resultMessage.visible = false
                    }
                }
            ]
        }

        Controls.ScrollView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: parent.height / 2

            ListView {
                id: fileView
                currentIndex: -1
                clip: true
                model: Kleaner.fileModel
                delegate: Kirigami.BasicListItem {
                    onClicked: {
                        fileView.currentIndex = -1
                    }
                    rightPadding: Kirigami.Units.gridUnit
                    
                    Controls.Label {
                        text: display
                        Layout.fillWidth: true
                        elide: Text.ElideMiddle
                        Controls.ToolTip.text: display
                        Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                        Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                    }

                    Controls.Button {
                        text: i18n("Remove file")
                        display: Controls.AbstractButton.IconOnly
                        Controls.ToolTip.text: text
                        Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? pressed : hovered
                        Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                        icon.name: "edit-delete"
                        flat: true
                        onClicked: {
                            Kleaner.fileModel.removeFiles(index, index)
                        }
                    }
                }
                header: Controls.ToolBar {
                    width: ListView.view.width
                    leftPadding: Kirigami.Units.gridUnit
                    rightPadding: Kirigami.Units.gridUnit
                    z: 2
                    
                    FileDialog {
                        id: fileDialog
                        title: i18n("Please choose your file(s)")
                        folder: shortcuts.pictures
                        selectMultiple: true
                        onAccepted: {
                            var filtered = Kleaner.filterInput(fileUrls)
                            if (filtered) {
                                applicationWindow().showPassiveNotification("Some files have been filtered due to incompatability")
                            }
                        }
                        Component.onCompleted: visible = false
                    }
                    
                    RowLayout {
                        width: parent.width

                        Controls.Label {
                            text: i18n("Files")
                            elide: Text.ElideMiddle
                            Controls.ToolTip.text: text
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                            Layout.fillWidth: true
                        }

                        Controls.ToolButton {
                            text: i18n("Add file(s)")
                            display: Controls.AbstractButton.IconOnly
                            Controls.ToolTip.text: text
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? pressed : hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                            icon.name: "list-add"
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
                    text: i18n("Select files to continue")
                }
            }
        }

        Controls.ScrollView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: parent.height / 2

            ListView {
                id: templateView
                currentIndex: -1
                clip: true
                model: ListModel {
                    Component.onCompleted: {
                        append({ name: i18n("Clear all EXIF"), checked: true });
                        append({ name: i18n("Clear all IPTC"), checked: false });
                        append({ name: i18n("Clear all XMP"), checked: false });
                        append({ name: i18n("Clear all comments"), checked: false });
                    }
                }

                Controls.ButtonGroup {
                    id: radioGroup
                }

                delegate: Kirigami.BasicListItem {
                    onClicked: {
                        radioGroup.buttons[index].checked = true
                        templateView.currentIndex = -1
                    }
                    rightPadding: Kirigami.Units.gridUnit

                    Controls.RadioButton {
                        property string name: model.name
                        property int index: model.index
                        checked: model.checked
                        Controls.ButtonGroup.group: radioGroup
                    }

                    Controls.Label {
                        Layout.fillWidth: true
                        text: model.name
                        elide: Text.ElideMiddle
                        Controls.ToolTip.text: text
                        Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                        Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                    }

                    Controls.Button {
                        text: i18n("Remove template")
                        display: Controls.AbstractButton.IconOnly
                        Controls.ToolTip.text: text
                        Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? pressed : hovered
                        Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                        icon.name: "edit-delete"
                        flat: true
                        enabled: index < 4 ? false : true
                    }
                }
                header: Controls.ToolBar {
                    width: ListView.view.width
                    leftPadding: Kirigami.Units.gridUnit
                    rightPadding: Kirigami.Units.gridUnit
                    z: 2
                    
                    RowLayout {
                        width: parent.width

                        Controls.Label {
                            text: i18n("Templates")
                            elide: Text.ElideMiddle
                            Controls.ToolTip.text: text
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                            Layout.fillWidth: true
                        }

                        // implement custom user templates
                        Controls.ToolButton {
                            text: i18n("Add template")
                            display: Controls.AbstractButton.IconOnly
                            Controls.ToolTip.text: text
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? pressed : hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                            icon.name: i18n("list-add")
                            enabled: false
                        }
                    }
                }
                headerPositioning: ListView.OverlayHeader
            }
        }
    }
}
