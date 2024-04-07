import org.kde.kirigami as K
import QtQuick.Layouts as QL

K.Page {
    title: "Home"
    QL.ColumnLayout {
        anchors.fill: parent
        spacing: K.Units.gridUnit
        FileView {}
    }
}