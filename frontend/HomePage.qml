import org.kde.kirigami as K
import QtQuick.Layouts as QL
import "./file_view"

K.Page {
    title: "Home"
    QL.ColumnLayout {
        anchors.fill: parent
        spacing: K.Units.gridUnit
        FileView {}
    }
}