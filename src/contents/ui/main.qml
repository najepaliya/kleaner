import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ApplicationWindow {
    title: "Kleaner"
    height: 800
    width: 500

    ListModel {
        id: fileModel
    }

    FileDialog {
        id: fileDialog
        title: "Please choose your file(s)"
        folder: shortcuts.home
        // selectFolder: true
        selectMultiple: true
        onAccepted: {
            for (var i = 0; i < fileUrls.length; i++)
                fileModel.append({name: fileUrls[i].slice(7)})
        }
        // onRejected: {
        //     console.log("Canceled")
        //     Qt.quit()
        // }
        Component.onCompleted: visible = false
    }

    pageStack.initialPage: InitialPage {}
}