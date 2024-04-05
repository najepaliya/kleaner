import "../"

import org.kde.kirigami as K
import QtQuick as Q
import QtQuick.Controls as QC
import QtQuick.Dialogs as QD
import QtQuick.Layouts as QL

import io.github.najepaliya.kleaner.backend
import "FileViewFunctions.js" as F

AbstractView {
    id: root

    QD.FileDialog {
        id: fileDialog

        fileMode: QD.FileDialog.OpenFiles
        onAccepted: F.addFiles()
    }
    
    viewHeaderRow: QL.RowLayout {
        Q.Text {
            text: "Files"
            QL.Layout.fillWidth: true
        }

        QC.ToolButton {
            icon.name: "list-add"
            onClicked: F.openFileDialog()
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
        }
    }
}