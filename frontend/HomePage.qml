import org.kde.kirigami as K
import QtQuick.Layouts as L

K.Page {
    title: "Home"

    L.ColumnLayout {
        anchors.fill: parent
        spacing: K.Units.gridUnit

        FileView {}
        
        // TemplateView {}
    }
}