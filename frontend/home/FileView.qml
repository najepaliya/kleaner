import QtQuick.Dialogs as D
import "FileViewFunctions.js" as F
import io.github.najepaliya.kleaner

AbstractView {
    D.FileDialog {
        id: fileDialog
        fileMode: D.FileDialog.OpenFiles
        onAccepted: F.addFiles
    }

    viewTitle: "Files"
    viewModel: Backend.fileModel

    headerButtonList: [
        {
            icon: "edit-clear-history",
            function: F.removeAllFiles
        },
        {
            icon: "list-add",
            function: F.openFileDialog
        }
    ]
    
    rowButtonList: [
        {
            icon: "edit-delete",
            function: F.removeFile
        }
    ]

}