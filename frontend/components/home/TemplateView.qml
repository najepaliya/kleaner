import QtQuick as Q
import QtQuick.Controls as QC
import QtQuick.Layouts as QL
import org.kde.kirigami as K

Q.ListView {
    QL.Layout.fillHeight: true
    QL.Layout.fillWidth: true
    header: QC.ToolBar {
        z: 2
        width: parent.width
        horizontalPadding: K.Units.gridUnit
        QL.RowLayout {
            width: parent.width
            Q.Text {
                QL.Layout.fillWidth: true
                text: "Templates"
            }
            QC.ToolButton {
                icon.name: "list-add"
            }
        }
    }
    headerPositioning: Q.ListView.OverlayHeader
    clip: true
    id: listView
    model: 4
    delegate: QC.ItemDelegate {
        height: icon.implicitHeight
        width: parent.width
        QL.RowLayout {
            anchors.fill: parent
            Q.Text {
                text: index
                QL.Layout.fillWidth: true
                QL.Layout.leftMargin: K.Units.gridUnit
            }
            QC.ToolButton {
                icon.name: "edit-entry"
            }
            QC.ToolButton {
                id: icon
                icon.name: "edit-delete"
                QL.Layout.rightMargin: K.Units.gridUnit
            }
        }
    }
}