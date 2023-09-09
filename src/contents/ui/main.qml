import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ApplicationWindow {
    title: "Kleaner"

    FileDialog {
        id: fileDialog
        title: "Please choose your file(s)"
        folder: shortcuts.home
        // selectFolder: true
        selectMultiple: true
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            Qt.quit()
        }
        // onRejected: {
        //     console.log("Canceled")
        //     Qt.quit()
        // }
        Component.onCompleted: visible = false
    }

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18n("Input")
        actions.main: Kirigami.Action {
            icon.name: "list-add"
            text: i18n("Add Files")
            onTriggered: {
                fileDialog.open()
            }
        }
    }
}

// Kirigami.ApplicationWindow {
//     id: root
//     height: 450
//     width: 800
//     title: i18nc("@title:window", "KMetaDataEditor")

//     ListModel {
//         id: fileModel
//         ListElement { name: "a.png"; checked: false }
//         ListElement { name: "b.png"; checked: true }
//         ListElement { name: "c.png"; checked: false }
//         ListElement { name: "d.png"; checked: true }
//         ListElement { name: "a.png"; checked: false }
//         ListElement { name: "b.png"; checked: true }
//         ListElement { name: "c.png"; checked: false }
//         ListElement { name: "d.png"; checked: true }
//         ListElement { name: "a.png"; checked: false }
//         ListElement { name: "b.png"; checked: true }
//         ListElement { name: "c.png"; checked: false }
//         ListElement { name: "d.png"; checked: true }
//         ListElement { name: "a.png"; checked: false }
//         ListElement { name: "b.png"; checked: true }
//         ListElement { name: "c.png"; checked: false }
//         ListElement { name: "d.png"; checked: true }
//         ListElement { name: "a.png"; checked: false }
//         ListElement { name: "b.png"; checked: true }
//         ListElement { name: "c.png"; checked: false }
//         ListElement { name: "d.png"; checked: true }
//         ListElement { name: "a.png"; checked: false }
//         ListElement { name: "b.png"; checked: true }
//         // ListElement { name: "c.png"; checked: false }
//         // ListElement { name: "d.png"; checked: true }
//         // ListElement { name: "a.png"; checked: false }
//         // ListElement { name: "b.png"; checked: true }
//         // ListElement { name: "c.png"; checked: false }
//         // ListElement { name: "d.png"; checked: true }
//     }

//     Component {
//         id: fileDelegate
//         Kirigami.BasicListItem {
//             width: parent.width - 24
//             Controls.CheckBox {
//                 id: cb
//                 anchors.left: parent.left
//                 checked: model.checked
//             }
//             Text {
//                 anchors.left: cb.right
//                 text: model.name
//             }
//         }
//     }



//     FileDialog {
//     id: fileDialog
//     title: "Please choose a file"
//     folder: shortcuts.home
//     // selectFolder: true
//     selectMultiple: true
//     onAccepted: {
//         console.log("You chose: " + fileDialog.fileUrls)
//         Qt.quit()
//     }
//     // onRejected: {
//     //     console.log("Canceled")
//     //     Qt.quit()
//     // }
//     Component.onCompleted: visible = false
//     }

//     pageStack.initialPage: Kirigami.Page {
//         // title: i18nc("@title", "Kountdown")

//         RowLayout {
//             anchors.fill: parent
//             spacing: 20
            
//             ColumnLayout {
//                 Layout.fillHeight: true
//                 Layout.fillWidth: true
//                 // Controls.Label {
//                 //     // Layout.fillWidth: true
//                 //     // level: 1
//                 //     text: i18n("Files")
//                 // }
//                 Controls.GroupBox {
//                     // title: "files"
//                     Layout.fillHeight: true
//                     Layout.fillWidth: true
//                     ListView {
//                         // Layout.fillHeight: true
//                         // Layout.fillWidth: true
//                         height: parent.height
//                         width: parent.width
//                         model: fileModel
//                         delegate: fileDelegate
//                         header: headerDelegate
//                         headerPositioning: ListView.OverlayHeader
//                         clip: true
//                         Controls.ScrollBar.vertical: Controls.ScrollBar {
//                             // anchors.top: ListView.view.top
//                         }
//                     }
//                 }
//             }

//             Kirigami.Separator {
//                 Layout.fillHeight: true
//             }

//             ColumnLayout {
//                 Layout.fillHeight: true
//                 Layout.fillWidth: true
//                 // Controls.Label {
//                 //     width: 50
//                 //     // level: 1
//                 //     text: i18n("Templates")
//                 // }
//                 Controls.GroupBox {
//                     Layout.fillHeight: true
//                     Layout.fillWidth: true
//                     Layout.minimumWidth: 300
//                     Layout.maximumWidth: 500
//                     ListView {
//                         // Layout.fillHeight: true
//                         // Layout.fillWidth: true
//                         contentWidth: 400
//                         height: parent.height
//                         width: parent.width
//                         model: fileModel
//                         delegate: fileDelegate
//                         header: headerDelegate
//                         headerPositioning: ListView.OverlayHeader
//                         clip: true
//                         Controls.ScrollBar.vertical: Controls.ScrollBar {
//                             anchors.top: ListView.view.top
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }