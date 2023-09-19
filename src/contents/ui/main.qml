import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ApplicationWindow {
    title: "Kleaner"
    // may need to be user configurable or detect and set sizes using some method
    height: 450 
    width: 800

    FilesPage {
        id: abc
    }

    TemplatesPage {
        id: xyz
    }

    // may need to be conditional depending on desktop or mobile
    Component.onCompleted: {
        pageStack.push([abc,xyz])
        pageStack.goBack()
    }
}