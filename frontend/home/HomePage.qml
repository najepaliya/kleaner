import org.kde.kirigami as K
import QtQuick.Layouts as QL
import io.github.najepaliya.kleaner
import QtQuick.Dialogs as D

K.Page {
    title: "Home"

    QL.ColumnLayout {
        anchors.fill: parent
        spacing: K.Units.gridUnit

        FileView {}

        TemplateView {}
    }
}