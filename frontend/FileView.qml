import QtQuick.Controls as C
import QtQuick.Dialogs as D
import "FileViewFunctions.js" as F
import org.kde.kirigami as K
import QtQuick.Layouts as L
import QtQuick as Q
import io.github.najepaliya.kleaner.backend

AbstractView {
    id: root

    D.FileDialog {
        id: fileDialog
        fileMode: D.FileDialog.OpenFiles
        onAccepted: F.addFiles()
    }

    viewHeaderTitle: "Files"
    
    viewHeaderButtonList: [
        {
            icon: "edit-clear-history",
            function: F.removeAllFiles
        },
        {
            icon: "list-add",
            function: F.openFileDialog
        }
    ]

    viewModel: Backend.fileModel

    viewItemDelegate: C.ItemDelegate {
        id: itemDelegate

        height: root.rowHeight
        width: root.viewList.contentItem.width

        L.RowLayout {
            height: itemDelegate.height
            width: itemDelegate.width - 2 * K.Units.gridUnit
            anchors.horizontalCenter: itemDelegate.horizontalCenter

            Q.Text {
                text: model.display
                L.Layout.fillWidth: true
            }

            ButtonRow {
                buttonList: [
                    {
                        icon: "edit-delete",
                        function: F.removeFile
                    }
                ]
            }
        }
    }
}