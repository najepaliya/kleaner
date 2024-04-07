import "../"

import org.kde.kirigami as K
import QtQuick as Q
import QtQuick.Controls as QC
import QtQuick.Dialogs as QD
import QtQuick.Layouts as QL

import io.github.najepaliya.kleaner.backend

AbstractView {
    id: root

    QD.FileDialog {
        id: fileDialog

        fileMode: QD.FileDialog.OpenFiles
        onAccepted: Backend.fileModel.addFiles(fileDialog.selectedFiles)
    }
    
    viewHeaderRow: QL.RowLayout {
        Q.Text {
            text: "Files"
            QL.Layout.fillWidth: true
        }

        QC.ToolButton {
            icon.name: "edit-clear-history"
            onClicked: Backend.fileModel.removeAllFiles()
        }

        QC.ToolButton {
            icon.name: "list-add"
            onClicked: fileDialog.open()
        }
    }

    viewModel: Backend.fileModel

    viewItemRow: QL.RowLayout {
        Q.Text {
            text: viewModel.display
            QL.Layout.fillWidth: true
        }

        QC.ToolButton {
            icon.name: "edit-delete"
            onClicked: Backend.fileModel.removeFile(viewModel.index)
        }
    }
}