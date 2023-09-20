import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Dialogs 1.0

Kirigami.ApplicationWindow {
    title: "Kleaner"
    // may need to be user configurable or detect and set sizes using some method
    height: 800 
    width: 450

    FilePage {
        id: filePage
    }

    TemplatePage {
        id: templatePage
    }

    StagingPage {
        id: stagingPage
        fileCount: filePage.fileCount
        selectedTemplate: templatePage.selectedTemplate
    }

    // may need to be conditional depending on desktop or mobile
    Component.onCompleted: {
        pageStack.push([filePage,templatePage,stagingPage])
        pageStack.goBack()
        pageStack.goBack()
    }
}