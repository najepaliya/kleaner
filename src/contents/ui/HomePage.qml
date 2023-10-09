import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0
import io.github.najepaliya.kleaner 1.0

Kirigami.Page {
    title: i18n("Home")

    actions.main: Kirigami.Action {
        text: "Process file(s)"
        displayHint: Kirigami.DisplayHint.IconOnly
        icon.name: "media-playback-start"
        enabled: fileView.count > 0 ? true : false
        onTriggered: {
            resultMessage.text = "Template \"" + radioGroup.checkedButton.name + "\" applied to " + Kleaner.processFiles(radioGroup.checkedButton.index)
            resultMessage.visible = true
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
                anchors.fill: parent
                clip: true
                model: Kleaner.fileModel
                delegate: Kirigami.BasicListItem {
                    onClicked: {
                        fileView.currentIndex = -1
                    }
                    rightPadding: 20
                    
                    Controls.Label {
                        text: display
                        Layout.fillWidth: true
                        elide: Text.ElideMiddle
                        Controls.ToolTip.text: display
                        Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                        Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                    }

                    Controls.Button {
                        text: "Remove file"
                        display: Controls.AbstractButton.IconOnly
                        Controls.ToolTip.text: "Remove file"
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
                    leftPadding: 20
                    rightPadding: 20
                    z: 2
                    
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
                    
                    RowLayout {
                        width: parent.width

                        Controls.Label {
                            text: i18n("Files")
                            elide: Text.ElideMiddle
                            Controls.ToolTip.text: i18n("Files")
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                            Layout.fillWidth: true
                        }

                        Controls.Button {
                            text: "Add file(s)"
                            display: Controls.AbstractButton.IconOnly
                            Controls.ToolTip.text: "Add file(s)"
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? pressed : hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
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

        Controls.ScrollView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: parent.height / 2

            ListView {
                id: templateView
                currentIndex: -1
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
                    onClicked: {
                        radioGroup.buttons[index].checked = true
                        templateView.currentIndex = -1
                    }
                    rightPadding: 20

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
                        Controls.ToolTip.text: model.name
                        Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                        Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                    }

                    Controls.Button {
                        text: "Remove template"
                        display: Controls.AbstractButton.IconOnly
                        Controls.ToolTip.text: "Remove template"
                        Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? pressed : hovered
                        Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                        icon.name: "edit-delete"
                        flat: true
                        enabled: index < 4 ? false : true
                    }
                }
                header: Controls.ToolBar {
                    width: ListView.view.width
                    leftPadding: 20
                    rightPadding: 20
                    z: 2
                    
                    RowLayout {
                        width: parent.width

                        Controls.Label {
                            text: i18n("Templates")
                            elide: Text.ElideMiddle
                            Controls.ToolTip.text: i18n("Templates")
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? truncated && pressed : truncated && hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
                            Layout.fillWidth: true
                        }

                        // implement custom user templates
                        Controls.Button {
                            text: "Add template"
                            display: Controls.AbstractButton.IconOnly
                            Controls.ToolTip.text: "Add template"
                            Controls.ToolTip.visible: Kirigami.Settings.tabletMode ? pressed : hovered
                            Controls.ToolTip.delay: Kirigami.Settings.tabletMode ? Qt.styleHints.mousePressAndHoldInterval : Kirigami.Units.toolTipDelay
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
