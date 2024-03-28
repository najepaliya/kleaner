import QtQuick.Dialogs as D
import "FileViewUtilities.js" as U
import io.github.najepaliya.kleaner

AbstractView {
    viewTitle: "Files"
    viewModel: Backend.fileModel
    headerButtonList: U.headerButtonList
    rowButtonList: U.rowButtonList

    D.FileDialog {
        id: fileDialog
        fileMode: D.FileDialog.OpenFiles
        onAccepted: U.addFiles()
    }
}